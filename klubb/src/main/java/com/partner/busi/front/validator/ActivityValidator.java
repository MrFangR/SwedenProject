package com.partner.busi.front.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class ActivityValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateRequiredString("actUser.NAME", "name_notice", "请输入姓名!");
		validateRequiredString("actUser.phone", "phone_notice", "请输入手机号!");
		validateEmail("actUser.EMAIL", "email_notice", "请输入正确用户邮箱!");
		
	}

	@Override
	protected void handleError(Controller c) {
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

}
