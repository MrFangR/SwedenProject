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
public class CenterValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
        validateRequiredString("name", "nameMsg", "Ange ditt namn!");
		validateRequiredString("nickName", "nickNameMsg", "Ange ditt smeknamn!");
		validateRequiredString("idNum", "idNumMsg", "Ange ditt personnummer!");
		//validateRequiredString("email", "emailMsg", "邮箱不能为空!");
		//validateEmail("email", "emailMsg", "请输入正确用户邮箱!");
		validateRequiredString("imgcode", "imgcodeMsg", "ange verifieringskoden!");
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
		if(c.getAttr("nameMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"name:"+(String)c.getAttr("nameMsg")));
		}else if(c.getAttr("nickNameMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"nickName:"+(String)c.getAttr("nickNameMsg")));
		}else if(c.getAttr("idNumMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"idNum:"+(String)c.getAttr("idNumMsg")));
		}else if(c.getAttr("emailMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"email:"+(String)c.getAttr("emailMsg")));
		}else if(c.getAttr("imgcodeMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"imgcode:"+(String)c.getAttr("imgcodeMsg")));
		}
	}

}
