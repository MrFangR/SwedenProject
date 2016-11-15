/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.partner.busi.model.CUser;
import com.partner.busi.model.Notice;
import com.partner.busi.model.Picture;

/**
 * @author fangrui
 *
 */
public class IndexController extends Controller {
	
	public void index(){
		//获取最新公告
		List<Notice> noticeAll = Notice.dao.findAll();
		setAttr("noticeAll",noticeAll);
		//获取 happytime 数据
		List<Picture> pictures = Picture.dao.findAll();
		setAttr("pictures",pictures);
		render("index.jsp");
	}
}
