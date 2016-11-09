/**
 * 
 */
package com.partner.common.base;

import java.util.HashMap;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.ext.render.CaptchaRender;
import com.partner.common.util.StringUtil;

/**
 * @author fangrui
 * desc 系统公用控制器
 */
public class SysController extends Controller {

	public static final String RANDOM_CODE_KEY = "systemRandomCode";  //验证码的cookie键
	
	//生成随机码
		public void randCodeImage(){
			//render(new CaptchaRender(RANDOM_CODE_KEY));
			render("123456");
		}
		//校验验证码
		public void checkRandCode(){
			Map<String,String> map = new HashMap<String,String>();
			String inputRandomCode = getPara("inputRandomCode");
			if(!StringUtil.isBlank(inputRandomCode)){
		        boolean loginSuccess = CaptchaRender.validate(this, inputRandomCode, SysController.RANDOM_CODE_KEY);
		        if(!loginSuccess){
		        	map.put("flag", "1");
		        	map.put("Msg", "验证码错误,请重新输入!");
		        }else{
		        	map.put("flag", "0");
		        	map.put("Msg", "验证成功!");
		        }
			}
			renderJson(map);
		}
}
