/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.jfinal.json.JFinalJson;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.User;
import com.partner.common.base.ResultInfo;
import com.partner.common.constant.Constants;
import com.partner.common.util.StringUtil;

/**
 * @author fangrui
 * desc  后台用户管理
 *
 */
public class BackUserController extends Controller {

	public void index(){
		render("user_list.jsp");
	}
	/**
	 * 展示注册用户 t_user表记录
	 */
	public void getUserPage(){
		String pageNumber = this.getPara("pageNum");
		String pageSize = this.getPara("pageSize");
		int pageNumberInt = Constants.PAGENUMBER;
		int pageSizeInt = Constants.PAGESIZE;
		if(!StringUtil.isBlank(pageNumber)){
			pageNumberInt = Integer.parseInt(pageNumber);
		}		
		if(!StringUtil.isBlank(pageSize)){
			pageSizeInt = Integer.parseInt(pageSize);
		}
		
		String title = this.getPara("title");
		
		Page<User> userLst = User.dao.findUserLst(pageNumberInt, pageSizeInt, title);
		setAttr("paginate", userLst);
		render("user_list_result.jsp");
	}
	
	public void viewUser(){
		Integer userId = getParaToInt("userId");
		User user = User.dao.findById(userId);
		setAttr("user",user);
		render("userDetail.jsp");
	}
	
	public void delUser(){
		Integer userId = getParaToInt("userId");
		boolean flag = User.dao.deleteById(userId);
		ResultInfo retInfo = new ResultInfo();
		if(flag){
			retInfo.setRetCode(0);
			retInfo.setRetMsg("删除成功");
		}else{
			retInfo.setRetCode(1);
			retInfo.setRetMsg("删除失败");
		}
		renderJson(retInfo);
	}
	
	public void addUser(){
		String name = getPara("user_name");
		User user = new User();
		user.setNAME(name);
		user.setSTATUS(0);
		user.save();
		ResultInfo retInfo = new ResultInfo();
		retInfo.setRetCode(0);
		retInfo.setRetMsg("添加成功");
		renderJson(retInfo);
	}
}
