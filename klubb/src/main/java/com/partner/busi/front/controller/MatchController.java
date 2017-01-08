package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Activity;
import com.partner.busi.model.Match;

public class MatchController extends Controller {
	
	/**
	 * match list
	 */
	public void index(){
		render("match/matchlist.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		String title = getPara("title");
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Match> page = Match.dao.findList(title, pageNum, pageSize);
		renderJson(page);
	}

}
