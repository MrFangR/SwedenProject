/**
 * 
 */
package com.partner.common.base;

/**
 * @author fangrui desc 用于记录返回信息
 */
public class ResultInfo {

	private int retCode;// 0 成功 1 失败

	private String retMsg;// 描述信息

	private Object bean;// 返回实体bean;

	public ResultInfo() {

	}
	
	public ResultInfo(int retCode,String retMsg){
		this.retCode=retCode;
		this.retMsg=retMsg;
	}

	public int getRetCode() {
		return retCode;
	}

	public void setRetCode(int retCode) {
		this.retCode = retCode;
	}

	public String getRetMsg() {
		return retMsg;
	}

	public void setRetMsg(String retMsg) {
		this.retMsg = retMsg;
	}

	public Object getBean() {
		return bean;
	}

	public void setBean(Object bean) {
		this.bean = bean;
	}

}
