package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.CenterValidator;
import com.partner.busi.front.validator.PwdValidator;
import com.partner.busi.model.ActUser;
import com.partner.busi.model.Activity;
import com.partner.busi.model.Picture;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.util.Encoding;
import com.partner.common.util.FrontSessionUtil;

public class UserCenterController extends Controller {
	
	/**
	 * to activity_manage
	 */
	public void toActMan(){
		render("activity_manage.jsp");
	}
	
	/**
	 * to user center happytimes
	 */
	public void toHappytimes(){
		render("userht.jsp");
	}
	
	/**
	 * to user center happytimes upload
	 */
	public void toHappytimesUpload(){
		render("userhtupload.jsp");
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
	
	/**
	 * cancle activity
	 */
	public void cancleAct(){
		boolean rsFlag = false;
		String rsMsg = "取消活动失败，请稍后再试";
		
		int actId = getParaToInt("actId");
		//String userId = FrontSessionUtil.getUserNo(getRequest());
		String userId = "1";
		rsFlag = ActUser.dao.deleteByUserIdAndActId(userId,actId);
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * show user happytimes
	 */
	public void showUserHappy(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		User user = FrontSessionUtil.getSession(getRequest());
		
		//Page<Picture> page = Picture.dao.findUserPic(user.getID(),pageNum,pageSize);
		Page<Picture> page = Picture.dao.findUserPic(1,pageNum,pageSize);
		setAttr("page", page);
		renderJson();
	}
	
	/**
	 * 密码修改功能
	 */
	@Before(PwdValidator.class)
	public void submitPwd(){
		ResultInfo retInfo = new ResultInfo();
		String oldPwd = getPara("oldPwd");
		String newPwd = getPara("newPwd");
		User user = FrontSessionUtil.getSession(getRequest());
		if(!user.getPASSWORD().equals(Encoding.encoding(oldPwd))){
			retInfo.setRetCode(1);
			retInfo.setRetMsg("oldPwd:旧密码输入错误！");
		}else{
			user.setPASSWORD(Encoding.encoding(newPwd));
			user.update();
			retInfo.setRetCode(0);
			retInfo.setRetMsg("密码修改成功！");
		}
		renderJson(retInfo);
	}
	
	/**
	 * upload happytimes
	 */
	public void uploadHappyTimes(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Picture pic = getModel(Picture.class);
		pic.set("USER_ID", FrontSessionUtil.getSession(getRequest()).getID());
		pic.set("CREATE_TIME", new Date());
		rsFlag = pic.save();
		if(rsFlag){
			rsMsg = "成功";
		}
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
}
