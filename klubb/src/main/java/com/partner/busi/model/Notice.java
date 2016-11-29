package com.partner.busi.model;

import java.util.List;

import com.partner.busi.model.base.BaseNotice;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Notice extends BaseNotice<Notice> {
	public static final Notice dao = new Notice();
	
	public Notice findNotice(){
		return dao.findFirst("select * from t_notice where STATUS = 0 and ID = 1 ");
	}
}
