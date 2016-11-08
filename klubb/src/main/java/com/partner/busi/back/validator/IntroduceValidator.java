package com.partner.busi.back.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * 介绍过滤
* @ClassName: IntroduceValidator 
* @Description: 
* @author zhanglei
* @date 2016年11月8日 上午9:06:18
 */
public class IntroduceValidator extends Validator {

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
		validateRequiredString("introduce.CONTENT", "content_msg", "请填写内容");
	}

}
