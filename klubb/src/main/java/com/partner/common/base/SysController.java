/**
 * 
 */
package com.partner.common.base;

import com.jfinal.core.Controller;
import com.jfinal.log.Log;

/**
 * @author fangrui desc 系统公用控制器
 */
public class SysController extends Controller {

	private static Log log = Log.getLog(SysController.class);
	// 生成随机码
	public void randCodeImage() {
		this.renderCaptcha();
	}
}
