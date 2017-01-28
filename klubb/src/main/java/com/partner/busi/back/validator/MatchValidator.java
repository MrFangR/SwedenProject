package com.partner.busi.back.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class MatchValidator extends Validator  {

	@Override
	protected void validate(Controller c) {
		// TODO Auto-generated method stub
		validateRequiredString("match.NAME", "name_msg", "请填写标题");
		validateDate("match.START_DATE", "start_time_msg", "请填写正确时间");
		validateInteger("match.MAX_PLAYER", 2, 99999, "max_player_msg", "请填写正确的人数");
		validateRequiredString("match.IMG", "img_path_msg", "请填加图片");
		validateString("match.DESCRIPTION", 1, 200, "description_msg", "请输入1~200描述内容");
		int type = c.getParaToInt("match.TYPE");
		if(type==2||type==4){
			validateInteger("match.STOP_PLAYER", 2, 99999, "stop_player_msg", "请填写正确的人数");
		}
	}

	@Override
	protected void handleError(Controller c) {
		// TODO Auto-generated method stub
		c.setAttr("rsFlag", false);
    	c.renderJson();
	}

}
