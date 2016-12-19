package com.partner.busi.front.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class HappyValidator extends Validator {

	@Override
	protected void validate(Controller c) {
//		validateRequiredString("picture.URL", "url_notice", "请上传图片!");
//		validateString("picture.DESCRIPTION", 1, 200, "description_notice", "请输入1~200描述内容");
		validateRequiredString("picture.URL", "url_notice", "Ladda upp bilder");
		validateString("picture.DESCRIPTION", 1, 200, "description_notice", "Beskriving (max. 200 ord)");
	}

	@Override
	protected void handleError(Controller c) {
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

}
