package com.partner.common.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import com.partner.busi.model.User;
import com.partner.common.constant.Constants;

/**
 * 前台管理系统 Session Tools
 * @author YangKai
 */
public class FrontSessionUtil {
	private static final Logger log = Logger.getLogger(FrontSessionUtil.class);
	
	/**
	 * 设置 BackSession
	 * @param request
	 * @param sessionBean
	 * @return void
	 */
	public static boolean setSession(HttpServletRequest request, User user){
		// 如果传入的 backUser为空，则作为异常处理，直接返回
		if (user==null || StringUtils.isBlank(user.getEMAIL())) {
			log.info("初始化会员管理系统所用用户对象为空，初始化失败，直接返回");
			return false;
		}
		String email = user.getEMAIL();
		
		log.info("初始化会员管理用户信息 完成[email="+email+"]");
		
		// 设置session值
		request.getSession().setAttribute(Constants.FRONT_SESSION_USER, user);
		log.info("初始化会员管理用户session 完成[email="+email+"]");
		return true;
	}
	
	/**
	 * 获取 BackSession
	 * @return BackUser
	 */
	public static User getSession(HttpServletRequest request){
		User frontSess = (User)request.getSession().getAttribute(Constants.FRONT_SESSION_USER);
		/*if(frontSess == null){
			frontSess = new User();
			request.getSession().setAttribute(Constants.FRONT_SESSION_USER, frontSess);
		}*/
		return frontSess;
	}

	/**
	 * 清除 BackSession
	 */
	public static void clearSession(HttpServletRequest request){
		request.getSession().removeAttribute(Constants.FRONT_SESSION_USER);
	}
	
	/**
	 * 判断是否登录状态
	 * @param request
	 * @return boolean
	 */
	public static boolean isLogin(HttpServletRequest request){
		User frontSess = getSession(request);
		// 判断session不为空，且session中存放的 用户对象不为空，且其USER_NO属性也不为空
		if (frontSess!=null
				&& StringUtils.isNotBlank(frontSess.getEMAIL())) {
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
	public static String getUserNo(HttpServletRequest request){
		User frontUser = getSession(request);
		if (frontUser!=null && StringUtils.isNotBlank(frontUser.getEMAIL())) {
			return frontUser.getEMAIL();
		} else {
			return "";
		}
	}
	
	
	/**
	 * 获取登录用户.USER_NO
	 * @param request
	 * @return userNo/""
	 */
	public static String getNiceName(HttpServletRequest request){
		User frontUser = getSession(request);
		if (frontUser!=null && StringUtils.isNotBlank(frontUser.getNICKNAME())) {
			return frontUser.getNICKNAME();
		} else {
			return "";
		}
	}
}
