/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.partner.busi.model.Game;
import com.partner.busi.model.Match;
import com.partner.busi.model.MatchTemplate.GameTemplate;
import com.partner.busi.model.MatchUser;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.MatchTemplateCache;

import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;

/** 
 * @ClassName: BackMatchController 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月25日 上午12:39:40  
 */
public class BackMatchController extends Controller {
	
	public void index(){
		Integer matchId = getParaToInt("matchId");
		Match match = Match.dao.findById(matchId);

		Integer lastSeq = null;
		Integer secondMatchId = null;
		if(match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
			lastSeq = Match.dao.getStopSeq(matchId);
			secondMatchId = Match.dao.getChildMatchId(matchId);
		}

		List<Game> wList = Game.dao.getAgainstList(matchId, lastSeq, true);
		List<Game> lList = Game.dao.getAgainstList(matchId, lastSeq, false);
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
			Integer thirdMatchId = matchId;
			if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				if (match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
					Integer childMatchId = Match.dao.getChildMatchId(matchId);
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
		
		String tabFlag = getPara("flag");
		if(StringUtils.isNotBlank(tabFlag)){
			setAttr("tabFlag",tabFlag);
		}
		List<MatchUser> matchUser = MatchUser.dao.findMatchUserListBySeq(String.valueOf(matchId));
		setAttr("matchUser",matchUser);
		List<User> noMatchUser = User.dao.findNoMatchUser(matchId);
		setAttr("noMatchUser", noMatchUser);
		//获取全部报名人员
		/*List<MatchUser> allMatchUser = MatchUser.dao.findMatchUserListByMatchId(String.valueOf(matchId));
		setAttr("allMatchUser",allMatchUser);*/
		
		render("match_edit.jsp");
	}
	
	//获取参赛人员列表
	public void tab3list(){
		Integer matchId = getParaToInt("matchId");
		int pageNum = getParaToInt("pageNum");
		int pageSize = Constants.PAGESIZE;
		
		Page<MatchUser> allMatchUser = MatchUser.dao.findMatchUserListByMatchId(pageNum, pageSize,String.valueOf(matchId));
		setAttr("paginate",allMatchUser);
		render("match_edit_tab3.jsp");
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
	
	
	/**
	 * 更新比分
	 */
	public void updateScore(){
		Integer winId = getParaToInt("winId");
		Integer score1 = getParaToInt("score1");
		Integer score2 = getParaToInt("score2");
		Integer gameId = getParaToInt("gameId");
		boolean rsFlag = false;
		try {
			rsFlag = updateScoreTx(winId, score1, score2, gameId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson("rsFlag", rsFlag);
	}
	
	@Before(Tx.class)
	private boolean updateScoreTx(Integer winId, Integer score1, Integer score2, Integer gameId) throws SQLException{
		boolean flag1 = Game.dao.updateScore(gameId, winId, score1, score2);
		boolean flag2 = true;
		boolean flag3 = true;
		
		Game game = Game.dao.findById(gameId);
		String wNextId = game.getWNextId();
		if(StringUtils.isNotBlank(wNextId)){ //胜者组迁移
			Integer seq = Integer.parseInt(wNextId.split("_")[0]);
			Integer index = Integer.parseInt(wNextId.split("_")[1]);
			flag2 = Game.dao.moveUserToGame(game.getMatchId(), seq, index, winId);
		}
		
		String lNextId = game.getLNextId();
		if(StringUtils.isNotBlank(lNextId)){ //败者组迁移
			Integer seq = Integer.parseInt(lNextId.split("_")[0]);
			Integer index = Integer.parseInt(lNextId.split("_")[1]);
			Integer loseId = (game.getUSER1().equals(winId)) ? game.getUSER2() : game.getUSER1();
			flag3 = Game.dao.moveUserToGame(game.getMatchId(), seq, index, loseId);
		}
		boolean flag4 = moveToSecondMatch(game);
		boolean flag5 = finishMatch(game);
		if(flag1 && flag2 && flag3 && flag4 && flag5){
			return true;
		}else{
			DbKit.getConfig().getConnection().rollback();
			return false;
		}
	}

    private boolean finishMatch(Game game) {
        //判断是否有第二回合
        int matchId = game.getMatchId();
        Match match = Match.dao.findById(matchId);
        if(match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){ //有第二回合，不做判断
            return true;
        }else{//无第二回合，或是第二回合
            if (Game.dao.isLastGame(game)){ //是最后一场比赛
                match.setSTATUS(2);
                match.update();
                if(match.getPId() != null){
                    Match pMatch = Match.dao.findById(match.getPId());
                    pMatch.setSTATUS(2);
                    pMatch.update();
                }
                return true;
            }else{
                return true;
            }
        }
    }

    private boolean moveToSecondMatch(Game game) {
		//0.判断是否有第二回合
		int matchId = game.getMatchId();
		Match match = Match.dao.findById(matchId);
		if(match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
			Integer lastSeq = Match.dao.getStopSeq(matchId);
			int secondPlayer = match.getStopPlayer();
			//1.判断是否要移入第二回合
			if(lastSeq == null){
				return true;
			}else{
				if(game.getSEQ() >= lastSeq-secondPlayer){ //需要移动
					//2.移入下一轮比赛
					//删除已存在的同组及自己的数据
					Integer secondMatchId = Match.dao.getChildMatchId(matchId);
					MatchUser.dao.deleteByGame(secondMatchId, game);
					Game.dao.deleteByGame(secondMatchId, game);

					//3.判断移入到哪个seq
					Game nextGame = Game.dao.getSecondNextGame(secondMatchId);
					if(nextGame.getUSER1() == null){
						nextGame.setUSER1(game.getWinnerId());
					}else{
						nextGame.setUSER2(game.getWinnerId());
					}
					boolean rs = nextGame.update();
					if(!rs){
						return false;
					}else{
						return MatchUser.dao.insertSecondMatchUser(nextGame, game.getWinnerId());
					}
				}else{
					return true;
				}
			}

		}else{
			return true;
		}
	}


	/**
	 * 修改比赛信息
	 */
	public void updateGameInfo(){
		String tableNum = getPara("tableNum");
		String startTimeStr = getPara("startTime");
		Integer type = getParaToInt("type");
		Integer gameId = getParaToInt("gameId");
		
		
		boolean rsFlag = false;
		try {
			Date startTime = null;
			if (StringUtils.isNotEmpty(startTimeStr)) {
				startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(startTimeStr);
			}
			Game game = Game.dao.findById(gameId);
			game.setTableNum(tableNum);
			game.setTYPE(type);
			game.setStartTime(startTime);
			rsFlag = game.update();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rsFlag = false;
		}
		renderJson("rsFlag", rsFlag);
	}
	
	/**
	 * 交换
	 */
	public void exchange(){
		Integer gameId1 = getParaToInt("gameId1");
		Integer gameId2 = getParaToInt("gameId2");
		Integer userIndex1 = getParaToInt("userIndex1");
		Integer userIndex2 = getParaToInt("userIndex2");
		Integer userId1 = getParaToInt("userId1");
		Integer userId2 = getParaToInt("userId2");
		
		boolean rsFlag = false;
		try {
			rsFlag = updateUsers(gameId1, gameId2, userIndex1, userIndex2, userId1, userId2);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		renderJson("rsFlag", rsFlag);
	}
	
	@Before(Tx.class)
	private boolean updateUsers(Integer gameId1, Integer gameId2, Integer userIndex1, Integer userIndex2, Integer userId1, Integer userId2) throws SQLException{
		boolean flag1 = Game.dao.updateUser(gameId1, userId1, userIndex1);
		boolean flag2 = Game.dao.updateUser(gameId2, userId2, userIndex2);
		if(flag1 && flag2){
			return true;
		}else{
			DbKit.getConfig().getConnection().rollback();
			return false;
		}
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
	
	public void generateGame(){
		Integer matchId = getParaToInt("matchId");
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(1);
		retInfo.setRetMsg("生成对阵图失败");
		Match match = Match.dao.findById(matchId);
		if(match != null && match.getSTATUS() == 0){ //比赛未开始，根据当前用户信息重新生成比赛
			//1.删除本赛事下所有比赛
			Integer secondMatchId = null;
			if(match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
				secondMatchId = Match.dao.getChildMatchId(matchId);
			}
			Game.dao.deleteByMatchId(matchId);
			if(secondMatchId != null){
				Game.dao.deleteByMatchId(secondMatchId);
			}
			//2.根据当前人员生成比赛
			//2.1获取当前参赛人员，orderby seq
			List<MatchUser> list = MatchUser.dao.findUserByMatchId(matchId);
			List<Integer> userIdList = new ArrayList<Integer>();
			for(MatchUser user : list){
				userIdList.add(user.getUserId());
			}
			//2.2生成比赛
			Integer thirdMatchId = matchId;
			if(match.getTYPE() == 1 || match.getTYPE() == 3){ //单败
//				generateSingleGame(userIdList, 0, 0, 1, matchId);
				generateSingleGame(userIdList, null, matchId);
			} else if(match.getTYPE() == 2 || match.getTYPE() == 4){ //双败
				generateDoubleGame(userIdList, matchId);
				if (match.getStopPlayer() != null && !match.getStopPlayer().equals(0)){
					Integer childMatchId = Match.dao.getChildMatchId(matchId);
					generateSingleGame(null, match.getStopPlayer(), childMatchId);
					thirdMatchId = childMatchId;
				}
			}
			if(match.getTHIRD() != null && match.getTHIRD().equals(1)){
				Game.dao.generateThird(thirdMatchId);
			}
			retInfo.setRetCode(0);
			retInfo.setRetMsg("生成对阵图成功");
		} else if (match.getSTATUS() != 0){
			retInfo.setRetMsg("只能对未开始的比赛生成对阵图");
		}
		renderJson(retInfo);
	}
	
	public void delUser(){
		ResultInfo retInfo = new ResultInfo();
		String id = getPara("id");
		MatchUser user = MatchUser.dao.findById(id);
		if(user == null){
			retInfo.setRetCode(1);
			retInfo.setRetMsg("参赛人员获取失败，请稍后再试！");
		}else{
			int flag = MatchUser.dao.batchUpdateSeq(user.getMatchId(), user.getSEQ());
			user.setSEQ(null);
			user.update();
			retInfo.setRetCode(0);
			retInfo.setRetMsg("参赛人员删除成功！");
		}
		renderJson(retInfo);
	}
	
	public void randomSort(){
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(1);
        retInfo.setRetMsg("打乱失败");
		String id = getPara("id");
		List<MatchUser> matchUser = MatchUser.dao.findMatchUserListBySeq(id);
		Collections.shuffle(matchUser);
		MatchUser user = null;
        MatchUser userDefail = null;
		for(int i=0;i<matchUser.size();i++){
			user = matchUser.get(i);
            userDefail = MatchUser.dao.findById(user.getID());
            userDefail.setSEQ(i+1);
            userDefail.update();
		}
        /*int len=matchUser.size();
        Integer[] strTemp = generateRandomize(len);
        MatchUser user = null;
        MatchUser userDefail = null;
        for(int i=0; i<len; i++)  
        {  
            user = matchUser.get(i);
            userDefail = MatchUser.dao.findById(user.getID());
            userDefail.setSEQ(strTemp[i]);
            userDefail.update();
        }*/ 
        retInfo.setRetCode(0);
        retInfo.setRetMsg("打乱成功");
		renderJson(retInfo);
	}
	
	public Integer[] generateRandomize(int len){
		Integer[] temp = new Integer[len];
        Random random=new Random();
        boolean flag = true;
        for(int i=0; i<len; i++){
        	int pos=Math.abs(random.nextInt(len)%len)+1;
        	while(true){
            	for(int j=0;j<len;j++){
                	if(temp[j]!= null && temp[j] == pos){
                		flag = false;
                		break;
                	}
                }
            	if(flag){
            		temp[i] = pos;
            		break;
            	}
            	pos=(int)(random.nextDouble()*(len-i+1)+i)-1;
            	flag = true;
            }
        }
		return temp;
	}
	
	public void addUser(){
		String uid = getPara("id");
		String matchId = getPara("matchId");
		MatchUser user = MatchUser.dao.findMatchUserByUID(matchId,uid);
		User u = User.dao.findById(uid);
		int maxSeq = MatchUser.dao.countMatchPersion(Integer.parseInt(matchId));
		if(user == null){
			user = new MatchUser();
			user.setMatchId(Integer.parseInt(matchId));
			user.setSEQ(maxSeq+1);
			user.setUserId(Integer.parseInt(uid));
			user.setCreateTime(new Date());
			user.setStartScore(u.getLastStartScore());
			user.save();
		}else{
			user.setSEQ(maxSeq+1);
			user.setStartScore(u.getLastStartScore());
			user.update();
		}
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("添加成功");
		renderJson(retInfo);
	}
	
	public void setScore(){
		ResultInfo retInfo = new ResultInfo();
		int id = getParaToInt("id");
		String score = getPara("score");
		int uid = getParaToInt("uid");
		int result = MatchUser.dao.updateStartScore(id, score);
		if(result>0){
			//补充更新t_user 表最近一场起始分
			User user = User.dao.findById(uid);
			if(user != null){
				user.setLastStartScore(score);
				user.update();
			}
			retInfo.setRetCode(0);
			retInfo.setRetMsg("更新成功");
		}else{
			retInfo.setRetCode(1);
			retInfo.setRetMsg("更新失败");
		}
		renderJson(retInfo);
	}
	
	/**
	 * 生成单败制比赛
	 * @param userIdList
	 * @param seq
	 * @param userSum
	 * @param roundNum
	 * @param matchId
	 */
//	private void generateSingleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
//		if(userIdList != null){ //首轮有此参数
//			userSum = userIdList.size();
//		}
//		int gameSum = 1;
//		//根据参赛人员人数获得比赛场数
//		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
//		if(needGame > 0){
//			while(needGame > gameSum){
//				gameSum *= 2;
//			}
//			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
//					
//			//创建比赛
//			int userIndex = 0;
//			int winNextSeq = seq + gameSum + 1; //胜者下一场比赛序列
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				if(userIdList != null){ //首轮有此参数
//					game.setUSER1(userIdList.get(userIndex++));
//					if(i + byeUserSum < gameSum){ //不轮空才设置user2
//						game.setUSER2(userIdList.get(userIndex++));
//					}
//				}
//				game.setSEQ(++seq);
//				game.setShowIndex(seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextId(winNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
//				game.save();
////				System.out.println(game);
//			}
//			if(gameSum <= 1){ //最后一场比赛
//				return;
//			}
//			generateSingleGame(null, seq, gameSum, ++roundNum, matchId);
//		}else{
//			return;
//		}
//	}
	
	/**
	 * 生成单败制比赛
	 * @param userIdList
	 * @param matchId
	 */
	private void generateSingleGame(List<Integer> userIdList, Integer doubleStop, int matchId){
		int userSum = 0;
		if(userIdList != null){ //首轮有此参数
			userSum = userIdList.size();
		}
		if(doubleStop != null){ //由双败生成的单败比赛
			userSum = doubleStop;
		}
		int gameSum = 1;
		//根据参赛人员人数获得比赛场数
		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
		if(needGame > 0){
			while(needGame > gameSum){
				gameSum *= 2;
			}
			
			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
			int userIndex = 0;
			List<GameTemplate> list = MatchTemplateCache.getGameList(MatchTemplateCache.SINGLE_CACHE_NAME, gameSum * 2);
			for(int i = 0; i < list.size(); i++){
				Game game = new Game();
				GameTemplate tmp = list.get(i);
				if(tmp.getRoundNum() == 1 && doubleStop == null){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(tmp.getSeq());
				game.setShowIndex(tmp.getShowIndex());
				game.setWNextId(tmp.getWinNextId());
				game.setLNextId(tmp.getLoseNextId());
				game.setRoundNum(tmp.getRoundNum());
				game.setMatchId(matchId);
				game.setSTATUS(0);
				game.save();
			}
		}
		
	}
	
	/**
	 * 生成双败制比赛
	 * @param userIdList
	 * @param matchId
	 */
	private void generateDoubleGame(List<Integer> userIdList, int matchId){
		int userSum = 0;
		if(userIdList != null){ //首轮有此参数
			userSum = userIdList.size();
		}
		int gameSum = 1;
		//根据参赛人员人数获得比赛场数
		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
		if(needGame > 0){
			while(needGame > gameSum){
				gameSum *= 2;
			}
			
			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
			int userIndex = 0;
			List<GameTemplate> list = MatchTemplateCache.getGameList(MatchTemplateCache.DOUBLE_CACHE_NAME, gameSum * 2);
			for(int i = 0; i < list.size(); i++){
				Game game = new Game();
				GameTemplate tmp = list.get(i);
				if(tmp.getRoundNum() == 1 && StringUtils.isNotBlank(tmp.getLoseNextId())){ //首轮有此参数
					game.setUSER1(userIdList.get(userIndex++));
					if(i + byeUserSum < gameSum){ //不轮空才设置user2
						game.setUSER2(userIdList.get(userIndex++));
					}
				}
				game.setSEQ(tmp.getSeq());
				game.setShowIndex(tmp.getShowIndex());
				game.setWNextId(tmp.getWinNextId());
				game.setLNextId(tmp.getLoseNextId());
				game.setRoundNum(tmp.getRoundNum());
				game.setMatchId(matchId);
				game.setSTATUS(0);
				game.save();
			}
		}
		
	}
//	private void generateDoubleGame(List<Integer> userIdList, int seq, int userSum, int roundNum, int matchId){
//		if(userIdList != null){ //首轮有此参数
//			userSum = userIdList.size();
//		}
//		int gameSum = 1;
//		//根据参赛人员人数获得比赛场数
//		int needGame = new BigDecimal(userSum).divide(new BigDecimal(2), RoundingMode.CEILING).intValue();
//		if(needGame > 0){
//			while(needGame > gameSum){
//				gameSum *= 2;
//			}
//			int byeUserSum = gameSum * 2 - userSum; //轮空人数，即首轮轮空比赛数
//					
//			//创建比赛
//			int userIndex = 0;
//			int winNextSeq = seq + gameSum + gameSum/2 + 1; //胜者下一场比赛序列
//			int loseNextSeq = seq + gameSum + 1; //败者下一场比赛序列
//			
//			//胜者组
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				if(userIdList != null){ //首轮有此参数
//					game.setUSER1(userIdList.get(userIndex++));
//					if(i + byeUserSum < gameSum){ //不轮空才设置user2
//						game.setUSER2(userIdList.get(userIndex++));
//					}
//				}
//				game.setSEQ(++seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextSeq(winNextSeq);
//					game.setLNextSeq(loseNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//					loseNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
////				game.save();
//				System.out.println(game);
//			}
//			
//			//败者组
//			if(roundNum == 1){
//				gameSum = gameSum/2;
//			}
//			for(int i = 0; i < gameSum; i++){
//				Game game = new Game();
//				game.setSEQ(++seq);
//				if(gameSum > 1){ //不是最后一场比赛
//					game.setWNextSeq(winNextSeq);
//				}
//				if(seq % 2 == 0){
//					winNextSeq++;
//					loseNextSeq++;
//				}
//				game.setRoundNum(roundNum);
//				game.setMatchId(matchId);
//				game.setSTATUS(0);
////				game.save();
//				System.out.println(game);
//			}
//			
//			if(gameSum <= 1){ //最后一场比赛
//				return;
//			}
//			generateDoubleGame(null, seq, gameSum, ++roundNum, matchId);
//		}else{
//			return;
//		}
//	}
	
}
