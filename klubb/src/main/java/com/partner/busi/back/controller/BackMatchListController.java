package com.partner.busi.back.controller;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.back.validator.MatchValidator;
import com.partner.busi.model.Game;
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
		//判断是否超过报名时间
//		Date nowDate = new Date();
//		Date startDate = mat.getStartDate();
//		if(nowDate.after(startDate)){
//			rsMsg = "比赛已经开始，不能取消活动";
//		}else if(mat.getSTATUS()!=-1||mat.getSTATUS()!=1){//判断已取消或者已开始不能取消
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
//		}else{
//			rsMsg = "比赛已经开始或者已经取消，不能取消活动";
//		}
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	
	/**
	 * 开始比赛
	 */
	public void startMatch(){
		boolean rsFlag = false;
		String rsMsg = "开始比赛失败，请稍后再试";
		
		Integer matID = getParaToInt("matID");
		Match mat = Match.dao.findById(matID);
		initByeGame(matID);
		mat.set("STATUS", 1);
		rsFlag = mat.update();
		
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * 初始化轮空的比赛
	 * @param matchId
	 * @return
	 */
	private void initByeGame(int matchId){
		List<Game> gameList = Game.dao.find("select * from t_game g where g.MATCH_ID=?", matchId);
		List<Game> round1GameList = Game.dao.find("select * from t_game g where g.MATCH_ID=? and g.ROUND_NUM=1 order by g.SEQ", matchId);
		for(Game game : round1GameList){
			if((game.getUSER1() != null && game.getUSER2() == null) || (game.getUSER1() == null && game.getUSER2() != null)){ //有轮空人员
				String W_NEXT_ID = game.getWNextId();
				
				//获得唯一参赛者
				Integer userId = null;
				if(game.getUSER1() != null){
					userId = game.getUSER1();
				}else if(game.getUSER2() != null){
					userId = game.getUSER2();
				}
				
				//修改下一场比赛中参赛者
				if(StringUtils.isNotBlank(W_NEXT_ID)){ //下一场比赛不为空
					Integer seq = Integer.parseInt(W_NEXT_ID.split("_")[0]);
					int nextIndex = Integer.parseInt(W_NEXT_ID.split("_")[1]);
					for(Game toGame : gameList){
						if(toGame.getSEQ().equals(seq)){ //下一场比赛
							if(nextIndex == 1){
								toGame.setUSER1(userId);
							}else if(nextIndex == 2){
								toGame.setUSER2(userId);
							}
							toGame.update();
							break;
						}
					}
				}
			}
		}
	}
	
	

}
