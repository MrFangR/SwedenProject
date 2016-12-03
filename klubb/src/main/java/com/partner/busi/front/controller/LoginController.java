/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.partner.busi.front.validator.LoginValidator;
import com.partner.busi.front.validator.RegistValidator;
import com.partner.busi.front.validator.SendEmailValidator;
import com.partner.busi.model.ResetRec;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.DateUtil;
import com.partner.common.util.EmailUtil;
import com.partner.common.util.Encoding;
import com.partner.common.util.FrontSessionUtil;
import com.partner.common.util.SendMail;

/**
 * @author fangrui desc 前台用户登陆控制器
 */
public class LoginController extends Controller {

	public void index() {
		this.toLogin();
	}

	public void toLogin() {
		render("login.jsp");
	}

	public void toRegist() {
		render("regist.jsp");
	}

	@Before(LoginValidator.class)
	public void login() {
		FrontSessionUtil.clearSession(getRequest());
		ResultInfo retInfo = new ResultInfo();
		String email = getPara("loginname");
		String pwd = getPara("loginpwd");
		User user = User.dao.findByLogin(email, Encoding.encoding(pwd));
		if (user != null) {
			// 登录成功，将登录信息放到session当中，跳转到首页
			FrontSessionUtil.setSession(getRequest(), user);
			retInfo.setRetCode(0);
			retInfo.setRetMsg("登录成功");
		} else {// 登录失败，返回给前台
			retInfo.setRetCode(1);
			retInfo.setRetMsg("登录失败");
		}
		renderJson(retInfo);
	}

	/**
	 * 退出
	 */
	public void logout() {
		ResultInfo retInfo = new ResultInfo();
		FrontSessionUtil.clearSession(getRequest());
		retInfo.setRetCode(0);
		retInfo.setRetMsg("退出成功");
		renderJson(retInfo);
	}

	@Before(RegistValidator.class)
	public void regist() {
		ResultInfo retInfo = new ResultInfo();
		String nickName = getPara("nickName");
		String idNum = getPara("idNum");
		String name = getPara("name");
		String email = getPara("email");
		String phone = getPara("phone");
		User user = new User();
		user.setEMAIL(email);
		user.setNAME(name);
		user.setNICKNAME(nickName);
		user.setIdNumber(idNum);
		user.setGENDER(getParaToInt("sex"));
		user.setPHONE(phone);
		user.setPASSWORD(Encoding.encoding(getPara("pwd")));
		user.setCreateTime(new Date());
		user.setSTATUS(0);
		user.save();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("注册成功");
		renderJson(retInfo);
	}

	public void toForget() {
		render("forget.jsp");
	}

	@Before(SendEmailValidator.class)
	public void sendEmail() {
		ResultInfo retInfo = new ResultInfo();

		// 检查此邮箱是否已经注册过
		String email = getPara("email");
		User user = User.dao.findByEmail(email);
		if (user == null) {
			retInfo.setRetCode(1);
			retInfo.setRetMsg("此邮箱未进行过注册，请注册。");
		} else {
			String content = getRequest().getScheme() + "://"
					+ getRequest().getServerName() + ":"
					+ getRequest().getServerPort()
					+ getRequest().getContextPath() + "/front/toModifyPwd?uid=";
			UUID uid = UUID.randomUUID();
			ResetRec rec = new ResetRec();
			rec.setEMAIL(getPara("email"));
			rec.setUUID(uid.toString());
			rec.setCreateTime(new Date());
			rec.save();
			/*
			 * SendMail.sendMessage(Constants.STMP, Constants.EMAIL_USER,
			 * Constants.EMAIL_PASSWORD, getPara("email"), "密码修改",
			 * content+uid.toString(), "text/html;charset=utf-8");
			 */
			EmailUtil.send("密码修改", content + uid.toString(), getPara("email"));
			retInfo.setRetCode(0);
			retInfo.setRetMsg("修改密码邮件发送成功，请查看");
		}
		renderJson(retInfo);
	}

	public void toModifyPwd() {
		// 缺失修改密码请求有效性判断
		ResultInfo retInfo = new ResultInfo();
		String uid = getPara("uid");
		ResetRec rec = ResetRec.dao.findByUid(uid);
		if (rec == null) {
			retInfo.setRetCode(1);
			retInfo.setRetMsg("非法请求链接，请重新获取。");
		} else {
			if (DateUtil.toRemind(new Date(), rec.getCreateTime(), 30, "HH")) {
				retInfo.setRetCode(1);
				retInfo.setRetMsg("请求链接已失效，请重新获取。");
			} else {
				retInfo.setRetCode(0);
				retInfo.setRetMsg("请修改密码");
				setAttr("email", rec.getEMAIL());
			}
		}
		setAttr("retInfo", retInfo);
		render("reset_pwd.jsp");
	}

	public void modifyPwd() {
		ResultInfo retInfo  = new ResultInfo();
		//业务应该从页面获取uuid，根据 uuid 查询到 email，再根据 email 获取到 user 信息
		String pwd = getPara("pwd");
		String email = getPara("email");
		User user = User.dao.findByEmail(email);
		user.setPASSWORD(Encoding.encoding(pwd));
		user.update();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("修改成功，请重新登录！");
		renderJson(retInfo);
	}
}
