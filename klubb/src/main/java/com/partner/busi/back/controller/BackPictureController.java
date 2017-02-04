/**
 * 
 */
package com.partner.busi.back.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.Picture;

/**
 * 
* @ClassName: BackPictureController 
* @Description: 
* @author zhanglei
* @date 2016年11月14日 下午11:34:09
 */
public class BackPictureController extends Controller {
	
	private final static Integer pageSize = 12; //每页显示数量
	
	public void index(){
		render("happytimes_list.jsp");
	}
	
	/**
	 * 搜索
	 */
	public void list(){
		int pageNum = getParaToInt("pageNum");
		
		Page<Picture> page = Picture.dao.paginate(pageNum, pageSize, "select p.*, u.NICKNAME", " from t_picture p, t_user u where p.USER_ID = u.ID order by create_time desc");
		setAttr("paginate", page);
		render("happytimes_list_result.jsp");
	}
	
	/**
	 * 修改状态，是否推荐
	 */
	public void updateRecommend(){
		String picId = getPara("picId");
		String isRecommend = getPara("isRecommend");
		Picture picture = Picture.dao.findById(picId);
		int flag = 1;
		String msg = "标记失败，请稍后再试！";
		if(picture != null){
			picture.set("IS_RECOMMEND", isRecommend);
			boolean rs = picture.update();
			if(rs){
				flag = 0;
				msg = "标记成功";
				if("0".equals(isRecommend)){
					msg = "取消" + msg;
				}
			}
		}
		setAttr("flag", flag);
		setAttr("msg", msg);
		renderJson();
	}
	
	/**
	 * 删除违规图片
	 */
	public void delete(){
		String picId = getPara("picId");
		int flag = 1;
		String msg = "删除失败，请稍后再试！";
		boolean rs = Picture.dao.deleteById(picId);
		if(rs){
			flag = 0;
			msg = "删除成功";
		}
		setAttr("flag", flag);
		setAttr("msg", msg);
		renderJson();
	}
    
}
