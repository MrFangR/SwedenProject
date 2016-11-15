package com.partner.busi.front.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.ActUser;
import com.partner.busi.model.Activity;

public class ActivityController extends Controller {

	/**
	 * 活动列表
	 */
	public void index(){
		render("activity/activitylist.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		String title = getPara("title");
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Activity> page = Activity.dao.findList(title, pageNum, pageSize);
		renderJson(page);
	}
	
	/**
	 * 查看活动
	 */
	public void viewAct(){
		String type = getPara("type");
		Activity act = Activity.dao.findById(type);
		//List<ActUser> userList = ActUser.dao.getUserByActId(getParaToInt("type"));
		setAttr("act", act);
		//setAttr("userList", userList);
		render("activity/activitycont.jsp");
	}
	
}
