/**
 * 
 */
package com.partner.busi.back.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.back.validator.IntroduceValidator;
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
	public void list(){
		List<Introduce> list = Introduce.dao.find("select * from t_introduce");
		setAttr("list", list);
		render("list.jsp");
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
