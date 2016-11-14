package com.partner.common.util;

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
import com.partner.common.constant.Constants;

import org.apache.log4j.Logger;

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
}
