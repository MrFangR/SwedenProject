package com.partner.busi.model;
/**
 * 用来记录比赛排行榜用户次序
 * @author fangrui
 *
 */
public class MatchUserSort implements Comparable<MatchUserSort> {
	
	private Integer userId;
	
	private Integer score;
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public int compareTo(MatchUserSort o) {
		// TODO Auto-generated method stub
		return o.getScore() - this.getScore();
	}

}
