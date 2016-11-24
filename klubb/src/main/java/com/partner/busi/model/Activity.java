package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseActivity;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Activity extends BaseActivity<Activity> {
	public static final Activity dao = new Activity();
	
	/**
	 * 活动名称唯一性校验
	 * @return
	 */
	public boolean findActByName(String actName){
		Long rs = Db.queryLong("select count(*) from t_activity where TITLE = ?",actName);
		if(rs==0){
			return false;
		}else{
			return true;
		}
	}

	public Map<String, List<Activity>> getActivityList() {
		// TODO Auto-generated method stub
		return null;
	}

	public Page<Activity> findList(String title, int pageNum, Integer pagesize) {
		String select = "select a.*";
		StringBuilder sql = new StringBuilder(" from t_activity a where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if (StringUtils.isNotBlank(title)) {
			sql.append(" and a.TITLE like ? ");
			params.add("%" + title + "%");
		}
		sql.append(" order by a.CREATE_TIME desc");
		return paginate(pageNum, pagesize, select, sql.toString(), params.toArray());
	}

	public Page<Activity> findAllActByUser(String userNo, int pageNum, int pageSize) {
		String select = "select a.*";
		StringBuilder sql = new StringBuilder(" from t_activity a where a.ID in ( SELECT u.ACT_ID FROM t_act_user u where u.USER_ID=?) ORDER BY a.CREATE_TIME DESC ");
		List<Object> params = new ArrayList<Object>();
		params.add(userNo);
		return paginate(pageNum, pageSize, select, sql.toString(), params.toArray());
	}
	
	
	
	
}
