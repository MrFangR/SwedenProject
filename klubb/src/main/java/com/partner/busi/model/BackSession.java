package com.partner.busi.model;

import java.io.Serializable;

/**
 * 后台管理系统 session 对象
 * @author YangKai
 */
public class BackSession implements Serializable{
	private static final long serialVersionUID = 8938358669506053781L;

	/**
	 * 登录用户对象
	 */
	private CUser user;

	public CUser getUser() {
		return user;
	}

	public void setUser(CUser user) {
		this.user = user;
	}
	

}
