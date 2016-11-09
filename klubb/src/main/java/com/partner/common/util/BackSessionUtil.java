package com.partner.common.util;

import java.util.ArrayList;
import java.util.List;

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
		// 如果传入的 backUser为空，则作为异常处理，直接返回
		if (user==null || StringUtils.isBlank(user.getStr("USER_NAME"))) {
			log.info("初始化后台管理系统所用用户对象为空，初始化失败，直接返回");
			return false;
		}
		// 设置session值
		request.getSession().setAttribute(Constants.BACK_SESSION_USER, user);
		log.info("初始化后台管理用户session 完成[userNo="+user.getUserName()+"]");
		return true;
	}
	
	/**
	 * 获取 BackSession
	 * @return BackUser
	 */
	public static CUser getSession(HttpServletRequest request){
		CUser user = (CUser)request.getSession().getAttribute(Constants.BACK_SESSION_USER);
		if(user == null){
			user = new CUser();
			user = CUser.dao.findByName(request.getParameter("loginName"));
			request.getSession().setAttribute(Constants.BACK_SESSION_USER, user);
		}
		return user;
	}

	/**
	 * 清除 BackSession
	 */
	public static void clearSession(HttpServletRequest request){
		request.getSession().removeAttribute(Constants.BACK_SESSION_USER);
	}
	
	/**
	 * 判断是否登录状态
	 * @param request
	 * @return boolean
	 */
	public static boolean isLoginBack(HttpServletRequest request){
		CUser user = getSession(request);
		// 判断session不为空，且session中存放的 用户对象不为空，且其USER_NO属性也不为空
		if (user!=null
				&& StringUtils.isNotBlank(user.getUserName())) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 获取登录用户.USER_NO
	 * @param request
	 * @return userNo/""
	 */
	public static String getUserName(HttpServletRequest request){
		CUser user = getSession(request);
		if (user!=null && StringUtils.isNotBlank(user.getUserName())) {
			return user.getUserName();
		} else {
			return "";
		}
	}
	
}
