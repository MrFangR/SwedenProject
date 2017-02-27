/**
 * 编辑参赛人员controller
 */
package com.partner.busi.front.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchUser;
import com.partner.busi.model.MatchUserSort;
import com.partner.busi.model.User;
import com.partner.busi.vo.MatchRinkListVo;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.FrontSessionUtil;

import java.util.*;

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
		//排行榜获取思路：分步取数，先取得参赛所有人员，再根据人员逐个核实统计比赛所获名次，放入list,进行排序
		List<MatchUserSort> sortUserLst = new ArrayList<MatchUserSort>();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("matchId", matchId);
		List<MatchUser> matchUserLst = MatchUser.dao.findUserByMatchId(params);
		for(int i=0;i<matchUserLst.size();i++){
			MatchUser mUser = matchUserLst.get(i);
			MatchUserSort sortUser = new MatchUserSort();
			sortUser.setUserId(mUser.getUserId());
			int score = Game.dao.countMatchScore(Integer.parseInt(matchId), mUser.getUserId().intValue());
			sortUser.setScore(score);
			sortUserLst.add(sortUser);
		}
		//List<Game> sortData = Game.dao.sordMatch(Integer.parseInt(matchId));
		Collections.sort(sortUserLst);
		
		List<MatchRinkListVo> rinkingList = new ArrayList<MatchRinkListVo>();
		MatchRinkListVo rinkVo = null;
		int preWinNum = 0;//排行榜名次
		int seq = 0;//
		for(int i=0;i<sortUserLst.size();i++){
			MatchUserSort game = sortUserLst.get(i);
			String[] tempFlag = Game.dao.getMatchHis(Integer.parseInt(matchId), game.getUserId());
			seq = seq+1;//排行榜名次
			if(preWinNum == game.getScore()){
				seq = seq - 1;
			}
			preWinNum = game.getScore();
			User user = User.dao.findById(game.getUserId());
			rinkVo = new MatchRinkListVo(user.getNAME(), seq, tempFlag);
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
		setAttr("sortData",sortUserLst);


		/*对阵图start*/
		Integer lastSeq = null;
		Integer secondMatchId = null;
		if(match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
			lastSeq = Match.dao.getStopSeq(Integer.parseInt(matchId));
			secondMatchId = Match.dao.getChildMatchId(Integer.parseInt(matchId));
		}

		List<Game> wList = Game.dao.getAgainstList(Integer.parseInt(matchId), lastSeq, true);
		List<Game> lList = Game.dao.getAgainstList(Integer.parseInt(matchId), lastSeq, false);
		List<Game> sList = new ArrayList<Game>();
		if(secondMatchId != null){
			sList = Game.dao.getAgainstList(secondMatchId, null, true);
		}

		List<String> winTitleList = new ArrayList<String>();
		List<String> loseTitleList = new ArrayList<String>();
		List<String> secondTitleList = new ArrayList<String>();

		List<List<Game>> winList = generateList(wList, winTitleList, true);
		List<List<Game>> loseList = generateList(lList, loseTitleList, false);
		List<List<Game>> secondList = generateList(sList, secondTitleList, true);

		Game thirdGame = null;
		if(match.getTHIRD() != null && match.getTHIRD().equals(1)){
			Integer thirdMatchId = Integer.parseInt(matchId);
			if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				if (match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
					Integer childMatchId = Match.dao.getChildMatchId(Integer.parseInt(matchId));
					thirdMatchId = childMatchId;
				}
			}
			thirdGame = Game.dao.getThirdGame(thirdMatchId);
		}

		setAttr("match", match);
		setAttr("winList", winList);
		setAttr("winTitleList", winTitleList);
		setAttr("loseList", loseList);
		setAttr("loseTitleList", loseTitleList);
		setAttr("secondTitleList", secondTitleList);
		setAttr("secondList", secondList);
		setAttr("thirdGame", thirdGame);
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
				if(seq<match.getMaxPlayer()){
					MatchUser matchUser = new MatchUser();
					matchUser.setMatchId(matchId);
					matchUser.setSEQ(seq+1);
					matchUser.setUserId(loginUser.getID());
					matchUser.setCreateTime(new Date());
					matchUser.setStartScore(loginUser.getLastStartScore());
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
