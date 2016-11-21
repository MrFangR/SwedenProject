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
public class SendEmailValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
		validateEmail("email", "emailMsg", "请输入正确用户邮箱!");
		validateRequiredString("imgcode", "imgcodeMsg", "请输入验证码!");
		String inputRandomCode = c.getPara("imgcode");
		if(StringUtils.isNotBlank(inputRandomCode)){
	        boolean loginSuccess = c.validateCaptcha("imgcode");
	        if(!loginSuccess){
	        	addError("imgcodeMsg", "验证码错误,请重新输入!");
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
		if(c.getAttr("emailMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"email:"+(String)c.getAttr("emailMsg")));
		}else if(c.getAttr("imgcodeMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"imgcode:"+(String)c.getAttr("imgcodeMsg")));
		}
	}

}
