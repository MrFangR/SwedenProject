/**
 * 
 */
package com.partner.busi.back.controller;

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
     * 新闻 新增/更新
     */
    @Before(IntroduceValidator.class)
	public void saveOrUpdate(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Introduce intro = getModel(Introduce.class);
		
		intro.set("CREATE_TIME", new Date());
		intro.set("CREATE_USER_ID", BackSessionUtil.getUserNo(getRequest()));
		rsFlag = intro.update();
		
		if(rsFlag){ //保存成功
			rsMsg = "保存成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
    
    /**
     * 修改台球厅介绍页面
     */
    public void editPoolIntro(){
    	Introduce intro = Introduce.dao.findById(INTRODUCE_TYPE.POOL);
		setAttr("intro", intro);
		render("pool_edit.jsp");
	}
    
    /**
     * 修改员工介绍页面
     */
    public void editStaffIntro(){
    	Introduce intro = Introduce.dao.findById(INTRODUCE_TYPE.STAFF);
		setAttr("intro", intro);
		render("staff_edit.jsp");
	}
	
}
