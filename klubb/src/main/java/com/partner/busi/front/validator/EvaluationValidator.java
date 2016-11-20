package com.partner.busi.front.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class EvaluationValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
		validateRequiredString("evaluation.CONTENT", "content_msg", "请填写项目内容");
	}

	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		
	}

}
