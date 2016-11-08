/**
 * 
 */
package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.model.Config;

/** 
 * @ClassName: ConfigController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月8日 下午4:26:42  
 */
@ControllerBind(controllerKey="/front/config",viewPath="/front/config")
public class ConfigController extends Controller {
	
	/**
	 * 查看台球厅配置
	 */
	public void view(){
		Config config = Config.dao.findById(1);
		setAttr("config", config);
		render("view.jsp");
	}
	
}
