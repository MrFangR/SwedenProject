/**
 * 编辑参赛人员controller
 */
package com.partner.busi.front.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchUser;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.util.FrontSessionUtil;

/**
 * @author fangrui
 *
 */
public class MatchDetailController extends Controller {

	public void index(){
		String matchId = getPara("matchId");
		Match match = Match.dao.findById(matchId);
		setAttr("match",match);
		List<MatchUser> userLst = MatchUser.dao.findMatchUserListByMatchId(matchId);
		setAttr("userLst",userLst);
		//判断当前用户是否已报名
		User loginUser = FrontSessionUtil.getSession(getRequest());
		int applyFlag = 0; //报名按钮标志  0 未报名  1 已报名  2 比赛报名人数已满
		if(loginUser != null && loginUser.getID() != null){
			//检查此用户目前是否已经报名
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("matchId", matchId);
			params.put("userId", loginUser.getID());
			List<MatchUser> currUser = MatchUser.dao.findUserByMatchId(params);
			if(userLst == null || userLst.size()==0){//未报名
				//获取比赛最大参赛人数
				//获取目前报名的最大seq
				int seq = MatchUser.dao.countMatchPersion(Integer.parseInt(matchId));
				if(seq>=match.getMaxPlayer()){
					applyFlag = 2;
				}
			}else{//已报名
				applyFlag = 1;
			}
		}
		setAttr("applyFlag",applyFlag);
		render("matchDeatil.jsp");
	}
	
	public void getUserLst(){
		int matchId = getParaToInt("matchId");
		Map<String,Object> params = new HashMap();
		params.put("matchId", matchId);
		List<MatchUser> matchUserLst = MatchUser.dao.findUserByMatchId(params);
		//setAttr("matchUserLst",matchUserLst);
		renderJson(matchUserLst);
	}
	
	public void addMatch(){
		int matchId = getParaToInt("matchId");
		ResultInfo ret = new ResultInfo();
		ret.setRetCode(1);
		ret.setRetMsg("用户未登录");
		//判断用户是否已经登录
		User loginUser = FrontSessionUtil.getSession(getRequest());
		if(loginUser != null && loginUser.getID() != null){
			//检查此用户目前是否已经报名
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("matchId", matchId);
			params.put("userId", loginUser.getID());
			List<MatchUser> userLst = MatchUser.dao.findUserByMatchId(params);
			if(userLst == null || userLst.size()==0){
				//获取比赛最大参赛人数
				Match match = Match.dao.findById(matchId);
				//获取目前报名的最大seq
				int seq = MatchUser.dao.countMatchPersion(matchId);
				if(seq!=0 && seq<match.getMaxPlayer()){
					MatchUser matchUser = new MatchUser();
					matchUser.setMatchId(matchId);
					matchUser.setSEQ(seq+1);
					matchUser.setUserId(loginUser.getID());
					matchUser.setCreateTime(new Date());
					matchUser.save();
					ret.setRetCode(0);
					ret.setRetMsg("报名成功");
				}else{
					ret.setRetMsg("报名人数已达上限");
				}
			}else{
				ret.setRetMsg("当前用户已报名");
			}
		}
		renderJson(ret);
	}
}
