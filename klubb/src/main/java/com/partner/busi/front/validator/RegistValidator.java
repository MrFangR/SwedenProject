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
public class RegistValidator extends Validator {

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#validate(com.jfinal.core.Controller)
	 */
	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
        validateRequiredString("name", "nameMsg", "请输入您的姓名!");
		validateRequiredString("nickName", "nickNameMsg", "请输入您的昵称!");
		validateRequiredString("idNum", "idNumMsg", "请输入您的人口号!");
		validateRequiredString("pwd", "pwdMsg", "请输入您的密码!");
		validateRequiredString("repwd", "repwdMsg", "请输入您的确认密码!");
		validateEmail("email", "emailMsg", "请输入正确用户邮箱!");
		String pwd = c.getPara("pwd");
		String repwd = c.getPara("repwd");
		if(!pwd.equals(repwd)){
			addError("pwddiff", "两次密码不一致,请重新输入!");
		}
	}

	/* (non-Javadoc)
	 * @see com.jfinal.validate.Validator#handleError(com.jfinal.core.Controller)
	 */
	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.keepPara();
		if(c.getAttr("nameMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"name:"+(String)c.getAttr("nameMsg")));
		}else if(c.getAttr("nickNameMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"nickName:"+(String)c.getAttr("nickNameMsg")));
		}else if(c.getAttr("idNumMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"idNum:"+(String)c.getAttr("idNumMsg")));
		}else if(c.getAttr("pwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"pwd:"+(String)c.getAttr("pwdMsg")));
		}else if(c.getAttr("repwdMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"repwd:"+(String)c.getAttr("repwdMsg")));
		}else if(c.getAttr("emailMsg")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"email:"+(String)c.getAttr("emailMsg")));
		}else if(c.getAttr("pwddiff")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"repwd:"+(String)c.getAttr("pwddiff")));
		}
	}

}
