package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseUser<M extends BaseUser<M>> extends Model<M> implements IBean {

	public void setID(java.lang.Integer ID) {
		set("ID", ID);
	}

	public java.lang.Integer getID() {
		return get("ID");
	}

	public void setEMAIL(java.lang.String EMAIL) {
		set("EMAIL", EMAIL);
	}

	public java.lang.String getEMAIL() {
		return get("EMAIL");
	}

	public void setPASSWORD(java.lang.String PASSWORD) {
		set("PASSWORD", PASSWORD);
	}

	public java.lang.String getPASSWORD() {
		return get("PASSWORD");
	}

	public void setIdNumber(java.lang.String idNumber) {
		set("ID_NUMBER", idNumber);
	}

	public java.lang.String getIdNumber() {
		return get("ID_NUMBER");
	}

	public void setNAME(java.lang.String NAME) {
		set("NAME", NAME);
	}

	public java.lang.String getNAME() {
		return get("NAME");
	}

	public void setNICKNAME(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNICKNAME() {
		return get("NICKNAME");
	}

	public void setGENDER(java.lang.Integer GENDER) {
		set("GENDER", GENDER);
	}

	public java.lang.Integer getGENDER() {
		return get("GENDER");
	}

	public void setPHONE(java.lang.String PHONE) {
		set("PHONE", PHONE);
	}

	public java.lang.String getPHONE() {
		return get("PHONE");
	}

	public void setLastStartScore(java.lang.String lastStartScore) {
		set("LAST_START_SCORE", lastStartScore);
	}

	public java.lang.String getLastStartScore() {
		return get("LAST_START_SCORE");
	}

	public void setSTATUS(java.lang.Integer STATUS) {
		set("STATUS", STATUS);
	}

	public java.lang.Integer getSTATUS() {
		return get("STATUS");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("CREATE_TIME", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("CREATE_TIME");
	}

}
