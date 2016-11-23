package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Activity;
import com.partner.common.util.FrontSessionUtil;

public class UserCenterController extends Controller {
	
	/**
	 * to activity_manage
	 */
	public void toActMan(){
		render("activity_manage.jsp");
	}
	
	/**
	 * find activity by user_id
	 */
	public void findActByUserId(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		//Page<Activity> page = Activity.dao.findAllActByUser(FrontSessionUtil.getUserNo(getRequest()),pageNum,pageSize);
		Page<Activity> page = Activity.dao.findAllActByUser("1",pageNum,pageSize);
		renderJson(page);
	}

}
