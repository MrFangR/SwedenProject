package com.partner.busi.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseSysAccessLog<M extends BaseSysAccessLog<M>> extends Model<M> implements IBean {

	public void setID(java.lang.Integer ID) {
		set("ID", ID);
	}

	public java.lang.Integer getID() {
		return get("ID");
	}

	public void setUserId(java.lang.Integer userId) {
		set("USER_ID", userId);
	}

	public java.lang.Integer getUserId() {
		return get("USER_ID");
	}

	public void setIP(java.lang.String IP) {
		set("IP", IP);
	}

	public java.lang.String getIP() {
		return get("IP");
	}

	public void setURL(java.lang.String URL) {
		set("URL", URL);
	}

	public java.lang.String getURL() {
		return get("URL");
	}

	public void setFuncCode(java.lang.String funcCode) {
		set("FUNC_CODE", funcCode);
	}

	public java.lang.String getFuncCode() {
		return get("FUNC_CODE");
	}

	public void setDESCRIPTION(java.lang.String DESCRIPTION) {
		set("DESCRIPTION", DESCRIPTION);
	}

	public java.lang.String getDESCRIPTION() {
		return get("DESCRIPTION");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("CREATE_TIME", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("CREATE_TIME");
	}

}
