/**
 * 编辑参赛人员controller
 */
package com.partner.busi.front.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchUser;
import com.partner.busi.model.User;
import com.partner.busi.vo.MatchRinkListVo;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.FrontSessionUtil;

/**
 * @author fangrui
 *
 */
public class MatchDetailController extends Controller {

	public void index(){
		String matchId = getPara("matchId");
		Match match = Match.dao.findById(matchId);
		setAttr("match",match);
		/*List<MatchUser> userLst = MatchUser.dao.findMatchUserListByMatchId(matchId);
		setAttr("userLst",userLst);*/
		//判断当前用户是否已报名
		User loginUser = FrontSessionUtil.getSession(getRequest());
		int applyFlag = 0; //报名按钮标志  0 未报名  1 已报名  2 比赛报名人数已满
		if(loginUser != null && loginUser.getID() != null){
			//检查此用户目前是否已经报名
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("matchId", matchId);
			params.put("userId", loginUser.getID());
			List<MatchUser> currUser = MatchUser.dao.findUserByMatchId(params);
			if(currUser == null || currUser.size()==0){//未报名
				//获取比赛最大参赛人数
				//获取目前报名的最大seq
				int seq = MatchUser.dao.countMatchPersion(Integer.parseInt(matchId));
				if(seq>=match.getMaxPlayer()){
					applyFlag = 2;
				}
			}else{//已报名
				applyFlag = 1;
			}
		}
		setAttr("applyFlag",applyFlag);
		List<Game> sortData = Game.dao.sordMatch(Integer.parseInt(matchId));
		List<MatchRinkListVo> rinkingList = new ArrayList<MatchRinkListVo>();
		MatchRinkListVo rinkVo = null;
		int preWinNum = 0;
		for(int i=0;i<sortData.size();i++){
			Game game = sortData.get(i);
			String[] tempFlag = Game.dao.getMatchHis(Integer.parseInt(matchId), game.getUSER_ID());
			int seq = i+1;//排行榜名次
			if(preWinNum == game.getWinNum()){
				seq = seq - 1;
			}
			preWinNum = Integer.parseInt(String.valueOf(game.getWinNum()));
			rinkVo = new MatchRinkListVo(game.getWINNER_NAME(), seq, tempFlag);
			rinkingList.add(rinkVo);
		}
		//将比赛list调整成map进行存储
		Map<String,List<MatchRinkListVo>> rinkMap = new LinkedHashMap<String,List<MatchRinkListVo>>();
		Iterator iter = rinkingList.iterator();
		while(iter.hasNext()){
			rinkVo = (MatchRinkListVo) iter.next();
			if(rinkMap.get(rinkVo.getSeq())==null){
				//获取此排名的list
				List<MatchRinkListVo> mapValue = new ArrayList<MatchRinkListVo>();
				for(int i=0;i<rinkingList.size();i++){
					MatchRinkListVo temp =  rinkingList.get(i);
					if(temp.getSeq()==rinkVo.getSeq()){
						mapValue.add(temp);
					}
				}
				rinkMap.put(String.valueOf(rinkVo.getSeq()), mapValue);
			}
		}
		setAttr("rinkMap",rinkMap);
		setAttr("rinkList",rinkingList);
		setAttr("sortData",sortData);


		/*对阵图start*/
		String sql = "SELECT g.*, IFNULL(mu1.SEQ, 0) AS U1_SEQ, IFNULL(mu2.SEQ, 0) AS U2_SEQ,"
				+ " IFNULL(u1.`NAME`,'') as U1_NAME, IFNULL(u2.`NAME`,'') as U2_NAME"
				+ " FROM t_game g"
				+ " LEFT JOIN t_match_user AS mu1 ON g.USER1 = mu1.USER_ID and g.MATCH_ID=mu1.MATCH_ID"
				+ " LEFT JOIN t_match_user AS mu2 ON g.USER2 = mu2.USER_ID and g.MATCH_ID=mu2.MATCH_ID"
				+ " LEFT JOIN t_user AS u1 ON g.USER1 = u1.ID"
				+ " LEFT JOIN t_user AS u2 ON g.USER2 = u2.ID"
				+ " INNER JOIN t_match AS m ON m.ID = g.MATCH_ID"
				+ " WHERE g.MATCH_ID = ? and %s"
				+ " ORDER BY g.SHOW_INDEX";
		final String WIN_CON = "(m.TYPE in (1, 3) or (m.TYPE in (2, 4) and L_NEXT_ID != ''))";
		final String LOSE_CON = "(m.TYPE in (2, 4) and L_NEXT_ID = '')";

		List<Game> wList = Game.dao.find(String.format(sql, WIN_CON), matchId);
		List<Game> lList = Game.dao.find(String.format(sql, LOSE_CON), matchId);

		List<String> winTitleList = new ArrayList<String>();
		List<String> loseTitleList = new ArrayList<String>();

		List<List<Game>> winList = generateList(wList, winTitleList, true);
		List<List<Game>> loseList = generateList(lList, loseTitleList, false);

		setAttr("winList", winList);
		setAttr("winTitleList", winTitleList);
		setAttr("loseList", loseList);
		setAttr("loseTitleList", loseTitleList);
		/*对阵图end*/

		render("matchDeatil.jsp");
	}
	
