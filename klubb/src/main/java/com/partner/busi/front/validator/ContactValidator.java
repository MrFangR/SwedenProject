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
public class ContactValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#handleError(com.jfinal.core.Controller)
	 */
	@Override
	protected void handleError(Controller c) {
    	c.setAttr("rsFlag", false);
    	c.renderJson();
	}

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		validateRequiredString("contact.NAME", "name_msg", "请填写姓名");
		validateRequiredString("contact.PHONE", "phone_msg", "请填写电话");
		validateRequiredString("contact.CONTENT", "content_msg", "请填写留言");
//		validateRequiredString("code", "code_msg", "请填写验证码");
		validateCaptcha("code", "code_msg", "验证码输入有误");
	}

}
