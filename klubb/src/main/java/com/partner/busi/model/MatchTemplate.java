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
		private Integer winNextSeq; //胜者下一场比赛序列
		private Integer loseNextSeq; //败者下一场比赛序列
		private Integer roundNum; //第几轮
		private Integer showIndex; //展示顺序
		public Integer getSeq() {
			return seq;
		}
		public void setSeq(Integer seq) {
			this.seq = seq;
		}
		public Integer getWinNextSeq() {
			return winNextSeq;
		}
		public void setWinNextSeq(Integer winNextSeq) {
			this.winNextSeq = winNextSeq;
		}
		public Integer getLoseNextSeq() {
			return loseNextSeq;
		}
		public void setLoseNextSeq(Integer loseNextSeq) {
			this.loseNextSeq = loseNextSeq;
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
	}
	public List<GameTemplate> getGameList() {
		return gameList;
	}
	public void setGameList(List<GameTemplate> gameList) {
		this.gameList = gameList;
	}
}
