package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseContact<M extends BaseContact<M>> extends Model<M> implements IBean {

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

	public void setPHONE(java.lang.String PHONE) {
		set("PHONE", PHONE);
	}

	public java.lang.String getPHONE() {
		return get("PHONE");
	}

	public void setCONTENT(java.lang.String CONTENT) {
		set("CONTENT", CONTENT);
	}

	public java.lang.String getCONTENT() {
		return get("CONTENT");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("CREATE_TIME", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("CREATE_TIME");
	}

	public void setSTATUS(java.lang.Integer STATUS) {
		set("STATUS", STATUS);
	}

	public java.lang.Integer getSTATUS() {
		return get("STATUS");
	}

}
