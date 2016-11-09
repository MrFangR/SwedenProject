package com.partner.busi.back.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.core.Controller;
import com.jfinal.ext.render.CaptchaRender;
import com.jfinal.ext.route.ControllerBind;
import com.partner.busi.model.CUser;
import com.partner.common.base.SysController;
import com.partner.common.constant.Constants;
import com.partner.common.util.BackSessionUtil;
import com.partner.common.util.Encoding;

/**
 * 后台管理系统登录相关controller
 * @author: YangKai
 */
public class BackLoginController extends Controller {
	private static final Logger log = Logger.getLogger(BackLoginController.class);
	

	/**
	 * 跳转至后台管理系统登录页面
	 */
	public void index(){
		if (BackSessionUtil.isLoginBack(getRequest())) {
			forwardAction("/back/main/init");
		} else {
			render("backLogin.jsp");
		}
	}
	
	/**
	 * 后台管理系统登录
	 */
	public void login(){
		Map<String, Object> json = new HashMap<String, Object>();
		String userNo = getPara("userNo");
		String pwd = Encoding.md5Encoding(getPara("pwd"));
		String imgCode = getPara("imgCode");
		if (imgCode==null || !CaptchaRender.validate(this, imgCode.toUpperCase(), SysController.RANDOM_CODE_KEY)) {
			json.put("flag", Constants.FLAG_FAIL);
			json.put("msg", "验证码错误，请重新输入");
			renderJson(json);
			return;
		}
		log.info("后台管理用户登录开始>>>>>[userNo="+userNo+"]");
		CUser user = CUser.dao.validCUser(userNo, pwd);
		if (user == null) {
			log.info("用户名或密码错误[userNo="+userNo+"]");
			json.put("flag", Constants.FLAG_FAIL);
			json.put("msg", "用户名或密码错误，请核实后重新输入");
		} else if(!BackSessionUtil.setSession(getRequest(), user)) {// 初始化session
			log.info("初始化session失败[userNo="+userNo+"]");
			json.put("flag", Constants.FLAG_FAIL);
			json.put("msg", "系统异常，请稍后重试");
		} else {
			log.info("后台管理用户登录成功[userNo="+userNo+"]");
			json.put("flag", Constants.FLAG_SUCCESS);
			json.put("msg", "后台管理用户登录成功");
		}
		renderJson(json);
	}
	
	/**
	 * 登出
	 * @return 登录页面
	 */
	public void logout(){
		BackSessionUtil.clearSession(getRequest());
		render("backLogin.jsp");
	}
}
