package com.partner.busi.back.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class ActivityValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

	@Override
	protected void handleError(Controller c) {
		validateRequiredString("activity.CONTENT", "content_msg", "请填写内容");
	}

}
