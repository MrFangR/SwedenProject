/**
 * 
 */
package com.partner.common.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import com.jfinal.i18n.I18n;

/** 
 * @ClassName: I18nTag 
 * @Description: 
 * @author zhanglei
 * @date 2016年11月4日 下午2:05:05  
 */
public class I18nTag extends TagSupport {
	private static final long serialVersionUID = -612009859612009389L;
	
	public static String locale;
	private String key;

	@Override
	public int doStartTag() throws JspException {
		if(StringUtils.isNotEmpty(key)){
			try {
				pageContext.getOut().write(I18n.use(locale).get(key));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return super.doStartTag();
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
}
