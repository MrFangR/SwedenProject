/**
 * 
 */
package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

/** 
 * @ClassName: GameTemplate 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月27日 下午10:22:25  
 */
public class MatchTemplate {
	private List<GameTemplate> gameList = new ArrayList<GameTemplate>();
	public static class GameTemplate{
		private Integer seq; //序列
		private String winNextId; //胜者下一场比赛序列
		private String loseNextId; //败者下一场比赛序列
		private Integer roundNum; //第几轮
		private Integer showIndex; //展示顺序
		public Integer getSeq() {
			return seq;
		}
		public void setSeq(Integer seq) {
			this.seq = seq;
		}
		
		public Integer getRoundNum() {
			return roundNum;
		}
		public void setRoundNum(Integer roundNum) {
			this.roundNum = roundNum;
		}
		public Integer getShowIndex() {
			return showIndex;
		}
		public void setShowIndex(Integer showIndex) {
			this.showIndex = showIndex;
		}
		public String getWinNextId() {
			return winNextId;
		}
		public void setWinNextId(String winNextId) {
			this.winNextId = winNextId;
		}
		public String getLoseNextId() {
			return loseNextId;
		}
		public void setLoseNextId(String loseNextId) {
			this.loseNextId = loseNextId;
		}
	}
	public List<GameTemplate> getGameList() {
		return gameList;
	}
	public void setGameList(List<GameTemplate> gameList) {
		this.gameList = gameList;
	}
}
