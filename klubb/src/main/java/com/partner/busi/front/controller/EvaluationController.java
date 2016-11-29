package com.partner.busi.front.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.front.validator.EvaluationValidator;
import com.partner.busi.model.Evaluation;

public class EvaluationController extends Controller {

	/**
	 * 发表评论
	 */
	@Before(EvaluationValidator.class)
	public void addEva(){
		boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Evaluation eva = getModel(Evaluation.class);
		
		eva.set("USER_ID", 1);//xianxiesi
		eva.set("CREATE_TIME", new Date());
		rsFlag = eva.save();
		if(rsFlag){
			rsMsg = "评论成功！";
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
