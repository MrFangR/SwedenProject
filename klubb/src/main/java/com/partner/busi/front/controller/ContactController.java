/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.partner.busi.front.validator.ContactValidator;
import com.partner.busi.model.Config;
import com.partner.busi.model.Contact;

/** 
 * @ClassName: ContactController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
public class ContactController extends Controller {
	
	public void index(){
		Config config = Config.dao.findById(1);
		setAttr("config", config);
		String busi = config.getBusinessTime();
		List<String> busiList = new ArrayList<String>();
		if(StringUtils.isNotEmpty(busi)){
			busiList = Arrays.asList(busi.split("\n"));
		}
		setAttr("busiList", busiList);
		render("contact/contact_us.jsp");
	}
	
	@Before(ContactValidator.class)
	public void contactUs(){
		boolean rsFlag = false;
		String rsMsg = "发送失败，请稍后再试";
	
		Contact contact = getModel(Contact.class);
		contact.setCreateTime(new Date());
		rsFlag = contact.save();
		
		if(rsFlag){ //保存成功
			rsMsg = "发送成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
    
}