	//获取参赛人员列表
	public void matchUserList(){
		Integer matchId = getParaToInt("matchId");
		int pageNum = getParaToInt("pageNum");
		int pageSize = Constants.PAGESIZE;
		
		Page<MatchUser> allMatchUser = MatchUser.dao.findMatchUserListByMatchId(pageNum, pageSize,String.valueOf(matchId));
		setAttr("page",allMatchUser);
		render("match_detail_list.jsp");
	}

	private List<List<Game>> generateList(List<Game> list, List<String> titleList, boolean isWin){
		List<List<Game>> retList = new ArrayList<List<Game>>();

		List<Integer> roundList = new ArrayList<Integer>();
		for(Game game : list){
			if(!roundList.contains(game.getRoundNum())){
				roundList.add(game.getRoundNum());
				retList.add(new ArrayList<Game>());
			}
		}
		if(isWin){
			for(int i = 0; i < roundList.size(); i++){
				if(i == roundList.size() - 1){
					titleList.add("决赛");
				}else if(i == roundList.size() - 2){
					titleList.add("半决赛");
				}else{
					titleList.add("第" + roundList.get(i) + "轮");
				}
			}
		}else{
			for(int i = 0; i < roundList.size(); i++){
				titleList.add("败者组回合" + roundList.get(i));
			}
		}

		for(Game game : list){
			retList.get(game.getRoundNum() - 1).add(game);
		}
		return retList;
	}
	
	public void getUserLst(){
		int matchId = getParaToInt("matchId");
		Map<String,Object> params = new HashMap();
		params.put("matchId", matchId);
		List<MatchUser> matchUserLst = MatchUser.dao.findUserByMatchId(params);
		//setAttr("matchUserLst",matchUserLst);
		renderJson(matchUserLst);
	}
	
	public void addMatch(){
		int matchId = getParaToInt("matchId");
		ResultInfo ret = new ResultInfo();
		ret.setRetCode(1);
		ret.setRetMsg("用户未登录");
		//判断用户是否已经登录
		User loginUser = FrontSessionUtil.getSession(getRequest());
		if(loginUser != null && loginUser.getID() != null){
			//检查此用户目前是否已经报名
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("matchId", matchId);
			params.put("userId", loginUser.getID());
			List<MatchUser> userLst = MatchUser.dao.findUserByMatchId(params);
			if(userLst == null || userLst.size()==0){
				//获取比赛最大参赛人数
				Match match = Match.dao.findById(matchId);
				//获取目前报名的最大seq
				int seq = MatchUser.dao.countMatchPersion(matchId);
				if(seq!=0 && seq<match.getMaxPlayer()){
					MatchUser matchUser = new MatchUser();
					matchUser.setMatchId(matchId);
					matchUser.setSEQ(seq+1);
					matchUser.setUserId(loginUser.getID());
					matchUser.setCreateTime(new Date());
					matchUser.save();
					ret.setRetCode(0);
					ret.setRetMsg("报名成功");
				}else{
					ret.setRetMsg("报名人数已达上限");
				}
			}else{
				ret.setRetMsg("当前用户已报名");
			}
		}
		renderJson(ret);
	}
	
	public void getMatchHis(){
		int matchId = getParaToInt("matchId");
		List<Game> sortData = Game.dao.sordMatch(matchId);
		for(Game game: sortData){
			String[] tempFlag = Game.dao.getMatchHis(matchId, Integer.parseInt(String.valueOf(game.getUSER_ID())));
			game.setMatchFlag(tempFlag);
		}
		renderJson(sortData);
	}
}
