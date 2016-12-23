package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseMatch;

public class Match extends BaseMatch<Match> {

	public static final Match dao = new Match();
	
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
		sql.append(" order by START_TIME desc");
		return paginate(pageNum, pagesize, select, sql.toString(), params.toArray());
	}
}
