package com.partner.busi.back.controller;

import com.jfinal.core.Controller;

/**
 * 后台管理系统 首页相关controller
 * @author: YangKai
 */
public class BackMainController extends Controller {
	/**
	 * 后台页面框架初始化
	 */
	public void init(){
		render("backPanel.jsp");
	}
	
	/**
	 * 后台首页
	 */
	public void index(){
		render("backMain.jsp");
	}
	
	/**
	 * 无权限跳转
	 */
	public void noPriv(){
		setAttr("flag", getPara("flag"));
		render("common/backNoPriv.jsp");
	}
}
