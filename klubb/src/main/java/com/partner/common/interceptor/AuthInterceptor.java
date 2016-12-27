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
import com.partner.busi.model.CUser;
import com.partner.busi.model.SysAccessLog;
import com.partner.busi.model.User;
import com.partner.common.util.BackSessionUtil;
import com.partner.common.util.FrontSessionUtil;

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
		String reqUrl = invoc.getActionKey(); 
		if(reqUrl.contains("/back/") && !reqUrl.contains("login")){//代表请求为后台请求
			CUser backUser = BackSessionUtil.getUser(request);
			if(backUser==null){//说明此用户没有登录
				contro.setAttr("toUrl", reqUrl);
				boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
				if(isAjax){
					contro.renderJson("{\"flag\":\"1\",\"msg\":\"用户登录信息失效，请重新登录。\"}");
				}else{
					contro.redirect("/back");
				}
			}
		}else{//代表为前台访问，记录请求数据表
			SysAccessLog sysLog = new SysAccessLog();
			User frontUser = FrontSessionUtil.getSession(request);
			if(frontUser != null){
				sysLog.setUserId(frontUser.getID());
			}
			sysLog.setIP(request.getRemoteHost());
			sysLog.setURL(invoc.getActionKey());
			sysLog.setCreateTime(new Date());
			sysLog.save();
			invoc.invoke();
		}
		/*else if(reqUrl.contains("/front")){//其他的默认为前台请求
			User frontUser = FrontSessionUtil.getSession(request);
			if(frontUser==null){
				boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
				if(isAjax){
					contro.renderJson("{\"retCode\":\"1\",\"retMsg\":\"用户登录信息失效，请 重新登录。\"}");
				}else{
					contro.forwardAction(request.getContextPath()+"/front/toLogin");
				}
			}
		}*/
		
	}

}
