/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.partner.busi.front.validator.LoginValidator;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.util.Encoding;
import com.partner.common.util.FrontSessionUtil;

/**
 * @author fangrui
 * desc  前台用户登陆控制器
 */
public class LoginController extends Controller {
	
	public void index(){
		this.toLogin();
	}
	
	public void toLogin(){
		render("login.jsp");
	}
	
	public void toRegist(){
		render("regist.jsp");
	}
	
	@Before(LoginValidator.class)
	public void login(){
		FrontSessionUtil.clearSession(getRequest());
		ResultInfo retInfo = new ResultInfo();
		String email = getPara("loginname");
		String pwd = getPara("loginpwd");
		User user = User.dao.findByLogin(email, Encoding.encoding(pwd));
		if(user != null){
			//登录成功，将登录信息放到session当中，跳转到首页
			FrontSessionUtil.setSession(getRequest(), user);
			retInfo.setRetCode(0);
			retInfo.setRetMsg("登录成功");
		}else{//登录失败，返回给前台
			retInfo.setRetCode(1);
			retInfo.setRetMsg("登录失败");
		}
		renderJson(retInfo);
	}
	/**
	 * 退出
	 */
	public void logout(){
		ResultInfo retInfo = new ResultInfo();
		FrontSessionUtil.clearSession(getRequest());
		retInfo.setRetCode(0);
		retInfo.setRetMsg("退出成功");
		renderJson(retInfo);
	}
	
	public void regist(){
		ResultInfo retInfo = new ResultInfo();
		String nickName = getPara("nickName");
		String idNumber = getPara("idNumber");
		String name = getPara("name");
		String gender = getPara("gender");
		String email = getPara("email");
		String phone = getPara("phone");
		User user = new User();
		user.setEMAIL(email);
		user.setNAME(name);
		user.setNICKNAME(nickName);
		user.setIdNumber(idNumber);
		user.setGENDER(getParaToInt("gender"));
		user.setPHONE(phone);
		user.setPASSWORD(getPara("password"));
		user.setCreateTime(new Date());
		user.setSTATUS(0);
		user.save();
	}
}
