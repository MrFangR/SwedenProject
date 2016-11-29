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
		validateRequiredString("activity.TITLE", "content_msg", "请填写标题");
		validateDate("activity.ACT_TIME", "content_msg", "请填写正确时间");
		validateRequiredString("activity.IMG", "content_msg", "请填加图片");
		validateString("activity.ABSTRACT", 1, 200, "abstract_msg", "请输入1~200描述内容");
		validateString("activity.CONTENT", 1, 200, "content_msg", "请输入1~1000字描述内容");
	}

}
