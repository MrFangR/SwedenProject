/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.back.validator.IntroduceValidator;
import com.partner.busi.model.Introduce;
import com.partner.busi.model.Introduce.INTRODUCE_TYPE;

/** 
 * @ClassName: IntroduceController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
@ControllerBind(controllerKey="/back/introduce",viewPath="/back/introduce")
public class IntroduceController extends Controller {
	
	/**
	 * 获取台球厅介绍页面
	 */
	public void getPoolIntro(){
		Introduce intro = Introduce.dao.findById(INTRODUCE_TYPE.POOL);
		setAttr("intro", intro);
		render("pool_intro.jsp");
	}
	
	/**
	 * 获取员工介绍页面
	 */
	public void getStaffIntro(){
		Introduce intro = Introduce.dao.findById(INTRODUCE_TYPE.STAFF);
		setAttr("intro", intro);
		render("staff_intro.jsp");
	}
	
}
