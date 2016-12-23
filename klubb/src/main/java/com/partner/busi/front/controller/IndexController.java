/**
 * 
 */
package com.partner.busi.front.controller;

import java.util.List;

import com.jfinal.core.Controller;
import com.partner.busi.model.CUser;
import com.partner.busi.model.Config;
import com.partner.busi.model.Match;
import com.partner.busi.model.Notice;
import com.partner.busi.model.Picture;

/**
 * @author fangrui
 *
 */
public class IndexController extends Controller {
	
	public void index(){
		//获取最新公告
		Notice notice = Notice.dao.findNotice();
		setAttr("notice",notice);
		//获取最新比赛
		List<Match> matchLst = Match.dao.queryNewMatch();
		//获取 happytime 数据
		List<Picture> pictures = Picture.dao.findRecommendPic();
		setAttr("pictures",pictures);
		//获取联系我们数据
		Config config = Config.dao.findById(1);
		setAttr("config", config);
		render("index.jsp");
	}
}
