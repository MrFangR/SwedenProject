/**
 * 
 */
package com.partner.busi.back.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchTemplate.GameTemplate;
import com.partner.busi.model.MatchUser;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.MatchTemplateCache;

/** 
 * @ClassName: BackMatchController 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月25日 上午12:39:40  
 */
public class BackMatchController extends Controller {
	
	public void index(){
		Integer matchId = getParaToInt("matchId");
		String sql = "SELECT g.*, IFNULL(mu1.SEQ, 0) AS U1_SEQ, IFNULL(mu2.SEQ, 0) AS U2_SEQ,"
				+ " IFNULL(u1.`NAME`,'') as U1_NAME, IFNULL(u2.`NAME`,'') as U2_NAME"
				+ " FROM t_game g"
				+ " LEFT JOIN t_match_user AS mu1 ON g.USER1 = mu1.USER_ID and g.MATCH_ID=mu1.MATCH_ID"
				+ " LEFT JOIN t_match_user AS mu2 ON g.USER2 = mu2.USER_ID and g.MATCH_ID=mu2.MATCH_ID"
				+ " LEFT JOIN t_user AS u1 ON g.USER1 = u1.ID"
				+ " LEFT JOIN t_user AS u2 ON g.USER2 = u2.ID"
				+ " INNER JOIN t_match AS m ON m.ID = g.MATCH_ID"
				+ " WHERE g.MATCH_ID = ? and %s"
				+ " ORDER BY g.SHOW_INDEX";
		final String WIN_CON = "(m.TYPE in (1, 3) or (m.TYPE in (2, 4) and L_NEXT_ID != ''))";
		final String LOSE_CON = "(m.TYPE in (2, 4) and L_NEXT_ID = '')";
		
		List<Game> wList = Game.dao.find(String.format(sql, WIN_CON), matchId);
		List<Game> lList = Game.dao.find(String.format(sql, LOSE_CON), matchId);
		
		List<String> winTitleList = new ArrayList<String>();
		List<String> loseTitleList = new ArrayList<String>();
		
		List<List<Game>> winList = generateList(wList, winTitleList, true);
		List<List<Game>> loseList = generateList(lList, loseTitleList, false);
		
		Match match = Match.dao.findById(matchId);
		
		setAttr("match", match);
		setAttr("winList", winList);
		setAttr("winTitleList", winTitleList);
		setAttr("loseList", loseList);
		setAttr("loseTitleList", loseTitleList);
		
		String tabFlag = getPara("flag");
		if(StringUtils.isNotBlank(tabFlag)){
			setAttr("tabFlag",tabFlag);
		}
		List<MatchUser> matchUser = MatchUser.dao.findMatchUserListBySeq(String.valueOf(matchId));
		setAttr("matchUser",matchUser);
		List<MatchUser> noMatchUser = MatchUser.dao.findMatchUserListNoSeq(String.valueOf(matchId));
		setAttr("noMatchUser", noMatchUser);
		//获取全部报名人员
		List<MatchUser> allMatchUser = MatchUser.dao.findMatchUserListByMatchId(String.valueOf(matchId));
		setAttr("allMatchUser",allMatchUser);
		
		render("match_edit.jsp");
	}
	
