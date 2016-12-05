package com.partner.busi.front.validator;

import org.apache.commons.lang.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class ActivityValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateRequiredString("actUser.NAME", "name_notice", "请输入姓名!");
		
		String inPhone = c.getPara("actUser.phone");
		String inEmail = c.getPara("actUser.EMAIL");
		if(StringUtils.isNotBlank(inPhone)){
			validateRequiredString("actUser.phone", "phone_notice", "请输入手机号!");
		}
		if(StringUtils.isNotBlank(inEmail)){
			validateEmail("actUser.EMAIL", "email_notice", "请输入正确用户邮箱!");
		}
		if(StringUtils.isBlank(inPhone)&&StringUtils.isBlank(inEmail)){
			addError("phone_notice", "手机或邮箱至少输入一项!");
		}
		
	}

	@Override
	protected void handleError(Controller c) {
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

}
