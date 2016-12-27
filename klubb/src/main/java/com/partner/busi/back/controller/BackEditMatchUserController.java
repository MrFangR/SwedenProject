package com.partner.busi.back.controller;

import org.apache.commons.lang.StringUtils;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.MatchUser;
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
		render("match_user_edit.jsp");
	}
}
