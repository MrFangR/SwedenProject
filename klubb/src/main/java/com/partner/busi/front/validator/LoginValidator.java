/**
 * 
 */
package com.partner.busi.front.validator;

import org.apache.commons.lang.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;

/**
 * @author issuser
 *
 */
public class LoginValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
//        validateRequiredString("imgcode", "imgcodeMsg", "请输入验证码!");
        validateRequiredString("imgcode", "imgcodeMsg", "ange verifieringskoden");
//		validateRequiredString("loginpwd", "loginpwdMsg", "请输入密码!");
		validateRequiredString("loginpwd", "loginpwdMsg", "ange ditt lösenord");
//		validateRequiredString("loginname", "loginnameMsg", "请输入用户邮箱!");
		validateRequiredString("loginname", "loginnameMsg", "ange din e-postadress");
//		validateEmail("loginname", "loginnameMsg", "请输入正确用户邮箱!");
		validateEmail("loginname", "loginnameMsg", "E-postadressen är ogiltlig");
		validateRequiredString("imgcode", "imgcodeMsg", "验证码不能为空!");
		String inputRandomCode = c.getPara("imgcode");
		if(StringUtils.isNotBlank(inputRandomCode)){
	        boolean loginSuccess = c.validateCaptcha("imgcode");
	        if(!loginSuccess){
//	        	addError("imgcodeMsg", "验证码错误,请重新输入!");
	        	addError("imgcodeMsg", "Felaktig verifieringskod");
	        }
		}
	}

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#handleError(com.jfinal.core.Controller)
	 */
	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.keepPara();
		if(c.getAttr("imgcodeMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"imgcode:"+(String)c.getAttr("imgcodeMsg")));
		}else if(c.getAttr("loginpwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"loginpwd"+(String)c.getAttr("loginpwdMsg")));
		}else if(c.getAttr("loginnameMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"loginname"+(String)c.getAttr("loginnameMsg")));
		}
	}

}
