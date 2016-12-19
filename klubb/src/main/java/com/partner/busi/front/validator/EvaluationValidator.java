package com.partner.busi.front.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class EvaluationValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
//		validateString("evaluation.CONTENT", 1, 200, "content_msg", "请输入1~150字内容");
		validateString("evaluation.CONTENT", 1, 150, "content_msg", "Meddelande (max. 150 ord)");
	}

	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

}
