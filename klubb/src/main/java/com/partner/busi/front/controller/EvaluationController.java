package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.EvaluationValidator;
import com.partner.busi.model.Evaluation;
import com.partner.busi.model.User;
import com.partner.common.util.FrontSessionUtil;

public class EvaluationController extends Controller {

	/**
	 * 发表评论
	 */
	@Before(EvaluationValidator.class)
	public void addEva(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Evaluation eva = getModel(Evaluation.class);
		
		//判断是否为登录状态
		if(FrontSessionUtil.isLogin(getRequest())){
			//获取用户登录信息
			User user = FrontSessionUtil.getSession(getRequest());
			eva.set("USER_ID", user.getID());
			eva.set("CREATE_TIME", new Date());
			rsFlag = eva.save();
			if(rsFlag){
				rsMsg = "评论成功！";
			}
		}else{
			rsFlag = false;
			rsMsg = "登陆之后才可以评论！";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * 展示所有评论
	 */
	public void showEva(){
		Integer objID = getParaToInt("objID");
		Integer objType = getParaToInt("objType");
		Integer PID = getParaToInt("PID");
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Evaluation> page = Evaluation.dao.findEvaByObjIDandPID(objID,PID,objType,pageNum, pageSize);
		setAttr("page", page);
		renderJson();
	}
}
