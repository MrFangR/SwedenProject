/**
 * 编辑参赛人员controller
 */
package com.partner.busi.front.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.partner.busi.model.MatchUser;

/**
 * @author fangrui
 *
 */
public class MatchUserEditController extends Controller {

	public void index(){
		render("index.jsp");
	}
	
	public void getUserLst(){
		int matchId = getParaToInt("matchId");
		Map<String,Object> params = new HashMap();
		params.put("matchId", matchId);
		List<MatchUser> matchUserLst = MatchUser.dao.findUserByMatchId(params);
		//setAttr("matchUserLst",matchUserLst);
		renderJson(matchUserLst);
	}
}
