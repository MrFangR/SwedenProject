/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.core.Controller;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;

/**
 * @author fangrui
 * desc  前台用户登陆控制器
 */
public class LoginController extends Controller {
	
	public void index(){
		this.login();
	}
	
	public void login(){
		ResultInfo retInfo = new ResultInfo();
		String email = getPara("email");
		String pwd = getPara("pass");
		User user = User.dao.findByLogin(email, pwd);
		if(user != null){
			//登录成功，将登录信息放到session当中，跳转到首页
			retInfo.setRetCode(0);
			retInfo.setRetMsg("登录成功");
		}else{//登录失败，返回给前台
			retInfo.setRetCode(1);
			retInfo.setRetMsg("登录失败");
		}
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
