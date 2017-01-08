package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseMatch;

public class Match extends BaseMatch<Match> {
	
	public static final Match dao = new Match();
	
	public void setPlayerNum(java.lang.Long playerNum) {
		set("PLAYER_NUM", playerNum);
	}

	public java.lang.Long getPlayerNum() {
		return get("PLAYER_NUM");
	}
	
	public List<Match> queryNewMatch(){
		return dao.find("select ID, NAME, IMG, DESCRIPTION from t_match where p_id is null and STATUS != -1 order by start_date desc;");
	}
	
	public Page<Match> findList(String title, int pageNum, Integer pagesize) {
		String select = "select * ";
		StringBuilder sql = new StringBuilder(" from t_match  where STATUS != -1 AND p_id is null ");
		List<Object> params = new ArrayList<Object>();
		if (StringUtils.isNotBlank(title)) {
			sql.append(" and NAME like ? ");
			params.add("%" + title + "%");
		}
		sql.append(" order by START_DATE desc");
		return paginate(pageNum, pagesize, select, sql.toString(), params.toArray());
	}
	
	public Page<Match> findListAndUser(int pageNum, Integer pagesize) {
		String select = "select a.ID,a.NAME,a.IMG,a.TYPE,a.THIRD,a.START_DATE,a.DESCRIPTION,a.STATUS,a.P_ID, COUNT(b.MATCH_ID) as PLAYER_NUM ";
		StringBuilder sql = new StringBuilder(" from t_match a LEFT JOIN t_match_user b ON a.ID=b.MATCH_ID where a.STATUS != -1 AND a.p_id is null GROUP BY a.ID ");
		sql.append(" order by START_DATE desc");
		return paginate(pageNum, pagesize, select, sql.toString());
	}

	public Page<Match> findAllMatByUser(Integer userID, int pageNum, int pageSize) {
		String select = "select a.*";
		StringBuilder sql = new StringBuilder(" from t_match a where a.ID in ( SELECT u.MATCH_ID FROM t_match_user u where u.USER_ID=?) ORDER BY a.START_DATE DESC ");
		List<Object> params = new ArrayList<Object>();
		params.add(userID);
		return paginate(pageNum, pageSize, select, sql.toString(), params.toArray());
	}
}
