package com.partner.busi.model;

import com.jfinal.plugin.activerecord.Db;
import com.partner.busi.model.base.BaseGame;

import java.util.ArrayList;
import java.util.List;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Game extends BaseGame<Game> {
	public static final Game dao = new Game();
	
	/**
	 * 根据赛事ID删除所有比赛
	 * @param matchId
	 * @return
	 */
	public boolean deleteByMatchId(int matchId) {
		int rs = Db.update("delete from t_game where MATCH_ID = ?", matchId);
		if(rs==0){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 修改用户
	 * @param gameId
	 * @param userId
	 * @param userIndex
	 * @return
	 */
	public boolean updateUser(int gameId, Integer userId, int userIndex){
		int rs = Db.update("update t_game set USER"+userIndex+"=? where ID = ?", userId, gameId);
		return rs > 0;
	}
	
	/**
	 * 更新比分
	 * @param winId
	 * @param score1
	 * @param score2
	 * @return
	 */
	public boolean updateScore(int gameId, Integer winId, Integer score1, Integer score2){
		int rs = Db.update("update t_game set WINNER_ID=?, SCORE1=?, SCORE2=?, STATUS=2 where ID = ?", winId, score1, score2, gameId);
		return rs > 0;
	}
	
	/**
	 * 将用户移动到对应比赛
	 * @param matchId
	 * @param seq
	 * @param index
	 * @param userId
	 * @return
	 */
	public boolean moveUserToGame(int matchId, Integer seq, Integer index, Integer userId){
		int rs = Db.update("update t_game set USER" + index + "=? where MATCH_ID = ? and SEQ=?", userId, matchId, seq);
		return rs > 0;
	}
	
	public List<Game> sordMatch(int matchId){
		//List<Game> userList = new ArrayList<Game>();
		String sql = "select WINNER_NAME, USER_ID, winNum from (select u.NAME as WINNER_NAME, count(g.id) as winNum, u.id as USER_ID from t_game g, t_user u where g.WINNER_ID = u.ID and g.MATCH_ID = "+matchId+" group by g.WINNER_ID) temp order by winNum desc ";
//		userList = Db.query(sql);
		return dao.find(sql);
	}
	
	public List getMatchHis(int matchId, int userId){
		StringBuffer sql = new StringBuffer("select flag, seq from ( select 'win' as flag, seq, t1.WINNER_ID as userId from t_game t1 where t1.MATCH_ID = ");
		sql.append(matchId).append(" and t1.WINNER_ID = ").append(userId);
		sql.append(" union all select 'loser' as flag, seq, if(t2.USER1 = t2.WINNER_ID, t2.USER2, t2.USER1 ) as userid from t_game t2 where t2.MATCH_ID = ");
		sql.append(matchId).append(" and t2.WINNER_ID != ").append(userId).append(" and (t2.USER1 = ").append(userId);
		sql.append(" or t2.USER2 = ").append(userId).append(" ) ) as t3 order by seq");
		List<Game> userList = new ArrayList<Game>();
		//userList = Db.query(sql.toString());
		userList = dao.find(sql.toString());
		return userList;
		/*String[] strArray = new String[userList.size()];
		for(int i=0;i<userList.size();i++){
			Game game = userList.get(i);
			strArray[i]=game.getFlag();
		}
		return strArray;*/
	}

	public List<Game> getAgainstList(int martchId, Integer lastSeq, boolean isWin){
		String sql = "SELECT g.*, IFNULL(mu1.SEQ, 0) AS U1_SEQ, IFNULL(mu2.SEQ, 0) AS U2_SEQ,"
				+ " IFNULL(u1.`NAME`,'') as U1_NAME, IFNULL(u2.`NAME`,'') as U2_NAME"
				+ " FROM t_game g"
				+ " LEFT JOIN (select * from t_match_user where seq is not null) AS mu1 ON g.USER1 = mu1.USER_ID and g.MATCH_ID=mu1.MATCH_ID"
				+ " LEFT JOIN (select * from t_match_user where seq is not null) AS mu2 ON g.USER2 = mu2.USER_ID and g.MATCH_ID=mu2.MATCH_ID"
				+ " LEFT JOIN t_user AS u1 ON g.USER1 = u1.ID"
				+ " LEFT JOIN t_user AS u2 ON g.USER2 = u2.ID"
				+ " INNER JOIN t_match AS m ON m.ID = g.MATCH_ID"
				+ " WHERE g.MATCH_ID = ? and g.SHOW_INDEX is not null and %s"
				+ " ORDER BY g.SHOW_INDEX";
		final String WIN_CON = "(m.TYPE in (1, 3) or (m.TYPE in (2, 4) and L_NEXT_ID != ''))";
		final String LOSE_CON = "(m.TYPE in (2, 4) and L_NEXT_ID = '')";
		final String SEQ_CON = " and g.SEQ < ?";
		if (isWin){
			if(lastSeq != null){
				return Game.dao.find(String.format(sql, WIN_CON + SEQ_CON), martchId, lastSeq);
			}else{
				return Game.dao.find(String.format(sql, WIN_CON), martchId);
			}
		}else {
			if(lastSeq != null){
				return Game.dao.find(String.format(sql, LOSE_CON + SEQ_CON), martchId, lastSeq);
			}else{
				return Game.dao.find(String.format(sql, LOSE_CON), martchId);
			}
		}
	}

	public boolean generateThird(int matchId){
		String sql = "insert into t_game(SEQ, W_NEXT_ID, L_NEXT_ID, MATCH_ID, STATUS) values (" +
				"(select t.s + 1 from (select max(seq) as s from t_game where MATCH_ID=?) as t), '', '', ?, 0)";
		int rs = Db.update(sql, matchId, matchId);
		if (rs > 0){
			Game thirdGame = getThirdGame(matchId);
			sql = "update t_game set L_NEXT_ID=? where SEQ = ? and MATCH_ID=?";
			Db.update(sql, thirdGame.getSEQ() + "_1", thirdGame.getSEQ() - 3, matchId);
			Db.update(sql, thirdGame.getSEQ() + "_2", thirdGame.getSEQ() - 2, matchId);
		}
		return rs > 0;
	}

	public Game getThirdGame(int matchId){
		String sql = "SELECT g.*, IFNULL(mu1.SEQ, 0) AS U1_SEQ, IFNULL(mu2.SEQ, 0) AS U2_SEQ,"
				+ " IFNULL(u1.`NAME`,'') as U1_NAME, IFNULL(u2.`NAME`,'') as U2_NAME"
				+ " FROM t_game g"
				+ " LEFT JOIN (select * from t_match_user where seq is not null) AS mu1 ON g.USER1 = mu1.USER_ID and g.MATCH_ID=mu1.MATCH_ID"
				+ " LEFT JOIN (select * from t_match_user where seq is not null) AS mu2 ON g.USER2 = mu2.USER_ID and g.MATCH_ID=mu2.MATCH_ID"
				+ " LEFT JOIN t_user AS u1 ON g.USER1 = u1.ID"
				+ " LEFT JOIN t_user AS u2 ON g.USER2 = u2.ID"
				+ " INNER JOIN t_match AS m ON m.ID = g.MATCH_ID"
				+ " WHERE g.MATCH_ID = ? and g.SHOW_INDEX is null"
				+ " ORDER BY g.SHOW_INDEX";
		return dao.findFirst(sql, matchId);
	}

	/**
	 * 得到第二轮下一场比赛
	 * @param matchId
	 * @return
	 */
	public Game getSecondNextGame(int matchId){
		String sql = "select * from t_game where MATCH_ID = ? and (USER1 is null or USER2 is null) order by seq";
		return dao.findFirst(sql, matchId);
	}
	
	/**
	 * 根据用户ID+比赛ID，统计比赛记录
	 * @param matchId
	 * @param userId
	 * @return
	 */
	public List<Game> findGameListByUId(int matchId, int userId){
		String sql = "select * from t_game g where g.MATCH_ID = "+matchId+" and ( g.USER1 = "+userId+" or g.USER2 = "+userId+" )";
		return dao.find(sql);
	}
	/**
	 * 获取比赛场次
	 * @param matchId
	 * @return
	 */
	public Game maxMatchSeq(int matchId){
		String sql = "select max(seq)  as SEQ from t_game where match_id = "+matchId;
		return dao.findFirst(sql);
	}
	//获取胜者组回合数
	public int WinMatchNum(int matchId,int stopSeq){
		String sql = "select max(round_num) from t_game where MATCH_ID = "+matchId+" and L_NEXT_ID <> '' and seq < "+stopSeq;
		return Db.queryInt(sql).intValue();
	}
	//获取败者组回会数
	public int LoseMatchNum(int matchId,int stopSeq){
		String sql = "select max(round_num) from t_game where MATCH_ID = "+matchId+" and L_NEXT_ID = '' and seq < "+stopSeq;
		return Db.queryInt(sql).intValue();
	}
	//根据matchId + userId 获取game 信息
	public List<Game> getInfoByMidAndUid(int macthId, int userId, int stopSeq){
		String sql = "select SEQ, START_TIME, USER1, USER2, WINNER_ID, W_NEXT_ID, L_NEXT_ID, TYPE, ROUND_NUM, MATCH_ID, STATUS, WINNER_ID  from t_game where MATCH_ID = "+ macthId +" AND seq < "+stopSeq+" AND (USER1 = "+ userId +" OR USER2 = "+ userId+")";
		return dao.find(sql);
	}
	/**
	 * 统计参加比赛所获分数，单败比赛赢一次记2分，输一场记1分
	 * 双败比赛第一
	 * @param matchId
	 * @param userId
	 * @return
	 */
	public int countMatchScore(int matchId, int userId){
		
		Match match = Match.dao.findById(matchId);
		int matchFlag = 0;//0 单败   1 双败第一回合   2 双败第二回话
		int score = 0;
		//判断是否为双败比赛，以及双败比赛的第几回合
		if(match.getTYPE() == 2 || match.getTYPE() == 4){//表示为双败比赛第一回合
			matchFlag = 1;
		}else if (match.getPId() != null){//表示双败比赛的第二回合
			matchFlag = 2;
		}
		if(matchFlag == 1){//双峰比赛第一回合处理
			int stopSeq = Match.dao.getStopSeq(matchId); 
			
			int x = WinMatchNum(matchId, stopSeq);//胜者组回合数据
			int y = LoseMatchNum(matchId, stopSeq);//败者组回合数据
			boolean winFlag = false;//胜者组、败者组回合
			List<Game> games = getInfoByMidAndUid(matchId, userId, stopSeq);
			Game game1 = null;
			for(int i=0;i<games.size();i++){
				game1 = games.get(i);
				int roundNum = game1.getRoundNum();
				//判断用户是胜者组还是败者组
				if(game1.getLNextId().trim().length() != 0){
					winFlag = true;//为胜者组
				}
				if(winFlag){//再判断是胜还是败
					if(game1.getWinnerId()!=null && game1.getWinnerId() == userId){
						score = score + y+roundNum;
						if(roundNum == x || roundNum == y ){
							score  = 100;
						}
					}else{
						score = score - (x +1 -roundNum);
					}
				}else{//为败者组
					if(game1.getWinnerId() != null && game1.getWinnerId() == userId){
						score = score +roundNum;
						if(roundNum == x || roundNum == y ){
							score  = 100;
						}
					}else{
						score = score -( x +y +1 - roundNum);
					}
				}
				winFlag = false;
			}
			
			
		}else{
			Game game = Game.dao.maxMatchSeq(matchId);
			int  maxSeq =0;
			if(game.getSEQ() == null){
				return 0;
			}
			maxSeq = game.getSEQ();
			Game tempGame = null;
			List<Game> gameLst = this.findGameListByUId(matchId, userId);
			for(int i=0;i<gameLst.size();i++){
				tempGame = gameLst.get(i);
				if(tempGame.getWinnerId() == null){
					if(tempGame.getSTATUS() == 2 && (tempGame.getUSER1() == null || tempGame.getUSER2() == null)){
						score = score+2;
					}
				}else if(tempGame.getWinnerId() == userId){
					score = score+2;
				}else{
					if(match.getTHIRD()==1 && (maxSeq-1)!=tempGame.getSEQ()){
						score = score-1;
					}
				}
			}
		}
		User user = User.dao.findById(userId);
		System.out.println(" Uid: "+ userId+"   Name : "+user.getNAME()+" >>>>>>>>>>>>  Score : "+score);
		return score;
	}

	/**
	 * 用于双败转单败，删除上一轮同场比赛的两人
	 * @param game
	 * @param matchId
	 * @return
	 */
	public boolean deleteByGame(int matchId, Game game){
		String sql = "update t_game set user1=null where match_id=? and (user1 = ? or user1 = ?)";
		int rs1 = Db.update(sql, matchId, game.getUSER1(), game.getUSER2());
		sql = "update t_game set user2=null where match_id=? and (user2 = ? or user2 = ?)";
		int rs2 = Db.update(sql, matchId, game.getUSER1(), game.getUSER2());
		return rs1 + rs2 > 0;
	}

	public boolean isLastGame(Game game){
		String sql = "select count(*) from t_game where match_id=? and seq > ?";
		long rs = Db.queryLong(sql, game.getMatchId(), game.getSEQ());
		return rs == 0;
	}

	public void setU1_SEQ(Long seq) {
		set("U1_SEQ", seq);
	}
	
	public Long getU1_SEQ() {
		return get("U1_SEQ");
	}
	
	public void setU2_SEQ(Long seq) {
		set("U2_SEQ", seq);
	}
	
	public Long getU2_SEQ() {
		return get("U2_SEQ");
	}
	
	public void setU1_NAME(String name) {
		set("U1_NAME", name);
	}
	
	public String getU1_NAME() {
		return get("U1_NAME");
	}
	
	public void setU2_NAME(String name) {
		set("U2_NAME", name);
	}
	
	public String getU2_NAME() {
		return get("U2_NAME");
	}
	
	public void setUSER_ID(int userId) {
		set("USER_ID", userId);
	}
	
	public int getUSER_ID() {
		return get("USER_ID");
	}
	
	public void setWINNER_NAME(String name) {
		set("WINNER_NAME", name);
	}
	
	public String getWINNER_NAME() {
		return get("WINNER_NAME");
	}
	
	public void setWinNum(long winNum) {
		set("winNum", winNum);
	}
	
	public long getWinNum() {
		return get("winNum");
	}
	
	public void setFlag(String name) {
		set("flag", name);
	}
	
	public String getFlag() {
		return get("flag");
	}
	
	public List getMatchFlag(){
		return get("matchFlag");
	}
	
	public void setMatchFlag(List matchFlag){
		set("matchFlag",matchFlag);
	}
	
}
