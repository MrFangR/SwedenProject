/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.partner.busi.model.Notice;
import com.partner.common.base.ResultInfo;

/**
 * @author fangrui
 *
 */
public class BackNoticeController extends Controller {

	public void index(){
		Notice notice = Notice.dao.findNotice();
		setAttr("notice",notice);
		render("config_notice.jsp");
	}
	
	public void saveOrUpdate(){
		Notice notice = Notice.dao.findNotice();
		if(notice == null){
			notice.setCONTENT(getPara("notice_text"));
			notice.setSTATUS(0);
			notice.save();
		}else{
			notice.setCONTENT(getPara("notice_text"));
			notice.update();
		}
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("发布成功");
		renderJson(retInfo);
	}
}
