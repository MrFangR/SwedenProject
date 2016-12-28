package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Match;
import com.partner.common.constant.Constants;

public class BackMatchListController extends Controller {
	
	/**
	 * 比赛列表
	 */
	public void index(){
		render("match_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = Constants.PAGESIZE;
		
		Page<Match> page = Match.dao.paginate(pageNum, pageSize, "select * ", " from t_match  where STATUS != -1 AND P_ID is null order by START_TIME desc");
		setAttr("paginate", page);
		render("match_list_result.jsp");
	}
	
	/**
     * 比赛 新增/更新
     */
	public void saveOrUpdate(){
    	boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Match mat = getModel(Match.class);
		
		mat.set("STATUS", 0);
		rsFlag = mat.save();
		rsMsg = "发布成功";
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
    }
	
	

}
