package com.partner.busi.back.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.MatchUser;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;

/**
 * 
 * @author fangrui
 * #desc 编辑参赛人员
 */
public class BackEditMatchUserController extends Controller {

	public void index(){
		String tabFlag = getPara("flag");
		if(StringUtils.isNotBlank(tabFlag) && "editUser".equals(tabFlag)){
			setAttr("tabFlag",tabFlag);
		}
		String pageNum = getPara("pageNum");
		int currPageNum=1;
		int currPageSize=Constants.PAGESIZE;
		if(StringUtils.isNotBlank(pageNum)){
			currPageNum = Integer.parseInt(pageNum);
		}
		String pageSize = getPara("pageSize");
		if(StringUtils.isNotBlank(pageSize)){
			currPageSize = Integer.parseInt(pageSize);
		}
		String  matchId = getPara("matchId");
		if(StringUtils.isBlank(matchId)){
			matchId = "2";
		}
		Page<MatchUser> matchUser = MatchUser.dao.findMatchUserListBySeq(currPageNum, currPageSize, matchId);
		setAttr("matchUser",matchUser);
		List<MatchUser> noMatchUser = MatchUser.dao.findMatchUserListNoSeq(matchId);
		setAttr("noMatchUser", noMatchUser);
		//获取全部报名人员
		List<MatchUser> allMatchUser = MatchUser.dao.findMatchUserListByMatchId(matchId);
		setAttr("allMatchUser",allMatchUser);
		render("match_user_edit.jsp");
	}
	
	public void delUser(){
		ResultInfo retInfo = new ResultInfo();
		String id = getPara("id");
		MatchUser user = MatchUser.dao.findById(id);
		if(user == null){
			retInfo.setRetCode(1);
			retInfo.setRetMsg("参赛人员获取失败，请稍后再试！");
		}else{
			int flag = MatchUser.dao.batchUpdateSeq(user.getMatchId(), user.getSEQ());
			user.setSEQ(null);
			user.update();
			retInfo.setRetCode(0);
			retInfo.setRetMsg("参赛人员删除成功！");
		}
		renderJson(retInfo);
	}
	
	public void addUser(){
		String id = getPara("id");
		MatchUser user = MatchUser.dao.findById(id);
		int maxSeq = MatchUser.dao.countMatchPersion(user.getMatchId());
		user.setSEQ(maxSeq+1);
		user.update();
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("添加成功");
		renderJson(retInfo);
	}
	
	public void setScore(){
		ResultInfo retInfo = new ResultInfo();
		int id = getParaToInt("id");
		String score = getPara("score");
		int result = MatchUser.dao.updateStartScore(id, score);
		if(result>0){
			retInfo.setRetCode(0);
			retInfo.setRetMsg("更新成功");
		}else{
			retInfo.setRetCode(1);
			retInfo.setRetMsg("更新失败");
		}
		renderJson(retInfo);
	}
	
}
