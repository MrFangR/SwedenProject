package com.partner.busi.back.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.partner.busi.model.BackSession;
import com.partner.busi.model.CUser;

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
		if (user==null || StringUtils.isBlank(user.getStr(CUser.C_USER_NO))) {
			log.info("初始化后台管理系统所用用户对象为空，初始化失败，直接返回");
			return false;
		}
		String userNo = user.getStr(CUser.C_USER_NO);
		BackSession session = new BackSession();
		session.setUser(user);
		log.info("初始化后台管理用户信息 完成[userNo="+userNo+"]");
		// 根据userId获取 角色对象
		BackRole role = BackRole.dao.getBackRole(user.getInt(CUser.C_USER_ID));
		if (role == null) {
			log.info("初始化后台管理用户角色信息 失败，未查询到后台管理用户[userNo="+userNo+"]的角色信息");
			return false;
		}
		session.setRole(role);
		log.info("初始化后台管理用户角色信息 完成[userNo="+userNo+"]["+role.getStr(BackRole.C_ROLE_NAME)+"]");
		// 获取权限ID列表
		List<BackRolePriv> rpLst = BackRolePriv.dao.getPrivLst(role.getInt("ID"));
		if (rpLst!=null && rpLst.size()>0) {
			List<Integer> privIdLst = new ArrayList<Integer>();
			for (BackRolePriv rp : rpLst) {
				if (rp != null) {
					privIdLst.add(rp.getInt("PRIVILEGE_ID"));
				}
			}
			session.setPrivIdLst(privIdLst);
			log.info("初始化后台管理用户权限信息 完成[userNo="+userNo+"][size="+privIdLst.size()+"]");
		}
		// 设置session值
		request.getSession().setAttribute(CommonConstants.BACK_SESSION, session);
		log.info("初始化后台管理用户session 完成[userNo="+userNo+"]");
		return true;
	}
	
	/**
	 * 获取 BackSession
	 * @return CUser
	 */
	public static BackSession getSession(HttpServletRequest request){
		BackSession backSess = (BackSession)request.getSession().getAttribute(CommonConstants.BACK_SESSION);
		if(backSess == null){
			backSess = new BackSession();
			request.getSession().setAttribute(CommonConstants.BACK_SESSION, backSess);
		}
		return backSess;
	}

	/**
	 * 清除 BackSession
	 */
	public static void clearSession(HttpServletRequest request){
		request.getSession().removeAttribute(CommonConstants.BACK_SESSION);
	}
	
	/**
	 * 判断是否登录状态
	 * @param request
	 * @return boolean
	 */
	public static boolean isLoginBack(HttpServletRequest request){
		BackSession backSess = getSession(request);
		// 判断session不为空，且session中存放的 用户对象不为空，且其USER_NO属性也不为空
		if (backSess!=null
				&& backSess.getUser()!=null
				&& StringUtils.isNotBlank(backSess.getUser().getStr("USER_NAME"))) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 获取登录用户.USER_NAME
	 * @param request
	 * @return userNo/""
	 */
	public static String getUserName(HttpServletRequest request){
		CUser CUser = getSession(request).getUser();
		if (CUser!=null && StringUtils.isNotBlank(CUser.getStr("USER_NAME"))) {
			return CUser.getStr("USER_NAME");
		} else {
			return "";
		}
	}
	
	/**
	 * 获取登录用户.USER_ID
	 * @param request
	 * @return userNo/""
	 */
	public static String getUserId(HttpServletRequest request){
		CUser CUser = getSession(request).getUser();
		if (CUser!=null && StringUtils.isNotBlank(CUser.getStr("ID"))) {
			return CUser.getStr("ID");
		} else {
			return "";
		}
	}
	
}
