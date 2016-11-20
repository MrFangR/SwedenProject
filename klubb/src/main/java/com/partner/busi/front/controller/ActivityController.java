package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.ActivityValidator;
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
	 * join activity index
	 */
	public void toJoinAct(){
		String actID = getPara("actID");
		setAttr("actID", actID);
		render("activity/activityJoin.jsp");
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
		setAttr("act", act);
		render("activity/activitycont.jsp");
	}
	
	/**
	 * join activity
	 */
	@Before(ActivityValidator.class)
	public void addAct(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		ActUser actUser = getModel(ActUser.class);
		actUser.set("CREATE_TIME", new Date());
		rsFlag = actUser.save();
		if(rsFlag){
			rsMsg = "参加成功！";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
}
