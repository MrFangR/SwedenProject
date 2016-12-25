package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.partner.busi.model.base.BaseMatchUser;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class MatchUser extends BaseMatchUser<MatchUser> {
	public static final MatchUser dao = new MatchUser();
	
	public List<MatchUser> findUserByMatchId(Map<String,Object> params){
		String sql = "select * from t_match_user where 1=1 order by CREATE_TIME ";
		List<Object> paraLst = new  ArrayList<Object>();
		if(StringUtils.isNotBlank(params.get("matchId").toString())){
			sql +=" AND MATCH_ID = ?  ";
			paraLst.add(params.get("matchId").toString());
		}
		if(StringUtils.isNotBlank(params.get("userId").toString())){
			sql +=" AND USER_ID = ? ";
			paraLst.add(params.get("userId").toString());
		}
		return dao.find(sql,paraLst.toArray());
	};
	
	public void delMatchUser(int matchId, int userId){
		MatchUser user = dao.findFirst("select * from t_match_user where MATCH_ID = "+matchId+" AND USER_ID = "+userId);
		//user.set(attr, value);//修改状态，增加状态用来标记用户是否参加比赛
		dao.update();
	}
}