	/**
	 * 初始化轮空的比赛
	 * @param matchId
	 * @return
	 */
	private void initByeGame(int matchId){
		List<Game> gameList = Game.dao.find("select * from t_game g where g.MATCH_ID=?", matchId);
		List<Game> round1GameList = Game.dao.find("select * from t_game g where g.MATCH_ID=? and g.ROUND_NUM=1 order by g.SEQ", matchId);
		for(Game game : round1GameList){
			if((game.getUSER1() != null && game.getUSER2() == null) || (game.getUSER1() == null && game.getUSER2() != null)){ //有轮空人员
				String W_NEXT_ID = game.getWNextId();
				
				//获得唯一参赛者
				Integer userId = null;
				if(game.getUSER1() != null){
					userId = game.getUSER1();
				}else if(game.getUSER2() != null){
					userId = game.getUSER2();
				}
				
				//修改下一场比赛中参赛者
				if(StringUtils.isNotBlank(W_NEXT_ID)){ //下一场比赛不为空
					Integer seq = Integer.parseInt(W_NEXT_ID.split("_")[0]);
					int nextIndex = Integer.parseInt(W_NEXT_ID.split("_")[1]);
					for(Game toGame : gameList){
						if(toGame.getSEQ().equals(seq)){ //下一场比赛
							if(nextIndex == 1){
								toGame.setUSER1(userId);
							}else if(nextIndex == 2){
								toGame.setUSER2(userId);
							}
							toGame.update();
							break;
						}
					}
				}
			}
		}
	}
	
	
	/**
	 * 更新比分
	 */
	public void updateScore(){
		Integer winId = getParaToInt("winId");
		Integer score1 = getParaToInt("score1");
		Integer score2 = getParaToInt("score2");
		Integer gameId = getParaToInt("gameId");
		boolean rsFlag = false;
		try {
			rsFlag = updateScoreTx(winId, score1, score2, gameId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson("rsFlag", rsFlag);
	}
	
	@Before(Tx.class)
	private boolean updateScoreTx(Integer winId, Integer score1, Integer score2, Integer gameId) throws SQLException{
		boolean flag1 = Game.dao.updateScore(gameId, winId, score1, score2);
		boolean flag2 = true;
		boolean flag3 = true;
		
		Game game = Game.dao.findById(gameId);
		String wNextId = game.getWNextId();
		if(StringUtils.isNotBlank(wNextId)){ //胜者组迁移
			Integer seq = Integer.parseInt(wNextId.split("_")[0]);
			Integer index = Integer.parseInt(wNextId.split("_")[1]);
			flag2 = Game.dao.moveUserToGame(game.getMatchId(), seq, index, winId);
		}
		
		String lNextId = game.getLNextId();
		if(StringUtils.isNotBlank(lNextId)){ //败者组迁移
			Integer seq = Integer.parseInt(lNextId.split("_")[0]);
			Integer index = Integer.parseInt(lNextId.split("_")[1]);
			Integer loseId = (game.getUSER1().equals(winId)) ? game.getUSER2() : game.getUSER1();
			flag3 = Game.dao.moveUserToGame(game.getMatchId(), seq, index, loseId);
		}
		if(flag1 && flag2 && flag3){
			return true;
		}else{
			DbKit.getConfig().getConnection().rollback();
			return false;
		}
	}
	
	/**
	 * 修改比赛信息
	 */
	public void updateGameInfo(){
		String tableNum = getPara("tableNum");
		String startTimeStr = getPara("startTime");
		Integer type = getParaToInt("type");
		Integer gameId = getParaToInt("gameId");
		
		
		boolean rsFlag = false;
		try {
			Date startTime = null;
			if (StringUtils.isNotEmpty(startTimeStr)) {
				startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startTimeStr);
			}
			Game game = Game.dao.findById(gameId);
			game.setTableNum(tableNum);
			game.setTYPE(type);
			game.setStartTime(startTime);
			rsFlag = game.update();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rsFlag = false;
		}
		renderJson("rsFlag", rsFlag);
	}
	
	/**
	 * 交换
	 */
	public void exchange(){
		Integer gameId1 = getParaToInt("gameId1");
		Integer gameId2 = getParaToInt("gameId2");
		Integer userIndex1 = getParaToInt("userIndex1");
		Integer userIndex2 = getParaToInt("userIndex2");
		Integer userId1 = getParaToInt("userId1");
		Integer userId2 = getParaToInt("userId2");
		
		boolean rsFlag = false;
		try {
			rsFlag = updateUsers(gameId1, gameId2, userIndex1, userIndex2, userId1, userId2);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson("rsFlag", rsFlag);
	}
	
	@Before(Tx.class)
	private boolean updateUsers(Integer gameId1, Integer gameId2, Integer userIndex1, Integer userIndex2, Integer userId1, Integer userId2) throws SQLException{
		boolean flag1 = Game.dao.updateUser(gameId1, userId1, userIndex1);
		boolean flag2 = Game.dao.updateUser(gameId2, userId2, userIndex2);
		if(flag1 && flag2){
			return true;
		}else{
			DbKit.getConfig().getConnection().rollback();
			return false;
		}
	}
	
	private List<List<Game>> generateList(List<Game> list, List<String> titleList, boolean isWin){
		List<List<Game>> retList = new ArrayList<List<Game>>();

		List<Integer> roundList = new ArrayList<Integer>();
		for(Game game : list){
			if(!roundList.contains(game.getRoundNum())){
				roundList.add(game.getRoundNum());
				retList.add(new ArrayList<Game>());
			}
		}
		if(isWin){
			for(int i = 0; i < roundList.size(); i++){
				if(i == roundList.size() - 1){
					titleList.add("决赛");
				}else if(i == roundList.size() - 2){
					titleList.add("半决赛");
				}else{
					titleList.add("第" + roundList.get(i) + "轮");
				}
			}
		}else{
			for(int i = 0; i < roundList.size(); i++){
				titleList.add("败者组回合" + roundList.get(i));
			}
		}
		
		for(Game game : list){
			retList.get(game.getRoundNum() - 1).add(game);
		}
		return retList;
	}
	
	public void generateGame(){
		Integer matchId = getParaToInt("matchId");
		Match match = Match.dao.findById(matchId);
		if(match != null && match.getSTATUS() == 0){ //比赛未开始，根据当前用户信息重新生成比赛
			//1.删除本赛事下所有比赛
			Game.dao.deleteByMatchId(matchId);
			//2.根据当前人员生成比赛
			//2.1获取当前参赛人员，orderby seq
			List<MatchUser> list = MatchUser.dao.findUserByMatchId(matchId);
			List<Integer> userIdList = new ArrayList<Integer>();
			for(MatchUser user : list){
				userIdList.add(user.getUserId());
			}
			//2.2生成比赛
			if(match.getTYPE() == 1 || match.getTYPE() == 3){ //单败
//				generateSingleGame(userIdList, 0, 0, 1, matchId);
				generateSingleGame(userIdList, matchId);
			} else if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				generateDoubleGame(userIdList, matchId);
			}
		}
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
			user.setSEQ(null);
			user.update();
			retInfo.setRetCode(0);
			retInfo.setRetMsg("参赛人员删除成功！");
		}
		renderJson(retInfo);
	}
	
