package com.partner.busi.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Page;
import com.partner.busi.model.base.BasePicture;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Picture extends BasePicture<Picture> {
	public static final Picture dao = new Picture();
	
	public List<Picture> findAll(){
		return dao.find("select ID, URL, DESCRIPTION, USER_ID from t_picture order by CREATE_TIME desc ");
	}
	
	public List<Picture> findRecommendPic(){
		return dao.find("select ID, URL, DESCRIPTION, USER_ID from t_picture where IS_RECOMMEND = 1 order by CREATE_TIME desc ");
	}
	
	public Page<Picture> findPic(String title, int pageNum, int pageSize) {
		String select = "select * ";
		StringBuilder sql = new StringBuilder(" from t_picture a where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if (StringUtils.isNotBlank(title)) {
			sql.append(" and a.DESCRIPTION like ? ");
			params.add("%" + title + "%");
		}
		sql.append(" order by a.CREATE_TIME desc");
		return paginate(pageNum, pageSize, select, sql.toString(), params.toArray());
	}

	public Picture findPrevPic(String picID) {
		return dao.findFirst("select * from t_picture where id<? order by id desc limit 0,1;",picID);
	}

	public Picture findNextPic(String picID) {
		return dao.findFirst("select * from t_picture where id>? order by id asc limit 0,1",picID);
	}

	public Page<Picture> findUserPic(Integer id, int pageNum, int pageSize) {
		Page<Picture> page = paginate(pageNum, pageSize, "select * ", " from t_picture p where p.USER_ID=? order by p.CREATE_TIME desc",id);
		return page;
	}

	public void setNICKNAME(String nickName) {
		set("NICKNAME", nickName);
	}
	
	public String getNICKNAME() {
		return get("NICKNAME");
	}
}
