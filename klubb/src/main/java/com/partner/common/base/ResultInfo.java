/**
 * 
 */
package com.partner.common.base;

/**
 * @author issuser
 * desc   用于记录返回信息
 */
public class ResultInfo {

	private String retCode;// 0 成功   1 失败
	
	private String retMsg;// 描述信息
	
	private Object bean;//返回实体bean;

	public String getRetCode() {
		return retCode;
	}

	public void setRetCode(String retCode) {
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
