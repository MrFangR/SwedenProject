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
@ControllerBind(controllerKey="/front/introduce",viewPath="/front/introduce")
public class IntroduceController extends Controller {

	/**
	 * 获取介绍编辑页面
	 */
	public void view(){
		String type = getPara("type");
		Introduce intro = Introduce.dao.findById(type);
		setAttr("intro", intro);
		render("view.jsp");
	}
	
}
