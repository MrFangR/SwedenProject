package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseActUser;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class ActUser extends BaseActUser<ActUser> {
	public static final ActUser dao = new ActUser();

	public boolean findUserByEmail(String Email, String actId) {
		Long rs = Db.queryLong("select count(*) from t_act_user where ACT_ID = ? and EMAIL=?",actId,Email);
		if(rs==0){
			return false;
		}else{
			return true;
		}
	}

	public boolean findUserByPhone(String Phone, String actId) {
		Long rs = Db.queryLong("select count(*) from t_act_user where ACT_ID = ? and PHONE = ?",actId,Phone);
		if(rs==0){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 根据活动id查询参与用户
	 */
	public List<ActUser> getUserByActId(Integer ActId){
		return find("select s.* from t_act_user s where s.ACT_ID = ?", ActId);
	}

	public Page<ActUser> findList(String userName, int actID, int pageNum,
			Integer pagesize) {
		String select = "select a.*";
		StringBuilder sql = new StringBuilder(" from t_act_user a where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if (StringUtils.isNotBlank(userName)) {
			sql.append(" and a.NAME like ? ");
			params.add("%" + userName + "%");
		}
		sql.append("and ACT_ID="+actID+" order by a.CREATE_TIME desc");
		return paginate(pageNum, pagesize, select, sql.toString(), params.toArray());
	}

	public boolean deleteByUserIdAndActId(Integer userId, int actId) {
		int rs = Db.update("delete from t_act_user where USER_ID = ? and ACT_ID = ?",userId,actId);
		if(rs==0){
			return false;
		}else{
			return true;
		}
	}

	public List<ActUser> findUserList(Integer userID, String phone, String email) {
		String sql = "select * from t_act_user where USER_ID = ? OR phone = ? OR EMAIL = ?";
		List<Object> paraLst = new  ArrayList<Object>();
			paraLst.add(userID);
			paraLst.add(phone);
			paraLst.add(email);
		return dao.find(sql,paraLst.toArray());
	}
}
