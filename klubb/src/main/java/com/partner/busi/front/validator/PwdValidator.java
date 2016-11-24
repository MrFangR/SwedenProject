/**
 * 
 */
package com.partner.busi.front.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;

/**
 * @author issuser
 *
 */
public class PwdValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
		validateRequiredString("oldPwd", "oldPwdMsg", "旧密码不能为空!");
		validateRequiredString("newPwd", "newPwdMsg", "新密码不能为空!");
		validateRequiredString("repwd", "repwdMsg", "确认密码不能为空!");
		String pwd = c.getPara("newPwd");
		String repwd = c.getPara("repwd");
		if(!pwd.equals(repwd)){
			addError("repwdMsg", "两次密码不一致,请重新输入!");
		}
	}

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#handleError(com.jfinal.core.Controller)
	 */
	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.keepPara();
		if(c.getAttr("oldPwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"oldPwd:"+(String)c.getAttr("oldPwdMsg")));
		}else if(c.getAttr("newPwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"newPwd:"+(String)c.getAttr("newPwdMsg")));
		}else if(c.getAttr("repwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"repwd:"+(String)c.getAttr("repwdMsg")));
		}
	}

}
