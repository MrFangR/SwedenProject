package com.partner.busi.front.controller;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.CenterValidator;
import com.partner.busi.model.Activity;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
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
	
	public void index(){
		//判断是否为登录状态
		if(FrontSessionUtil.isLogin(getRequest())){
			//获取用户登录信息
			User user = FrontSessionUtil.getSession(getRequest());
			
			setAttr("user",user);
			render("userinfo.jsp");
		}else{
			redirect("/front/toLogin");
		}
	}
	@Before(CenterValidator.class)
	public void submitInfo(){
		ResultInfo retInfo = new ResultInfo();
		String nickName = getPara("nickName");
		String idNum = getPara("idNum");
		String name = getPara("name");
		//String email = getPara("email");
		String phone = getPara("phone");
		User user = FrontSessionUtil.getSession(getRequest());
		//user.setEMAIL(email);
		user.setNAME(name);
		user.setNICKNAME(nickName);
		user.setIdNumber(idNum);
		user.setGENDER(getParaToInt("sex"));
		user.setPHONE(phone);
		user.update();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("修改成功");
		renderJson(retInfo);
	}

}
