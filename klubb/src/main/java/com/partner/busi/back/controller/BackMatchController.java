/**
 * 
 */
package com.partner.busi.back.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.jfinal.core.Controller;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchUser;

/** 
 * @ClassName: BackMatchController 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月25日 上午12:39:40  
 */
public class BackMatchController extends Controller {
	
	public void index(){
		Integer matchId = getParaToInt("matchId");
		List<Game> list = Game.dao.find("SELECT g.*, IFNULL(mu1.SEQ, 0) AS U1_SEQ, IFNULL(mu2.SEQ, 0) AS U2_SEQ,"
				+ " IFNULL(u1.`NAME`,'') as U1_NAME, IFNULL(u2.`NAME`,'') as U2_NAME"
				+ " FROM t_game g"
				+ " LEFT JOIN t_match_user AS mu1 ON g.USER1 = mu1.USER_ID"
				+ " LEFT JOIN t_match_user AS mu2 ON g.USER2 = mu2.USER_ID"
				+ " LEFT JOIN t_user AS u1 ON g.USER1 = u1.ID"
				+ " LEFT JOIN t_user AS u2 ON g.USER2 = u2.ID"
				+ " WHERE g.MATCH_ID = ?"
				+ " ORDER BY g.SHOW_INDEX", matchId);
		
		List<List<Game>> rsList = new ArrayList<List<Game>>();

		List<Integer> roundList = new ArrayList<Integer>();
		for(Game game : list){
			if(!roundList.contains(game.getRoundNum())){
				roundList.add(game.getRoundNum());
				rsList.add(new ArrayList<Game>());
			}
		}
		List<String> titleList = new ArrayList<String>();
		for(int i = 0; i < roundList.size(); i++){
			if(i == roundList.size() - 1){
				titleList.add("决赛");
			}else if(i == roundList.size() - 2){
				titleList.add("半决赛");
			}else{
				titleList.add("第" + roundList.get(i) + "轮");
			}
		}
		
		for(Game game : list){
			rsList.get(game.getRoundNum() - 1).add(game);
		}
		
		setAttr("list", rsList);
		setAttr("titleList", titleList);
		render("match_edit.jsp");
	}
	
	public void generateGame(){
		Integer matchId = getParaToInt("matchId");
		Match match = Match.dao.findById(matchId);
		if(match != null && match.getSTATUS() == 0){ //比赛未开始，根据当前用户信息重新生成比赛
			if(match.getTYPE() == 1 || match.getTYPE() == 3){ //单败
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
				generateSingleGame(userIdList, 0, 0, 1, matchId);
			} else if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				
			}
		}
	}
	
	/**
	 * 生成单败制比赛
	 * @param userIdList
	 * @param seq
	 * @param userSum
	 * @param roundNum
	 * @param matchId
	 */
	private void generateSingleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
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
					
			//创建比赛
			int userIndex = 0;
			int winNextSeq = seq + gameSum + 1; //胜者下一场比赛序列
			for(int i = 0; i < gameSum; i++){
				Game game = new Game();
				if(userIdList != null){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(++seq);
				game.setShowIndex(seq);
				if(gameSum > 1){ //不是最后一场比赛
					game.setWNextSeq(winNextSeq);
				}
				if(seq % 2 == 0){
					winNextSeq++;
				}
				game.setRoundNum(roundNum);
				game.setMatchId(matchId);
				game.setSTATUS(0);
				game.save();
//				System.out.println(game);
			}
			if(gameSum <= 1){ //最后一场比赛
				return;
			}
			generateSingleGame(null, seq, gameSum, ++roundNum, matchId);
		}else{
			return;
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
	private void generateDoubleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
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
					
			//创建比赛
			int userIndex = 0;
			int winNextSeq = seq + gameSum + gameSum/2 + 1; //胜者下一场比赛序列
			int loseNextSeq = seq + gameSum + 1; //败者下一场比赛序列
			
			//胜者组
			for(int i = 0; i < gameSum; i++){
				Game game = new Game();
				if(userIdList != null){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(++seq);
				if(gameSum > 1){ //不是最后一场比赛
					game.setWNextSeq(winNextSeq);
					game.setLNextSeq(loseNextSeq);
				}
				if(seq % 2 == 0){
					winNextSeq++;
					loseNextSeq++;
				}
				game.setRoundNum(roundNum);
				game.setMatchId(matchId);
				game.setSTATUS(0);
//				game.save();
				System.out.println(game);
			}
			
			//败者组
			if(roundNum == 1){
				gameSum = gameSum/2;
			}
			for(int i = 0; i < gameSum; i++){
				Game game = new Game();
				game.setSEQ(++seq);
				if(gameSum > 1){ //不是最后一场比赛
					game.setWNextSeq(winNextSeq);
				}
				if(seq % 2 == 0){
					winNextSeq++;
					loseNextSeq++;
				}
				game.setRoundNum(roundNum);
				game.setMatchId(matchId);
				game.setSTATUS(0);
//				game.save();
				System.out.println(game);
			}
			
			if(gameSum <= 1){ //最后一场比赛
				return;
			}
			generateDoubleGame(null, seq, gameSum, ++roundNum, matchId);
		}else{
			return;
		}
	}
	
}
