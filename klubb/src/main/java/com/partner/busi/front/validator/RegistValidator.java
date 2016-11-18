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
        validateRequiredString("name", "name", "请输入您的姓名!");
		validateRequiredString("niceName", "niceName", "请输入您的昵称!");
		validateRequiredString("idNum", "idNum", "请输入您的人口号!");
		validateRequiredString("pwd", "pwd", "请输入您的密码!");
		validateRequiredString("repwd", "repwd", "请输入您的确认密码!");
		validateEmail("email", "email", "请输入正确用户邮箱!");
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
		if(c.getAttr("name")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"name:"+(String)c.getAttr("name")));
		}else if(c.getAttr("niceName")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"niceName:"+(String)c.getAttr("niceName")));
		}else if(c.getAttr("idNum")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"idNum:"+(String)c.getAttr("idNum")));
		}else if(c.getAttr("pwd")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"pwd:"+(String)c.getAttr("pwd")));
		}else if(c.getAttr("repwd")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"repwd:"+(String)c.getAttr("repwd")));
		}else if(c.getAttr("email")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"email:"+(String)c.getAttr("email")));
		}else if(c.getAttr("pwddiff")!=null){
			c.renderJson(new ResultInfo(Constants.FLAG_FAIL,"repwd:"+(String)c.getAttr("pwddiff")));
		}
	}

}
