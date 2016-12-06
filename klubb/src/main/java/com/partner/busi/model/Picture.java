package com.partner.busi.model;

import java.util.List;

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
	
	public Page<Picture> findPic(int pageNum, int pageSize) {
		Page<Picture> page = paginate(pageNum, pageSize, "select * ", " from t_picture p order by p.CREATE_TIME desc");
		return page;
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
}
