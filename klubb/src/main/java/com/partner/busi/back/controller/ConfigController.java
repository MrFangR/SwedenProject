/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.model.Config;

/** 
 * @ClassName: ConfigController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月8日 下午4:26:42  
 */
@ControllerBind(controllerKey="/back/config",viewPath="/back/config")
public class ConfigController extends Controller {
	
	/**
	 * 查看台球厅配置
	 */
	public void view(){
		Config config = Config.dao.findById(1);
		setAttr("config", config);
		render("view.jsp");
	}
	
	/**
	 * 编辑页面
	 */
	public void edit(){
		Config config = Config.dao.findById(1);
		setAttr("config", config);
		render("edit.jsp");
	}
	
	/**
	 * 保存
	 */
	public void saveOrUpdate(){
		boolean rsFlag = false;
		String rsMsg = "保存失败，请稍后再试";
		
		Config config = getModel(Config.class);
		
		rsFlag = config.update();
		
		if(rsFlag){ //保存成功
			rsMsg = "保存成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
}
