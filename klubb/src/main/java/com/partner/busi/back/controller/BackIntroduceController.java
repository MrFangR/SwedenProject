/**
 * 
 */
package com.partner.busi.back.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.back.validator.IntroduceValidator;
import com.partner.busi.model.Contact;
import com.partner.busi.model.Introduce;
import com.partner.common.util.BackSessionUtil;

/** 
 * @ClassName: IntroduceController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
public class BackIntroduceController extends Controller {
	
	/**
	 * 介绍可编辑列表
	 */
	public void index(){
		render("introduce/intro_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		List<Introduce> list = Introduce.dao.find("select * from t_introduce where id < 3");
		setAttr("list", list);
		render("introduce/intro_list_result.jsp");
	}
	
	/**
	 * 获取介绍编辑页面
	 */
	public void edit(){
		String type = getPara("type");
		Introduce introduce = Introduce.dao.findById(type);
		setAttr("introduce", introduce);
		render("introduce/intro_edit.jsp");
	}
	
	/**
     * 新闻 新增/更新
     */
    @Before(IntroduceValidator.class)
	public void saveOrUpdate(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		String type = getPara("type");
		Introduce intro = getModel(Introduce.class);
		
		intro.set("CREATE_TIME", new Date());
		intro.set("CREATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
		rsFlag = intro.update();
		if(rsFlag && "2".equals(type)){ //发布
			Introduce intro1 = Introduce.dao.findById(intro.getID() + 2);
			intro1.set("CREATE_TIME", new Date());
			intro1.set("CREATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
			intro1.setCONTENT(intro.getCONTENT());
			rsFlag = intro.update();
		}
		
		if(rsFlag){ //保存成功
			rsMsg = "保存成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
    
}
