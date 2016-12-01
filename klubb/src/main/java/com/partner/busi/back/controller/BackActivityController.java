package com.partner.busi.back.controller;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.back.validator.ActivityValidator;
import com.partner.busi.model.ActUser;
import com.partner.busi.model.Activity;
import com.partner.common.util.BackSessionUtil;
import com.partner.common.util.EmailUtil;

public class BackActivityController extends Controller {
	private static Logger log = Logger.getLogger(BackActivityController.class);
	private final static Integer pageSize = 10; //每页显示数量
	
	/**
	 * 活动列表
	 */
	public void index(){
		render("activity/activity_list.jsp");
	}

	/**
	 * 搜索
	 */
	public void list(){
		String title = getPara("title");
		int pageNum = getParaToInt("pageNum");
		int pageSize = getParaToInt("pageSize");
		
		Page<Activity> page = Activity.dao.findList(title, pageNum, pageSize);
		setAttr("paginate", page);
		render("activity/activity_list_result.jsp");
	}
	
	/**
	 * 获取活动编辑页面
	 */
	public void edit(){
		String type = getPara("type");
		Activity act = Activity.dao.findById(type);
		setAttr("act", act);
		render("activity/activity_edit.jsp");
	}
	
	/**
     * 活动 新增/更新
     */
	@Before(ActivityValidator.class)
	public void saveOrUpdate(){
    	boolean rsFlag = false;
		String rsMsg = "发布失败，请稍后再试";
		
		String type = getPara("type");
		Activity act = getModel(Activity.class);
		if("1".equals(type)){//保存
			act.set("STATUS", 0);
			act.set("UPDATE_TIME", new Date());
			act.set("UPDATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
			rsFlag = act.update();
			rsMsg = "保存成功";
		}
		if("2".equals(type)){ //发布
			act.set("STATUS", 1);
			act.set("UPDATE_TIME", new Date());
			act.set("UPDATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
			rsFlag = act.update();
			rsMsg = "发布成功";
		}
		if("3".equals(type)){//新增
			act.set("STATUS", 0);
			act.set("CREATE_TIME", new Date());
			act.set("CREATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
			rsFlag = act.save();
			rsMsg = "保存成功";
		}
		if("4".equals(type)){
			act.set("STATUS", 1);
			act.set("CREATE_TIME", new Date());
			act.set("CREATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
			rsFlag = act.save();
			rsMsg = "发布成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
    }
	
	/**
	 * 活动新增页面
	 */
	public void add(){
		render("activity/activity_add.jsp");
	}
	
	/**
	 * 删除活动
	 */
	public void deleteAct(){
		boolean rsFlag = false;
		String rsMsg = "删除失败，请稍后再试";
		
		Integer actID = getParaToInt("actID");
		Activity act = Activity.dao.findById(actID);
		//发送邮件
		//查询活动下的所有报名用户
		Object[] obj = new Object[]{act.getTITLE()};
		List<ActUser> actUserList = ActUser.dao.find("SELECT a.* from t_act_user a where a.ACT_ID=?", act.getID());
		
		String subject = "[台球厅]取消活动说明";
//		StringBuffer theMessage = new StringBuffer();
//        theMessage.append("<p>您好</p>");
//        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
//        theMessage.append("<p>您报名参加的活动："+act.getTITLE()+"已取消，特此通知</p>");
//        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
//        theMessage.append("<p>此致<br></p>");
//        theMessage.append("<p>台球厅管理团队.http://www.baidu.com/</p>");
		
        for(int i=0;i<actUserList.size();i++){
        	if("".equals(actUserList.get(i).getEMAIL())){
        		//EmailUtil.send(subject, theMessage.toString(), actUserList.get(i).getEMAIL());
        		EmailUtil.sendCancleActEmail(subject, actUserList.get(i).getEMAIL(), obj);
        	}
        }
		
		rsFlag = Activity.dao.deleteById(actID);
		if(rsFlag){
			rsMsg = "删除成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * 隐藏活动
	 */
	public void hideAct(){
		boolean rsFlag = false;
		String rsMsg = "删除失败，请稍后再试";
		
		Integer actID = getParaToInt("actID");
		Activity act = Activity.dao.findById(actID);
		act.set("STATUS", 2);
		act.set("UPDATE_TIME", new Date());
		act.set("UPDATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
		rsFlag = act.update();
		if(rsFlag){
			rsMsg = "隐藏成功";
			//发送邮件
			//查询活动下的所有报名用户
			Object[] obj = new Object[]{act.getTITLE()};
			List<ActUser> actUserList = ActUser.dao.find("SELECT a.* from t_act_user a where a.ACT_ID=?", act.getID());
			
			String subject = "[台球厅]取消活动说明";
//			StringBuffer theMessage = new StringBuffer();
//	        theMessage.append("<p>您好</p>");
//	        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
//	        theMessage.append("<p>您报名参加的活动："+act.getTITLE()+"已取消，特此通知</p>");
//	        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
//	        theMessage.append("<p>此致<br></p>");
//	        theMessage.append("<p>台球厅管理团队.http://www.baidu.com/</p>");
			
	        for(int i=0;i<actUserList.size();i++){
	        	if(!"".equals(actUserList.get(i).getEMAIL())){
	        		EmailUtil.sendCancleActEmail(subject, actUserList.get(i).getEMAIL(), obj);
	        		//EmailUtil.send(subject, theMessage.toString(), actUserList.get(i).getEMAIL());
	        	}
	        }
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * 重新发布活动
	 */
	public void reReleaseAct(){
		boolean rsFlag = false;
		String rsMsg = "删除失败，请稍后再试";
		
		Integer actID = getParaToInt("actID");
		Activity act = Activity.dao.findById(actID);
		act.set("STATUS", 1);
		act.set("UPDATE_TIME", new Date());
		act.set("UPDATE_USER_ID", BackSessionUtil.getUserId(getRequest()));
		rsFlag = act.update();
		if(rsFlag){
			rsMsg = "隐藏成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
	
	/**
	 * 查看活动
	 */
	public void viewAct(){
		String type = getPara("type");
		Activity act = Activity.dao.findById(type);
		List<ActUser> userList = ActUser.dao.getUserByActId(getParaToInt("type"));
		setAttr("act", act);
		setAttr("userList", userList);
		render("activity/activity_view.jsp");
	}
	
	/**
	 * 搜索参加活动人员
	 */
	public void getActUser(){
		String userName = getPara("userName");
		int actID = getParaToInt("actID");
		int pageNum = getParaToInt("pageNum");
		
		Page<ActUser> page = ActUser.dao.findList(userName, actID, pageNum, pageSize);
		setAttr("paginate", page);
		render("activity/activity_view_result.jsp");
	}
	
	/**
	 * 取消报名
	 */
	public void cancleUser(){
		boolean rsFlag = false;
		boolean sendFlag = false;
		String rsMsg = "删除失败，请稍后再试";
		
		Integer ID = getParaToInt("userID");
		ActUser actUser = ActUser.dao.findById(ID);
		Activity act = Activity.dao.findById(actUser.getActId());
		//发送邮件
		String subject = "[台球厅]取消报名说明";
		StringBuffer theMessage = new StringBuffer();
        theMessage.append("<p>"+actUser.getNAME()+"，您好</p>");
        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
        theMessage.append("<p>您报名参加的活动："+act.getTITLE()+"，管理员已将您取消报名资格，特此通知</p>");
        theMessage.append("<p>----------------------------------------------------------------------<br></p>");
        theMessage.append("<p>此致<br></p>");
        theMessage.append("<p>台球厅管理团队.http://www.baidu.com/</p>");
		
		sendFlag = EmailUtil.send(subject, theMessage.toString(), actUser.getEMAIL());
				
		if(sendFlag){
			rsFlag = ActUser.dao.deleteById(ID);
		}else{
			rsMsg = "由于邮件未发送成功，不能取消用户参加";
		}
		if(rsFlag){
			rsMsg = "删除成功";
		}
		setAttr("rsFlag", rsFlag);
		setAttr("rsMsg", rsMsg);
		renderJson();
	}
}
