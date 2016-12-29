package com.partner.busi.back.controller;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.back.validator.MatchValidator;
import com.partner.busi.model.Match;
import com.partner.busi.model.User;
import com.partner.common.constant.Constants;
import com.partner.common.util.EmailUtil;

public class BackMatchListController extends Controller {
	
	/**
	 * 比赛列表
	 */
	public void index(){
		render("match_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		int pageNum = getParaToInt("pageNum");
		int pageSize = Constants.PAGESIZE;
		
		Page<Match> page = Match.dao.findListAndUser(pageNum, pageSize);
		setAttr("paginate", page);
		render("match_list_result.jsp");
	}
	
	/**
     * 比赛 新增/更新
     */
	@Before(MatchValidator.class)
	public void saveOrUpdate(){
    	boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		Match mat = getModel(Match.class);
		
		mat.set("STATUS", 0);
		rsFlag = mat.save();
		rsMsg = "发布成功";
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
    }
	
	/**
	 * 取消比赛
	 */
	public void cancleMatch(){
		boolean rsFlag = false;
		String rsMsg = "删除失败，请稍后再试";
		
		Integer matID = getParaToInt("matID");
		Match mat = Match.dao.findById(matID);
		mat.set("STATUS", -1);
		rsFlag = mat.update();
		if(rsFlag){
			rsMsg = "隐藏成功";
			//发送邮件
			//查询活动下的所有报名用户
			Object[] obj = new Object[]{mat.getNAME()};
			List<User> userList = User.dao.find("select * from t_user a where a.ID in (select b.USER_ID from t_match_user b where b.MATCH_ID=?)", mat.getID());
			
			String subject = "[台球厅]取消比赛说明";
			
			for(int i=0;i<userList.size();i++){
	        	if(!"".equals(userList.get(i).getEMAIL())){
					EmailUtil.sendTypeEmail("2",subject, userList.get(i).getEMAIL(), obj);
	        	}
	        }
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	

}
