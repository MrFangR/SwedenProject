package com.partner.busi.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BaseMatch;

import org.apache.commons.lang.StringUtils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Match extends BaseMatch<Match> {
	
	public static final Match dao = new Match();
	
	public void setPlayerNum(java.lang.Long playerNum) {
		set("PLAYER_NUM", playerNum);
	}

	public java.lang.Long getPlayerNum() {
		return get("PLAYER_NUM");
	}
	

	public String getStartDateStr() {
		Date startDate = this.getStartDate();
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatDate.format(startDate);
	}
	
	public List<Match> queryNewMatch(){
		return dao.find("select ID, NAME, IMG, DESCRIPTION from t_match where p_id is null and STATUS != -1 order by start_date desc");
	}
	
	public Page<Match> findList(String title, int pageNum, Integer pagesize, int status) {
		String select = "select * ";
		StringBuilder sql = new StringBuilder(" from t_match  where p_id is null ");
		List<Object> params = new ArrayList<Object>();
		if (StringUtils.isNotBlank(title)) {
			sql.append(" and NAME like ? ");
			params.add("%" + title + "%");
		}
		sql.append(" and STATUS=? ");
		params.add(status);
		
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
		StringBuilder sql = new StringBuilder(" from t_match a where a.ID in ( SELECT u.MATCH_ID FROM t_match_user u where u.USER_ID=?) AND a.STATUS<>-1 ORDER BY a.START_DATE DESC ");
		List<Object> params = new ArrayList<Object>();
		params.add(userID);
		return paginate(pageNum, pageSize, select, sql.toString(), params.toArray());
	}


	/**
	 * 获取当前剩余人员（用于双败比赛）
	 * 双败比赛只有败者组会淘汰人，总人数-败者组淘汰掉的人数
	 * @param martchId
	 * @return
	 */
	public int getCurrRemainPlayer(int martchId){
		String sql = "select (select count(*) from t_match_user m where m.MATCH_ID = ? and m.SEQ is not null)" +
				"-" +
				"(select count(*) from t_game g where g.MATCH_ID = ? and g.L_NEXT_ID = '' and g.W_NEXT_ID != '' and g.WINNER_ID is not null)";

		return Db.queryInt(sql, martchId, martchId).intValue();
	}

	/**
	 * 得到最后的seq（用于双败比赛）
	 * @param martchId
	 * @return
	 */
	public Integer getStopSeq(int martchId){
		String sql = "select (select ROUND(count(*)/2)*2 from t_match_user u where u.MATCH_ID = ? and u.SEQ is not null) - " +
				"(select IFNULL(m.STOP_PLAYER,0) from t_match m where m.ID = ?) + " +
				"(select count(*) from t_game g where g.MATCH_ID = ? and g.ROUND_NUM=1 and g.L_NEXT_ID != '' and ((g.USER1 is null and g.USER2 is not null) or (g.USER2 is null and g.USER1 is not null)))";
		int losePlayer = Db.queryBigDecimal(sql, martchId, martchId, martchId).intValue();

		if(losePlayer + 1 <= 1){
			return null;
		}

		sql = "select max(seq) from (select * from t_game g where g.MATCH_ID = ? and ((g.L_NEXT_ID = '' and g.W_NEXT_ID != '') or (g.L_NEXT_ID = '' and g.W_NEXT_ID = '')) ORDER BY g.SEQ LIMIT ?) as a";
		return Db.queryInt(sql, martchId, losePlayer + 1);
	}

	/**
	 * 子比赛ID
	 * @param martchId
	 * @return
	 */
	public Integer getChildMatchId(int martchId){
		String sql = "select ID from t_match where p_id=?";
		return Db.queryInt(sql, martchId);
	}
}
