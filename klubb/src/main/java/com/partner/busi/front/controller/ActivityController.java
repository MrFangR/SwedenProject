package com.partner.busi.front.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.ActivityValidator;
import com.partner.busi.model.ActUser;
import com.partner.busi.model.Activity;
import com.partner.busi.model.User;
import com.partner.common.util.FrontSessionUtil;

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
//		String rsMsg = "参加活动失败";
		String rsMsg = "Det gick inte att anmäla dig till aktiviteten.";
		
		ActUser actUser = getModel(ActUser.class);
		//判断是否为登录状态
		if(FrontSessionUtil.isLogin(getRequest())){
			//获取用户登录信息
			User user = FrontSessionUtil.getSession(getRequest());
			actUser.set("USER_ID", user.getID());
		}
		//判断用户是否已经报名参加比赛，表中是否有手机号或者邮箱
		Integer userId = actUser.getUserId();
		
		List<ActUser> userlist = ActUser.dao.findUserList(actUser.getUserId(),actUser.getPhone(),actUser.getEMAIL());
		if(userlist == null || userlist.size()==0){
			actUser.set("CREATE_TIME", new Date());
			rsFlag = actUser.save();
			if(rsFlag){
//				rsMsg = "参加成功！";
				rsMsg = "Du är anmäld till aktiviteten!";
			}
		}else{
			rsMsg = "当前用户已报名";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
}