	public void addUser(){
		String id = getPara("id");
		MatchUser user = MatchUser.dao.findById(id);
		int maxSeq = MatchUser.dao.countMatchPersion(user.getMatchId());
		user.setSEQ(maxSeq+1);
		user.update();
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("添加成功");
		renderJson(retInfo);
	}
	
	public void setScore(){
		ResultInfo retInfo = new ResultInfo();
		int id = getParaToInt("id");
		String score = getPara("score");
		int result = MatchUser.dao.updateStartScore(id, score);
		if(result>0){
			retInfo.setRetCode(0);
			retInfo.setRetMsg("更新成功");
		}else{
			retInfo.setRetCode(1);
			retInfo.setRetMsg("更新失败");
		}
		renderJson(retInfo);
	}
	
	/**
	 * 生成单败制比赛
	 * @param userIdList
	 * @param seq
	 * @param userSum
	 * @param roundNum
	 * @param matchId
	 */
//	private void generateSingleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
//		if(userIdList != null){ //首轮有此参数
//			userSum = userIdList.size();
//		}
//		int gameSum = 1;
//		//根据参赛人员人数获得比赛场数
//		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
//		if(needGame > 0){
//			while(needGame > gameSum){
//				gameSum *= 2;
//			}
//			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
//					
//			//创建比赛
//			int userIndex = 0;
//			int winNextSeq = seq + gameSum + 1; //胜者下一场比赛序列
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				if(userIdList != null){ //首轮有此参数
//					game.setUSER1(userIdList.get(userIndex++));
//					if(i + byeUserSum < gameSum){ //不轮空才设置user2
//						game.setUSER2(userIdList.get(userIndex++));
//					}
//				}
//				game.setSEQ(++seq);
//				game.setShowIndex(seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextId(winNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
//				game.save();
////				System.out.println(game);
//			}
//			if(gameSum <= 1){ //最后一场比赛
//				return;
//			}
//			generateSingleGame(null, seq, gameSum, ++roundNum, matchId);
//		}else{
//			return;
//		}
//	}
	
	/**
	 * 生成单败制比赛
	 * @param userIdList
	 * @param seq
	 * @param userSum
	 * @param roundNum
	 * @param matchId
	 */
	private void generateSingleGame(List<Integer> userIdList, int matchId){
		int userSum = 0;
		if(userIdList != null){ //首轮有此参数
			userSum = userIdList.size();
		}
		int gameSum = 1;
		//根据参赛人员人数获得比赛场数
		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
		if(needGame > 0){
			while(needGame > gameSum){
				gameSum *= 2;
			}
			
			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
			int userIndex = 0;
			List<GameTemplate> list = MatchTemplateCache.getGameList(MatchTemplateCache.SINGLE_CACHE_NAME, gameSum * 2);
			for(int i = 0; i < list.size(); i++){
				Game game = new Game();
				GameTemplate tmp = list.get(i);
				if(tmp.getRoundNum() == 1){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(tmp.getSeq());
				game.setShowIndex(tmp.getShowIndex());
				game.setWNextId(tmp.getWinNextId());
				game.setLNextId(tmp.getLoseNextId());
				game.setRoundNum(tmp.getRoundNum());
				game.setMatchId(matchId);
				game.setSTATUS(0);
				game.save();
			}
		}
		
	}
	
	/**
	 * 生成双败制比赛
	 * @param userIdList
	 * @param seq
	 * @param userSum
	 * @param roundNum
	 * @param matchId
	 */
	private void generateDoubleGame(List<Integer> userIdList, int matchId){
		int userSum = 0;
		if(userIdList != null){ //首轮有此参数
			userSum = userIdList.size();
		}
		int gameSum = 1;
		//根据参赛人员人数获得比赛场数
		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
		if(needGame > 0){
			while(needGame > gameSum){
				gameSum *= 2;
			}
			
			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
			int userIndex = 0;
			List<GameTemplate> list = MatchTemplateCache.getGameList(MatchTemplateCache.DOUBLE_CACHE_NAME, gameSum * 2);
			for(int i = 0; i < list.size(); i++){
				Game game = new Game();
				GameTemplate tmp = list.get(i);
				if(tmp.getRoundNum() == 1 && StringUtils.isNotBlank(tmp.getLoseNextId())){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(tmp.getSeq());
				game.setShowIndex(tmp.getShowIndex());
				game.setWNextId(tmp.getWinNextId());
				game.setLNextId(tmp.getLoseNextId());
				game.setRoundNum(tmp.getRoundNum());
				game.setMatchId(matchId);
				game.setSTATUS(0);
				game.save();
			}
		}
		
	}
//	private void generateDoubleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
//		if(userIdList != null){ //首轮有此参数
//			userSum = userIdList.size();
//		}
//		int gameSum = 1;
//		//根据参赛人员人数获得比赛场数
//		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
//		if(needGame > 0){
//			while(needGame > gameSum){
//				gameSum *= 2;
//			}
//			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
//					
//			//创建比赛
//			int userIndex = 0;
//			int winNextSeq = seq + gameSum + gameSum/2 + 1; //胜者下一场比赛序列
//			int loseNextSeq = seq + gameSum + 1; //败者下一场比赛序列
//			
//			//胜者组
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				if(userIdList != null){ //首轮有此参数
//					game.setUSER1(userIdList.get(userIndex++));
//					if(i + byeUserSum < gameSum){ //不轮空才设置user2
//						game.setUSER2(userIdList.get(userIndex++));
//					}
//				}
//				game.setSEQ(++seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextSeq(winNextSeq);
//					game.setLNextSeq(loseNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//					loseNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
////				game.save();
//				System.out.println(game);
//			}
//			
//			//败者组
//			if(roundNum == 1){
//				gameSum = gameSum/2;
//			}
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				game.setSEQ(++seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextSeq(winNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//					loseNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
////				game.save();
//				System.out.println(game);
//			}
//			
//			if(gameSum <= 1){ //最后一场比赛
//				return;
//			}
//			generateDoubleGame(null, seq, gameSum, ++roundNum, matchId);
//		}else{
//			return;
//		}
//	}
	
}
