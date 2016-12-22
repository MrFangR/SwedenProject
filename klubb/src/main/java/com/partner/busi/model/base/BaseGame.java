package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseGame<M extends BaseGame<M>> extends Model<M> implements IBean {

	public void setID(java.lang.Integer ID) {
		set("ID", ID);
	}

	public java.lang.Integer getID() {
		return get("ID");
	}

	public void setSEQ(java.lang.Integer SEQ) {
		set("SEQ", SEQ);
	}

	public java.lang.Integer getSEQ() {
		return get("SEQ");
	}

	public void setTableNum(java.lang.String tableNum) {
		set("TABLE_NUM", tableNum);
	}

	public java.lang.String getTableNum() {
		return get("TABLE_NUM");
	}

	public void setStartTime(java.util.Date startTime) {
		set("START_TIME", startTime);
	}

	public java.util.Date getStartTime() {
		return get("START_TIME");
	}

	public void setUSER1(java.lang.Integer USER1) {
		set("USER1", USER1);
	}

	public java.lang.Integer getUSER1() {
		return get("USER1");
	}

	public void setUSER2(java.lang.Integer USER2) {
		set("USER2", USER2);
	}

	public java.lang.Integer getUSER2() {
		return get("USER2");
	}

	public void setSCORE1(java.lang.Integer SCORE1) {
		set("SCORE1", SCORE1);
	}

	public java.lang.Integer getSCORE1() {
		return get("SCORE1");
	}

	public void setSCORE2(java.lang.Integer SCORE2) {
		set("SCORE2", SCORE2);
	}

	public java.lang.Integer getSCORE2() {
		return get("SCORE2");
	}

	public void setWinnerId(java.lang.Integer winnerId) {
		set("WINNER_ID", winnerId);
	}

	public java.lang.Integer getWinnerId() {
		return get("WINNER_ID");
	}

	public void setWNextSeq(java.lang.Integer wNextSeq) {
		set("W_NEXT_SEQ", wNextSeq);
	}

	public java.lang.Integer getWNextSeq() {
		return get("W_NEXT_SEQ");
	}

	public void setLNextSeq(java.lang.Integer lNextSeq) {
		set("L_NEXT_SEQ", lNextSeq);
	}

	public java.lang.Integer getLNextSeq() {
		return get("L_NEXT_SEQ");
	}

	public void setTYPE(java.lang.Integer TYPE) {
		set("TYPE", TYPE);
	}

	public java.lang.Integer getTYPE() {
		return get("TYPE");
	}

	public void setRoundNum(java.lang.Integer roundNum) {
		set("ROUND_NUM", roundNum);
	}

	public java.lang.Integer getRoundNum() {
		return get("ROUND_NUM");
	}

	public void setMatchId(java.lang.Integer matchId) {
		set("MATCH_ID", matchId);
	}

	public java.lang.Integer getMatchId() {
		return get("MATCH_ID");
	}

	public void setSTATUS(java.lang.Integer STATUS) {
		set("STATUS", STATUS);
	}

	public java.lang.Integer getSTATUS() {
		return get("STATUS");
	}

}
