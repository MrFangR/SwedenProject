package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Picture;

public class HappyTimesController  extends Controller { 
	
	/**
	 * to happytimes
	 */
	public void index(){
		render("happytimes/happytimes.jsp");
	}
	
	/**
	 * show happytimes details
	 */
	public void showHTdetails(){
		String picID = getPara("picID");
		Picture pic = Picture.dao.findById(picID);
		setAttr("pic", pic);
		render("happytimes/happytimescont.jsp");
	}
	
	/**
	 * show happytimes
	 */
	public void showHappy(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Picture> page = Picture.dao.findPic(pageNum,pageSize);
		setAttr("page", page);
		renderJson();
	}

}
