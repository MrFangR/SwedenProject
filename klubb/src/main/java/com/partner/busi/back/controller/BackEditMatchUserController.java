package com.partner.busi.back.controller;

import java.util.List;

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
		Page<MatchUser> matchUser = MatchUser.dao.findMatchUserListBySeq(currPageNum, currPageSize);
		setAttr("matchUser",matchUser);
		List<MatchUser> noMatchUser = MatchUser.dao.findMatchUserListNoSeq();
		setAttr("noMatchUser", noMatchUser);
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
			if(flag < 1){
				retInfo.setRetCode(1);
				retInfo.setRetMsg("参赛人员删除失败，请稍后再试！");
			}else{
				user.setSEQ(null);
				user.update();
				retInfo.setRetCode(0);
				retInfo.setRetMsg("参赛人员删除成功！");
			}
		}
		renderJson(retInfo);
	}
}
