/**
 * 
 */
package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.partner.busi.model.CUser;

/**
 * @author fangrui
 *
 */
public class IndexController extends Controller {
	
	public void index(){
		CUser user = CUser.dao.findByName("fangrui");
		if(user!=null){
			setAttr("user",user);
		}
		render("index.jsp");
	}
}
