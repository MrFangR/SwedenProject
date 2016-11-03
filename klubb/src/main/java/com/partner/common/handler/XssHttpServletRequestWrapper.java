package com.partner.common.handler;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import com.jfinal.log.Log;

/**
 * XSS、SQL 过滤器
 * @author zhaohy
 *
 */
public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {
	private static Log logger = Log.getLog(XssHttpServletRequestWrapper.class);
	HttpServletRequest orgRequest = null;
	public XssHttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
		this.orgRequest = request;
	}
	/**
	 * 覆盖getParameter方法，将参数名和参数值都做xss过滤。<br/>
	 * 如果需要获得原始的值，则通过super.getParameterValues(name)来获取<br/>
	 * getParameterNames,getParameterValues和getParameterMap也可能需要覆盖
	 */
	@Override
	public String getParameter(String name) {
		String value = super.getParameter(xssEncode(name));
		if (value != null) {
			logger.debug("original="+value);
			value = xssEncode(value);
			logger.debug("result="+value);
		}
		return value;
	}
	@Override
	public String[] getParameterValues(String name) {
		 Object v = super.getParameterValues(xssEncode(name));
		  if(v==null){
		    return null;
		  }else if(v instanceof String[]){
			  String[]temp = (String[]) v;
			  for(int i = 0;i < temp.length;i++){
				logger.debug("original="+temp[i]);
				temp[i] = xssEncode(temp[i]);
				logger.debug("result="+temp[i]);
			  }
		    return temp;
		  }else if(v instanceof String){
			  logger.debug("original="+(String) v);
			  String temp = xssEncode((String) v);
			  logger.debug("result="+temp);
		    return new String[]{temp};
		  }else{
			  logger.debug("original="+v.toString());
			  String temp = xssEncode(v.toString());
			  logger.debug("result="+temp);
		    return new String[]{temp};
		  }
		}
	@Override
	public Enumeration getParameterNames() {
		Enumeration v = super.getParameterNames();
		Vector l=new Vector();
		while(v.hasMoreElements()){
			String temp = v.nextElement().toString();
			logger.debug("original="+temp);
			temp = xssEncode(temp);
			logger.debug("result="+temp);
			l.addElement(temp);
		}
	  return l.elements();
	}
	@Override
	public Map getParameterMap() {
		Map paramMap = new HashMap();
		Enumeration keys = this.getParameterNames();
		while(keys.hasMoreElements()){
			String key = keys.nextElement().toString();	
			String[] value = this.getParameterValues(key);
			paramMap.put(key, value);
		}
	  return paramMap;
	}
	
	/**
	 * 覆盖getHeader方法，将参数名和参数值都做xss过滤。<br/>
	 * 如果需要获得原始的值，则通过super.getHeaders(name)来获取<br/>
	 * getHeaderNames 也可能需要覆盖
	 */
	@Override
	public String getHeader(String name) {

		String value = super.getHeader(xssEncode(name));
		if (value != null) {
			logger.debug("original="+value);
			value = xssEncode(value);
			logger.debug("result="+value);
		}
		return value;
	}
	@Override
	public Enumeration getHeaders(String name) {

		Enumeration v = super.getHeaders(name);
		Vector l=new Vector();
		while(v.hasMoreElements()){
			String temp = v.nextElement().toString();	
			logger.debug("original="+temp);
			temp = xssEncode(temp);
			logger.debug("result="+temp);
			l.addElement(temp);
		}
	  return l.elements();
	}
	@Override
	public Enumeration getHeaderNames() {
		Enumeration v = super.getHeaderNames();
		Vector l=new Vector();
		while(v.hasMoreElements()){
			String temp = v.nextElement().toString();	
			logger.debug("original="+temp);
			temp = xssEncode(temp);
			logger.debug("result="+temp);
			l.addElement(temp);
		}
	  return l.elements();
	}
	/**
	 * 将容易引起xss漏洞的半角字符直接替换成全角字符
	 * 
	 * @param s
	 * @return
	 */
	private static String xssEncode(String s) {
		if (s == null || "".equals(s)) {
			return s;
		}
		//s = s.replaceAll("\\|", "");   
        s = s.replaceAll("&", "＆");   
        //s = s.replaceAll(";", "；");    //wabcasu的导出需要使用到分号
        s = s.replaceAll("#", "＃"); 
        //s = s.replaceAll("@", "＠");     
        s = s.replaceAll("'", "‘");     
        //s = s.replaceAll("\"", "＂");     
        s = s.replaceAll("\\'", "＇");     
        //s = s.replaceAll("\\\"", "＼");     
        s = s.replaceAll("<", "&lt;");     
        s = s.replaceAll(">", "&gt;");     
        s = s.replaceAll("\\(", "（");     
        s = s.replaceAll("\\)", "）");     
        s = s.replaceAll("\\+", "＋");     
        /*s = s.replaceAll("\r", "");     
        s = s.replaceAll("\n", ""); */   //文本域中的换行等。
        s = s.replaceAll("script", "");             
        s = s.replaceAll("%27", "");   
        s = s.replaceAll("%22", "");   
        s = s.replaceAll("%3E", "");   
        s = s.replaceAll("%3C", "");   
        s = s.replaceAll("%3D", "");   
        s = s.replaceAll("%2F", "");  
		return s;
	}
	

	/**
	 * 获取最原始的request
	 * 
	 * @return
	 */
	public HttpServletRequest getOrgRequest() {
		return orgRequest;
	}

	/**
	 * 获取最原始的request的静态方法
	 * 
	 * @return
	 */
	public static HttpServletRequest getOrgRequest(HttpServletRequest req) {
		if (req instanceof XssHttpServletRequestWrapper) {
			return ((XssHttpServletRequestWrapper) req).getOrgRequest();
		}

		return req;
	}
}