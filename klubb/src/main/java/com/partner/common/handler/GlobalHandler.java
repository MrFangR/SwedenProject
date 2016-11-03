package com.partner.common.handler;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.jfinal.handler.Handler;
import com.partner.common.constant.ConstantInit;
import com.partner.common.plugin.PropertiesPlugin;

/**
 * 全局Handler，设置一些通用功能
 * 描述：主要是一些全局变量的设置，再就是日志记录开始和结束操作
 */
public class GlobalHandler extends Handler {

	@Override
	public void handle(String target, HttpServletRequest req, HttpServletResponse response, boolean[] isHandled) {
		//拦截请示
		if(!req.getMethod().equalsIgnoreCase("GET")&&!req.getMethod().equalsIgnoreCase("POST")){
			return;
		}
		//防止跨站点请求伪造
		String referer = req.getHeader("Referer");
		if (StringUtils.isNotBlank(referer)) {
			referer = referer.toLowerCase();
			String domainStr = (String) PropertiesPlugin.getParamMapValue(ConstantInit.config_domain_key);
			String[] domainArr = domainStr.split(",");
			boolean flag=false;
			for (String domain : domainArr) {
				if (referer.indexOf(domain.trim()) != -1) {
					flag=true;
					break;
				}
			}
			if(!flag){
				return;
			}
		}
		
		// XSS攻击，sql攻击过滤
		XssHttpServletRequestWrapper request = new XssHttpServletRequestWrapper(req);
		
		//会话 cookie 中缺少 HttpOnly SECURE属性
		Cookie[] cookies = req.getCookies(); 
		if (cookies != null&&cookies.length>0) {
            Cookie cookie = cookies[0];
            if (cookie != null) {
                //Servlet 2.5不支持在Cookie上直接设置HttpOnly属性  
                String value = cookie.getValue();
                cookie.setHttpOnly(true);
                cookie.setSecure(true);
                //response.setHeader("Set-Cookie","Secure;HttpOnly;");
            }
		}
		response.setHeader("Allow", "GET,POST");
	}
	
	/**
	 * 创建日志对象,并初始化一些属性值
	 * @param request
	 * @return
	 */
	/*public SysLogInfo getSysLog(HttpServletRequest request){
		String requestPath = ToolWeb.getRequestURIWithParam(request); 
		String ip = ToolWeb.getIpAddr(request);
		String referer = request.getHeader("Referer"); 
		String userAgent = request.getHeader("User-Agent");
		String cookie = request.getHeader("Cookie");
		String method = request.getMethod();
		String xRequestedWith = request.getHeader("X-Requested-With");
		String host = request.getHeader("Host");
		String acceptLanguage = request.getHeader("Accept-Language");
		String acceptEncoding = request.getHeader("Accept-Encoding");
		String accept = request.getHeader("Accept");
		String connection = request.getHeader("Connection");

		SysLogInfo reqSysLog = new SysLogInfo();
		
		reqSysLog.set(SysLogInfo.column_ips, ip);
		reqSysLog.set(SysLogInfo.column_requestpath, requestPath);
		reqSysLog.set(SysLogInfo.column_referer, referer);
		reqSysLog.set(SysLogInfo.column_useragent, userAgent);
		reqSysLog.set(SysLogInfo.column_cookie, cookie);
		reqSysLog.set(SysLogInfo.column_method, method);
		reqSysLog.set(SysLogInfo.column_xrequestedwith, xRequestedWith);
		reqSysLog.set(SysLogInfo.column_host, host);
		reqSysLog.set(SysLogInfo.column_acceptlanguage, acceptLanguage);
		reqSysLog.set(SysLogInfo.column_acceptencoding, acceptEncoding);
		reqSysLog.set(SysLogInfo.column_accept, accept);
		reqSysLog.set(SysLogInfo.column_connection, connection);

		return reqSysLog;
	}*/
	
}
