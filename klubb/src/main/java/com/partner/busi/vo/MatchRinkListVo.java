package com.partner.busi.vo;

import java.util.List;

public class MatchRinkListVo {

	private String userName;//参赛者名称
	
	private int seq;//序列
	
	//private String[] matchFlag;//比赛历史记录 
	private List matchFlag;

	public MatchRinkListVo(String userName, int seq, List matchFlag) {
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

	public List getMatchFlag() {
		return matchFlag;
	}

	public void setMatchFlag(List matchFlag) {
		this.matchFlag = matchFlag;
	}
	
}
