package com.partner.busi.back.controller;

import java.math.BigDecimal;

import com.jfinal.core.Controller;
import com.partner.busi.model.SysAccessLog;
import com.partner.busi.model.SysAccessLogHis;
import com.partner.common.util.DateUtil;

/**
 * 后台管理系统 首页相关controller
 * @author: YangKai
 */
public class BackMainController extends Controller {
	/**
	 * 后台页面框架初始化
	 */
	public void init(){
		render("backPanel.jsp");
	}
	
	/**
	 * 后台首页
	 */
	public void index(){
		//获取今日访问量和 历史访问量
		Long todayNum = SysAccessLog.dao.countTodayInterview(DateUtil.currentDateFormat("yyyyMMdd"));
		setAttr("todayNum",todayNum);
		//获取历史访问量  当前月访问量+历史访问量
		Long currMonth = SysAccessLog.dao.countTodayInterview(DateUtil.currentDateFormat("yyyyMM"));
		Long hisNum = SysAccessLogHis.dao.countTotal();
		setAttr("hisNum",hisNum+currMonth);
		render("backMain.jsp");
	}
	
	/**
	 * 无权限跳转
	 */
	public void noPriv(){
		setAttr("flag", getPara("flag"));
		render("common/backNoPriv.jsp");
	}
}
