package com.partner.busi.back.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.partner.busi.model.CUser;
import com.partner.common.constant.Constants;

/**
 * 后台管理系统 Session Tools
 * @author YangKai
 */
public class BackSessionUtil {
	private static final Logger log = Logger.getLogger(BackSessionUtil.class);
	
	/**
	 * 设置 BackSession
	 * @param request
	 * @param sessionBean
	 * @return void
	 */
	public static boolean setSession(HttpServletRequest request, CUser user){
		// 如果传入的 CUser为空，则作为异常处理，直接返回
		if (user==null || StringUtils.isBlank(user.getStr("USER_NAME"))) {
			log.info("初始化后台管理系统所用用户对象为空，初始化失败，直接返回");
			return false;
		}
		
		// 设置session值
		request.getSession().setAttribute(Constants.BACK_SESSION_USER, user);
		log.info("初始化后台管理用户session 完成[userName="+user.getStr("USER_NAME")+"]");
		return true;
	}
	
	/**
	 * 获取 BackSession
	 * @return CUser
	 */
	public static CUser getUser(HttpServletRequest request){
		return (CUser)request.getSession().getAttribute(Constants.BACK_SESSION_USER);
	}

	/**
	 * 清除 BackSession
	 */
	public static void clearSession(HttpServletRequest request){
		request.getSession().invalidate();
	}
	
	/**
	 * 判断是否登录状态
	 * @param request
	 * @return boolean
	 */
	public static boolean isLoginBack(HttpServletRequest request){
		CUser user = getUser(request);
		return user!=null && StringUtils.isNotBlank(user.getStr("USER_NAME"));
	}
	
	/**
	 * 获取登录用户.USER_NAME
	 * @param request
	 * @return userNo/""
	 */
	public static String getUserName(HttpServletRequest request){
		CUser user = getUser(request);
		if (user != null) {
			return user.getStr("USER_NAME");
		} else {
			return null;
		}
	}
	
	/**
	 * 获取登录用户.USER_ID
	 * @param request
	 * @return userNo/""
	 */
	public static String getUserId(HttpServletRequest request){
		CUser user = getUser(request);
		if (user != null) {
			return user.getStr("ID");
		} else {
			return null;
		}
	}
	
}
