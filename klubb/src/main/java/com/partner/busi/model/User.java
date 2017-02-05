package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseUser;
import com.partner.common.util.StringUtil;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class User extends BaseUser<User> {
	public static final User dao = new User();
	
	public User findByLogin(String email, String pwd){
		return dao.findFirst("select * from t_user where status = 0 and EMAIL = ? and password = ?", email, pwd);
	}
	
	public User findByEmail(String email){
		return dao.findFirst("select * from t_user where status = 0 and EMAIL = ? ", email);
	}
	
	public User findByEmailAndStatus(String email, int status){
		return dao.findFirst("select * from t_user where status = ? and EMAIL = ? ", status, email);
	}
	
	public Page<User> findUserLst(int pageNumber,int pageSize, String title){
		String selSql = "select *  ";
		List<Object> paramList=new ArrayList<Object>();
		StringBuffer whereSql = new StringBuffer(" from t_user where 1=1 ");
		if(!StringUtil.isBlank(title)){
			whereSql.append(" and ( EMAIL like concat('%',?,'%')");
			paramList.add(title);
			whereSql.append(" or  NAME like concat('%',?,'%')");
			paramList.add(title);
			whereSql.append(" or  NICKNAME like concat('%',?,'%'))");
			paramList.add(title);
		}
		return paginate(pageNumber, pageSize, selSql, whereSql.toString(),paramList.toArray());
	}
	
	public List<User> findNoMatchUser(int matchId){
		StringBuilder sql = new StringBuilder(" SELECT * FROM t_user where ID not in ( SELECT USER_ID FROM  t_match_user where SEQ IS NOT NULL and MATCH_ID = "+matchId+" )");
		return dao.find(sql.toString());
	}
}
