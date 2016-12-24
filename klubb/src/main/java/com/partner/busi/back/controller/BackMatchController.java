/**
 * 
 */
package com.partner.busi.back.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.core.Controller;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;

/** 
 * @ClassName: BackMatchController 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月25日 上午12:39:40  
 */
public class BackMatchController extends Controller {
	
	public void loadGame(){
		Integer matchId = getParaToInt("matchId");
		Match match = Match.dao.findById(matchId);
		if(match != null && match.getSTATUS() == 0){ //比赛未开始，根据当前用户信息重新生成比赛
			if(match.getTYPE() == 1 || match.getTYPE() == 3){ //单败
				//1.删除本赛事下所有比赛
				
				//2.根据当前人员生成比赛
				//2.1获取当前参赛人员，orderby seq
				List<Integer> userIdList = null;
				//2.2生成比赛
				generateSingleGame(userIdList, 0, 0, 1, matchId);
			} else if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				
			}
			
		}
		//查找比赛
		

	}
	
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
				if(gameSum > 1){ //不是最后一场比赛
					game.setWNextSeq(winNextSeq);
				}
				if(seq % 2 == 0){
					winNextSeq++;
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
			generateSingleGame(null, seq, gameSum, ++roundNum, matchId);
		}else{
			return;
		}
	}
	
}
