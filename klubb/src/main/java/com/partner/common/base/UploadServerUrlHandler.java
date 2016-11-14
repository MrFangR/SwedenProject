/**
 * 
 */
package com.partner.common.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.handler.Handler;
import com.jfinal.kit.StrKit;
import com.partner.common.constant.Constants;

/** 
 * @ClassName: UploadServerUrlHandler 
 * @Description: 
 * @author zhanglei
 * @date 2016年1月19日 上午10:58:44  
 */
public class UploadServerUrlHandler extends Handler {
	
	private String uploadServerUrl;
	
	public UploadServerUrlHandler() {
		uploadServerUrl = "UPLOAD_SERVER_URL";
	}
	
	public UploadServerUrlHandler(String uploadServerUrl) {
		if (StrKit.isBlank(uploadServerUrl))
			throw new IllegalArgumentException("uploadServerUrl can not be blank.");
		this.uploadServerUrl = uploadServerUrl;
	}
	
	public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
		request.setAttribute(uploadServerUrl, Constants.UPLOAD_SERVER_URL);
		next.handle(target, request, response, isHandled);
	}
}
