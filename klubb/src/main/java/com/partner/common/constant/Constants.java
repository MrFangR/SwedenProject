package com.partner.common.constant;

import com.jfinal.kit.PropKit;

/** 
 *
 * @ClassName: Constants 
 * @author Nemo
 * @date 2016年11月7日 下午11:07:13  
 */

public class Constants {
	
	/**
	 * 后台session中user的key
	 */
	public static final String BACK_SESSION_USER = "BACK_SESSION_USER";
	public static final String FRONT_SESSION_USER = "FRONT_SESSION_USER";
	
	public static final int  FLAG_SUCCESS = 0;             //操作成功标志
    public static final int  FLAG_FAIL = 1;				   //操作失败标志
    
    public static final int  PAGENUMBER = 1;             //默认页码
    public static final int  PAGESIZE = 5;				   //每页展示数量
    
    /**
     * 邮件服务器
     * 
     */
    public static final String  STMP = PropKit.use("config.properties").get("smtp");
    public static final String  EMAIL_USER = PropKit.use("config.properties").get("email_user");
    public static final String  EMAIL_PASSWORD = PropKit.use("config.properties").get("email_password");
    
    public static final String UPLOAD_SERVER_URL = PropKit.use("config.properties").get("uploadServerUrl");  //上传文件url

}
