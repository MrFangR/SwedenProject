package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseActivity<M extends BaseActivity<M>> extends Model<M> implements IBean {

	public void setID(java.lang.Integer ID) {
		set("ID", ID);
	}

	public java.lang.Integer getID() {
		return get("ID");
	}

	public void setTITLE(java.lang.String TITLE) {
		set("TITLE", TITLE);
	}

	public java.lang.String getTITLE() {
		return get("TITLE");
	}

	public void setIMG(java.lang.String IMG) {
		set("IMG", IMG);
	}

	public java.lang.String getIMG() {
		return get("IMG");
	}

	public void setABSTRACT(java.lang.String ABSTRACT) {
		set("ABSTRACT", ABSTRACT);
	}

	public java.lang.String getABSTRACT() {
		return get("ABSTRACT");
	}

	public void setCONTENT(java.lang.String CONTENT) {
		set("CONTENT", CONTENT);
	}

	public java.lang.String getCONTENT() {
		return get("CONTENT");
	}

	public void setActTime(java.util.Date actTime) {
		set("ACT_TIME", actTime);
	}

	public java.util.Date getActTime() {
		return get("ACT_TIME");
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

	public void setCreateUserId(java.lang.Integer createUserId) {
		set("CREATE_USER_ID", createUserId);
	}

	public java.lang.Integer getCreateUserId() {
		return get("CREATE_USER_ID");
	}

	public void setUpdateTime(java.util.Date updateTime) {
		set("UPDATE_TIME", updateTime);
	}

	public java.util.Date getUpdateTime() {
		return get("UPDATE_TIME");
	}

	public void setUpdateUserId(java.lang.Integer updateUserId) {
		set("UPDATE_USER_ID", updateUserId);
	}

	public java.lang.Integer getUpdateUserId() {
		return get("UPDATE_USER_ID");
	}

}
