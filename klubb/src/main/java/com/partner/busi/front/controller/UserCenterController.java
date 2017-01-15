package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.CenterValidator;
import com.partner.busi.front.validator.HappyValidator;
import com.partner.busi.front.validator.PwdValidator;
import com.partner.busi.model.ActUser;
import com.partner.busi.model.Activity;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchUser;
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
		if(FrontSessionUtil.isLogin(getRequest())){
			User user = FrontSessionUtil.getSession(getRequest());
			setAttr("user",user);
			render("activity_manage.jsp");
		}else{
			forwardAction("/front/toLogin");
//			redirect("/front/toLogin");
		}
	}
	
	/**
	 * to user center happytimes
	 */
	public void toHappytimes(){
		if(FrontSessionUtil.isLogin(getRequest())){
			User user = FrontSessionUtil.getSession(getRequest());
			setAttr("user",user);
			render("userht.jsp");
		}else{
			forwardAction("/front/toLogin");
		}
	}
	
	/**
	 * to user center happytimes upload
	 */
	public void toHappytimesUpload(){
		if(FrontSessionUtil.isLogin(getRequest())){
			User user = FrontSessionUtil.getSession(getRequest());
			setAttr("user",user);
			render("userhtupload.jsp");
		}else{
			forwardAction("/front/toLogin");
		}
	}
	
	/**
	 * to match_manage
	 */
	public void toMatMan(){
		if(FrontSessionUtil.isLogin(getRequest())){
			User user = FrontSessionUtil.getSession(getRequest());
			setAttr("user",user);
			render("match_manage.jsp");
		}else{
			forwardAction("/front/toLogin");
//			redirect("/front/toLogin");
		}
	}
	
	/**
	 * find activity by user_id
	 */
	public void findActByUserId(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Activity> page = Activity.dao.findAllActByUser(FrontSessionUtil.getSession(getRequest()).getID(),pageNum,pageSize);
		//Page<Activity> page = Activity.dao.findAllActByUser("1",pageNum,pageSize);
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
			forwardAction("/front/toLogin");
//			redirect("/front/toLogin");
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
//		retInfo.setRetMsg("修改成功");
		retInfo.setRetMsg("Lösenordet har ändrats.");
		renderJson(retInfo);
	}
	
	/**
	 * cancle activity
	 */
	public void cancleAct(){
		boolean rsFlag = false;
//		String rsMsg = "取消活动失败，请稍后再试";
		String rsMsg = "Det gick inte att inställa aktiviteten. Vänligen försök senare.";
		
		int actId = getParaToInt("actId");
		Integer userId = FrontSessionUtil.getSession(getRequest()).getID();
		//String userId = "1";
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
		
		Page<Picture> page = Picture.dao.findUserPic(user.getID(),pageNum,pageSize);
		//Page<Picture> page = Picture.dao.findUserPic(1,pageNum,pageSize);
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
//			retInfo.setRetMsg("oldPwd:旧密码输入错误！");
			retInfo.setRetMsg("oldPwd:Felaktigt gammalt lösenord");
		}else{
			user.setPASSWORD(Encoding.encoding(newPwd));
			user.update();
			retInfo.setRetCode(0);
//			retInfo.setRetMsg("密码修改成功！");
			retInfo.setRetMsg("密码修改成功！");
		}
		renderJson(retInfo);
	}
	
	/**
	 * upload happytimes
	 */
	@Before(HappyValidator.class)
	public void uploadHappyTimes(){
		boolean rsFlag = false;
//		String rsMsg = "发布失败，请稍后再试";
		String rsMsg = "Det gick inte att publicera. Vänligen försök senare.";
		
		Picture pic = getModel(Picture.class);
		pic.set("USER_ID", FrontSessionUtil.getSession(getRequest()).getID());
		pic.set("CREATE_TIME", new Date());
		rsFlag = pic.save();
		if(rsFlag){
//			rsMsg = "成功";
			rsMsg = "Laddat upp";
		}
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * delete happytimes picture
	 */
	public void deletePic(){
		boolean rsFlag = false;
//		String rsMsg = "取消活动失败，请稍后再试";
		String rsMsg = "Det gick inte att inställa aktiviteten. Vänligen försök igen.";
		
		int picID = getParaToInt("picID");
		rsFlag = Picture.dao.deleteById(picID);
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * find match by user_id
	 */
	public void findMatByUserId(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Match> page = Match.dao.findAllMatByUser(FrontSessionUtil.getSession(getRequest()).getID(),pageNum,pageSize);
		renderJson(page);
	}
	
	/**
	 * cancle match
	 */
	public void cancleMatch(){
		boolean rsFlag = false;
//		String rsMsg = "取消活动失败，请稍后再试";
		String rsMsg = "Det gick inte att inställa aktiviteten. Vänligen försök senare.";
		
		int matId = getParaToInt("matId");
		Match mat = Match.dao.findById(matId);
		Integer userId = FrontSessionUtil.getSession(getRequest()).getID();
		//判断活动是已经开始
		
		
		rsFlag = MatchUser.dao.deleteByUserIdAndActId(userId,matId);
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
}
