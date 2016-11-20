/**
 * 
 */
package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.model.Introduce;

/** 
 * @ClassName: IntroduceController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
public class IntroduceController extends Controller {

	/**
	 * 获取介绍编辑页面
	 */
	public void index(){
		Introduce poolIntro = Introduce.dao.findById(3);
		Introduce personIntro = Introduce.dao.findById(4);
		setAttr("poolIntro", poolIntro);
		setAttr("personIntro", personIntro);
		render("introduce/introduce.jsp");
	}
	
}
