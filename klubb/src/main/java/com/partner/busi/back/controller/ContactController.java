/**
 * 
 */
package com.partner.busi.back.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.back.util.BackSessionUtil;
import com.partner.busi.back.validator.IntroduceValidator;
import com.partner.busi.model.Contact;
import com.partner.busi.model.Introduce;

/** 
 * @ClassName: ContactController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
@ControllerBind(controllerKey="/back/contact",viewPath="/back/contact")
public class ContactController extends Controller {
	
	private final static Integer pageSize = 10; //每页显示数量
	
	public void index(){
		render("contact_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void search(){
		String catStr = getPara("catStr");
		int pageNum = getParaToInt("pageNum");
		
		Page<Contact> page = Contact.dao.search(catStr, pageNum, pageSize);
		renderJson(page);
	}
	
	/**
	 * 获取介绍编辑页面
	 */
	public void edit(){
		String type = getPara("type");
		Introduce intro = Introduce.dao.findById(type);
		setAttr("intro", intro);
		render("edit.jsp");
	}
	
	/**
     * 新闻 新增/更新
     */
    @Before(IntroduceValidator.class)
	public void saveOrUpdate(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Introduce intro = getModel(Introduce.class);
		
		intro.set("CREATE_TIME", new Date());
		intro.set("CREATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
		rsFlag = intro.update();
		
		if(rsFlag){ //保存成功
			rsMsg = "保存成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
    
}
