package com.partner.busi.vo;

public class MatchRinkListVo {

	private String userName;//参赛者名称
	
	private int seq;//序列
	
	private String[] matchFlag;//比赛历史记录 

	public MatchRinkListVo(String userName, int seq, String[] matchFlag) {
		super();
		this.userName = userName;
		this.seq = seq;
		this.matchFlag = matchFlag;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String[] getMatchFlag() {
		return matchFlag;
	}

	public void setMatchFlag(String[] matchFlag) {
		this.matchFlag = matchFlag;
	}
	
}
