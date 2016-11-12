package com.partner.busi.back.validator;

import org.apache.commons.lang.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;

public class LoginValidator extends Validator{

	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
        validateRequiredString("imgCode", "showMsg", "请输入验证码!");
		validateRequiredString("pwd", "showMsg", "请输入密码!");
		validateRequiredString("userNo", "showMsg", "请输入用户名称!");
		String inputRandomCode = c.getPara("imgCode");
		if(StringUtils.isNotBlank(inputRandomCode)){
	        boolean loginSuccess = c.validateCaptcha("imgCode");
	        if(!loginSuccess){
	        	addError("showMsg", "验证码错误,请重新输入!");
	        }
		}
	}

	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.keepPara();
		c.renderJson(new ResultInfo(Constants.FLAG_FAIL,(String)c.getAttr("showMsg")));
	}

	

}
