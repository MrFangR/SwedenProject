/**
 * 
 */
package com.partner.common.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.partner.busi.model.SysAccessLog;

/**
 * @author fangrui
 *
 */
public class AuthInterceptor implements Interceptor {
	private static Log log = Log.getLog(AuthInterceptor.class);

	public void intercept(Invocation invoc) {
		// TODO Auto-generated method stub
		Controller contro = invoc.getController();
		HttpServletRequest request = contro.getRequest();
		HttpServletResponse response = contro.getResponse();
		
		SysAccessLog sysLog = new SysAccessLog();
		
		sysLog.setIP(request.getRemoteHost());
		sysLog.setURL(request.getPathInfo());
		sysLog.setCreateTime(new Date());
		sysLog.save();
		
		invoc.invoke();
	}

}
