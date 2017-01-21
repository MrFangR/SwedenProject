package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseMatch<M extends BaseMatch<M>> extends Model<M> implements IBean {

	public void setID(java.lang.Integer ID) {
		set("ID", ID);
	}

	public java.lang.Integer getID() {
		return get("ID");
	}

	public void setNAME(java.lang.String NAME) {
		set("NAME", NAME);
	}

	public java.lang.String getNAME() {
		return get("NAME");
	}

	public void setIMG(java.lang.String IMG) {
		set("IMG", IMG);
	}

	public java.lang.String getIMG() {
		return get("IMG");
	}

	public void setTYPE(java.lang.Integer TYPE) {
		set("TYPE", TYPE);
	}

	public java.lang.Integer getTYPE() {
		return get("TYPE");
	}

	public void setTHIRD(java.lang.Integer THIRD) {
		set("THIRD", THIRD);
	}

	public java.lang.Integer getTHIRD() {
		return get("THIRD");
	}

	public void setStartDate(java.util.Date startDate) {
		set("START_DATE", startDate);
	}

	public java.util.Date getStartDate() {
		return get("START_DATE");
	}

	public void setDESCRIPTION(java.lang.String DESCRIPTION) {
		set("DESCRIPTION", DESCRIPTION);
	}

	public java.lang.String getDESCRIPTION() {
		return get("DESCRIPTION");
	}

	public void setMaxPlayer(java.lang.Integer maxPlayer) {
		set("MAX_PLAYER", maxPlayer);
	}

	public java.lang.Integer getMaxPlayer() {
		return get("MAX_PLAYER");
	}

	public void setStopPlayer(java.lang.Integer stopPlayer) {
		set("STOP_PLAYER", stopPlayer);
	}

	public java.lang.Integer getStopPlayer() {
		return get("STOP_PLAYER");
	}

	public void setPId(java.lang.Integer pId) {
		set("P_ID", pId);
	}

	public java.lang.Integer getPId() {
		return get("P_ID");
	}

	public void setSTATUS(java.lang.Integer STATUS) {
		set("STATUS", STATUS);
	}

	public java.lang.Integer getSTATUS() {
		return get("STATUS");
	}

}
