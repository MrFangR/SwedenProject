package com.partner.common.util;

import java.io.File;
import java.text.MessageFormat;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

import com.jfinal.ext.handler.ContextPathHandler;
import com.partner.common.base.BaseConfig;
import com.partner.common.constant.Constants;
import com.sun.corba.se.impl.orbutil.closure.Constant;

import org.apache.log4j.Logger;
import org.dom4j.*;
import org.dom4j.io.SAXReader;

public class EmailUtil {
	private static Logger logger = Logger.getLogger(EmailUtil.class);
	
	/**
	  * 给单一人发送邮件
	  * 
	  * @param smtp
	  *   SMTP服务器
	  * @param user
	  *   用户名
	  * @param password
	  *   密码
	  * @param subject
	  *   标题
	  * @param content
	  *   邮件内容
	  * @param from
	  *   发件人邮箱
	  * @param to
	  *   收件人邮箱
	  */
	public static boolean send(String subject, String content, String to) {
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", Constants.STMP);
			props.put("mail.smtp.auth", "true");
			Session ssn = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
				}
			});
			MimeMessage message = new MimeMessage(ssn);
			//由邮件会话新建一个消息对象 
			InternetAddress fromAddress = new InternetAddress(Constants.EMAIL_USER);
			//发件人的邮件地址 
			message.setFrom(fromAddress);
			//设置发件人 
			InternetAddress toAddress = new InternetAddress(to);
			//收件人的邮件地址 
			message.addRecipient(Message.RecipientType.TO, toAddress);
			//设置标题
			message.setSubject(subject, "gb2312");
			//设置标题
			message.setContent(content, "text/html;charset=gb2312");
			//设置内容
			message.setSentDate(new Date());
			//设置发信时间 
			Transport transport = ssn.getTransport("smtp");
			transport.connect(Constants.STMP, Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			// transport.send(message);
			transport.close();
			logger.info("邮件发送成功");
			return true;
		} catch (Exception e) {
			logger.warn("邮件发送失败", e);
			return false;
		}
	}
	
	/**
	  * 给多人发送邮件
	  * 
	  * @param smtp
	  *   SMTP服务器
	  * @param user
	  *   用户名
	  * @param password
	  *   密码
	  * @param subject
	  *   标题
	  * @param content
	  *   邮件内容
	  * @param from
	  *   发件人邮箱
	  * @param tos
	  *   收件人邮箱
	  */
	public static boolean sendMore(String subject, String content, String[] tos) {
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", Constants.STMP);
			props.put("mail.smtp.auth", "true");
			Session ssn = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
				}
			});
			MimeMessage message = new MimeMessage(ssn);
			//由邮件会话新建一个消息对象 
			InternetAddress fromAddress = new InternetAddress(Constants.EMAIL_USER);
			//发件人的邮件地址 
			message.setFrom(fromAddress);
			//设置发件人组
			
			//多个收件人的邮件地址
			InternetAddress[] toall = new InternetAddress[tos.length];
			InternetAddress toAddress = new InternetAddress();
			for(int i=0;i<tos.length;i++){
				toAddress = new InternetAddress(tos[i]);
				toall[i] = toAddress;
			}
			message.addRecipients(Message.RecipientType.TO, toall);
			//设置标题
			message.setSubject(subject, "gb2312");
			//设置标题
			message.setContent(content, "text/html;charset=gb2312");
			//设置内容
			message.setSentDate(new Date());
			//设置发信时间 
			Transport transport = ssn.getTransport("smtp");
			transport.connect(Constants.STMP, Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			// transport.send(message);
			transport.close();
			logger.info("邮件发送成功");
			return true;
		} catch (Exception e) {
			logger.warn("邮件发送失败", e);
			return false;
		}
	}
	
	/**
	  * 发送取消活动邮件
	  * 
	  * @param subject
	  *   标题
	  * @param content
	  *   邮件内容
	  * @param from
	  *   发件人邮箱
	  * @param to
	  *   收件人邮箱
	  */
	public static boolean sendCancleActEmail(String subject, String to, Object[] obj) {
		String filePath = "C:/apache-tomcat-7.0.55/webapps/klubb/email/cancleActivity.xml"; 
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", Constants.STMP);
			props.put("mail.smtp.auth", "true");
			Session ssn = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
				}
			});
			MimeMessage message = new MimeMessage(ssn);
			//由邮件会话新建一个消息对象 
			InternetAddress fromAddress = new InternetAddress(Constants.EMAIL_USER);
			//发件人的邮件地址 
			message.setFrom(fromAddress);
			//设置发件人 
			InternetAddress toAddress = new InternetAddress(to);
			//收件人的邮件地址 
			message.addRecipient(Message.RecipientType.TO, toAddress);
			//设置标题
			message.setSubject(subject, "gb2312");
			// 采用XML模板，可以让邮件带有HTML的格式
            String str = new ReaderXML().read(filePath); 
            //Object[] obj = new Object[] { "zhangsan", "123456", "x" };// X为任意标识  
            // MessageFormat 格式化字符串  
            str = MessageFormat.format(str, obj);
            //设置内容
			message.setContent(str, "text/html;charset=gb2312");
			//设置时间
			message.setSentDate(new Date());
			//发送 
			Transport transport = ssn.getTransport("smtp");
			transport.connect(Constants.STMP, Constants.EMAIL_USER, Constants.EMAIL_PASSWORD);
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			// transport.send(message);
			transport.close();
			logger.info("邮件发送成功");
			return true;
		} catch (Exception e) {
			logger.warn("邮件发送失败", e);
			return false;
		}
	}
	
	
	/** 
     * 读取XML的类 
     * @author：Ellrien 
     * @date: 2013-10-10 上午11:07:22 
     */  
	public static class ReaderXML {  
        public String read(String path) {  
            String str = null;  
            str = reader(path);  
            return str;  
        }  
  
        private String reader(String path) {  
            SAXReader reader = new SAXReader();  
            String str = null;  
            try {  
                Document d = reader.read(new File(path));  
                Element e = d.getRootElement();  
                Element htmle = e.element("html");  
                str = htmle.asXML();  
            } catch (DocumentException e) {  
                e.printStackTrace();  
            }  
            return str;  
        }  
  
    }  
}
