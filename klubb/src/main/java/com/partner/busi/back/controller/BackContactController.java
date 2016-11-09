/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.jfinal.ext.route.ControllerBind;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Contact;

/** 
 * @ClassName: ContactController 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午3:45:05  
 */
public class BackContactController extends Controller {
	
	private final static Integer pageSize = 10; //每页显示数量
	
	public void index(){
		render("contact/contact_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void search(){
		String phone = getPara("phone");
		String status = getPara("status");
		int pageNum = getParaToInt("pageNum");
		
		Page<Contact> page = Contact.dao.search(phone, status, pageNum, pageSize);
		setAttr("paginate", page);
		render("contact/contact_list_result.jsp");
	}
	
	/**
	 * 修改已读未读
	 */
	public void updateStatus(){
		String contactId = getPara("contactId");
		String status = getPara("status");
		Contact contact = Contact.dao.findById(contactId);
		int flag = 1;
		String msg = "标记失败，请稍后再试！";
		if(contact != null){
			contact.set("STATUS", status);
			boolean rs = contact.update();
			if(rs){
				flag = 0;
				msg = "标记成功";
			}
		}
		renderJson("flag", flag);
		renderJson("msg", msg);
	}
    
}
