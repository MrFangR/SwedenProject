package com.partner.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * �ַ�������ͨ����
 * 
 * @author sunjun
 * @version v5.0
 */
public class StringUtil {

 // �ַ�������ö��
 public static enum REGEX_ENUM {
  EMAIL("^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"), CHINESE_CHARACTER(
    "[\\u4E00-\\u9FA5]+");
  private String value;

  private REGEX_ENUM(String value) {
   this.value = value;
  }

  public String toString() {
   return this.value;
  }
 };

 /**
  * ����ַ���str�Ƿ�ƥ��������ʽregex
  * 
  * @param regex
  * @param str
  * @return
  */
 public static boolean matcherRegex(String regex, String str) {
  Pattern pattern = Pattern.compile(regex);
  Matcher matcher = pattern.matcher(str);
  return matcher.matches();
 }

 /**
  * �Ƿ�Ϊ����
  * 
  * @param ch
  * @return
  */
 public static boolean isChineseCharacter(char ch) {
  return matcherRegex(REGEX_ENUM.CHINESE_CHARACTER.toString(), String
    .valueOf(ch));
 }

 /**
  * ���ֽڽ�ȡ�ַ���
  * 
  * @param str
  *            Ҫ��ȡ���ַ���
  * @param byteLength
  *            ����
  * @return ����ַ���
  */
 public static String subString(String str, int byteLength) {
  if (isBlank(str))
   return "";
  if (str.getBytes().length <= byteLength)
   return str;
  if (str.length() >= byteLength)
   str = str.substring(0, byteLength);
  int readLen = 0;
  String c = null;
  StringBuffer sb = new StringBuffer("");
  for (int i = 0; i < str.length(); i++) {
   c = String.valueOf(str.charAt(i));
   readLen += c.getBytes().length;
   if (readLen > byteLength)
    return sb.toString();
   sb.append(c);
  }
  return sb.toString();
 }

 /**
  * ����ַ��������Ƿ���ָ�����ȷ�Χ��(minLength<=str.length<=maxLength)
  * 
  * @param str
  *            Ҫ�����ַ���
  * @param minLength
  *            ��С����
  * @param maxLength
  *            ��󳤶�
  * @return boolean �ַ���������ָ�����ȷ�Χ�ڷ���true�����򷵻�false
  */
 public static boolean checkLength(String str, int minLength, int maxLength) {
  if (isBlank(str))
   return false;
  int len = str.length();
  if (minLength == 0)
   return len <= maxLength;
  else if (maxLength == 0)
   return len >= minLength;
  else
   return (len >= minLength && len <= maxLength);
 }

 /**
  * ��UTF-8�����������ַ���
  * 
  * @param str
  *            Ҫ������ַ���
  * @return String ����str���ַ���
  */
 public static String decodeString(String str) {
  return decodeString(str, "UTF-8");
 }

 /**
  * ��ָ�������������ַ���
  * 
  * @param str
  * @param encoding
  * @return
  */
 public static String decodeString(String str, String encoding) {
  if (isBlank(str))
   return "";
  try {
   return URLDecoder.decode(str.trim(), encoding);
  } catch (UnsupportedEncodingException e) {
  }
  return "";
 }

 /**
  * ��ָ�������������ַ���
  * 
  * @param str
  * @param encoding
  * @return
  */
 public static String decodeURI(String str) {
  if (isBlank(str))
   return "";
  try {
   return new String(str.getBytes("ISO8859-1"), "UTF-8");
  } catch (UnsupportedEncodingException e) {
  }
  return "";
 }

 /**
  * ��UTF-8�����������ַ���
  * 
  * @param str
  *            Ҫ������ַ���
  * @return String ����str���ַ���
  */
 public static String encodeString(String str) {
  return encodeString(str, "UTF-8");
 }

 /**
  * ��UTF-8�����������ַ���
  * 
  * @param str
  *            Ҫ������ַ���
  * @return String ����str���ַ���
  */
 public static String encodeString(String str, String encoding) {
  if (isBlank(str))
   return "";
  try {
   return URLEncoder.encode(str.trim(), encoding);
  } catch (UnsupportedEncodingException e) {
  }
  return "";
 }

 /**
  * ����ʱ��õ�Ψһ�ַ���
  * 
  * @return
  */
 public static String getOnlyString() {
  return String.valueOf(System.currentTimeMillis());
 }

 /**
  * ������obj�Ƿ�Ϊ��
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ�շ���true�����򷵻�false
  */
 public static boolean isBlank(Object obj) {
  if (obj == null)
   return true;
  if (obj instanceof String && obj.toString().trim().length() == 0)
   return true;
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊ����
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ���ͷ���true�����򷵻�false
  */
 public static boolean isInteger(String str) {
  if (isBlank(str))
   return false;
  try {
   Integer.parseInt(str.trim());
   return true;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊ������
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ�����ͷ���true�����򷵻�false
  */
 public static boolean isLong(String str) {
  if (isBlank(str))
   return false;
  try {
   Long.parseLong(str.trim());
   return true;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊ������
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ�����ͷ���true�����򷵻�false
  */
 public static boolean isBoolean(String str) {
  if (isBlank(str))
   return false;
  try {
   Boolean.parseBoolean(str.trim());
   return true;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊdouble����
  * 
  * @param str
  * @return
  */
 public static boolean isDouble(String str) {
  if (isBlank(str))
   return false;
  try {
   Double.parseDouble(str.trim());
   return true;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊʱ����
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪʱ���ͷ���true�����򷵻�false
  */
 public static boolean isDate(String str) {
  if (isBlank(str))
   return false;
  try {
   java.sql.Date sqlDate = java.sql.Date.valueOf(str.trim());
   return true;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ����������strings��ÿ��Ԫ���Ƿ�Ϊ��
  * 
  * @param objs
  *            Ҫ���Ķ�������
  * @return boolean objs����Ԫ��Ϊ�շ���true�����򷵻�false
  */
 public static boolean isBlanks(Object... objs) {
  for (Object obj : objs) {
   if (StringUtil.isBlank(obj))
    return true;
  }
  return false;
 }

 /**
  * ����ַ�������str�Ƿ�Ϊ����������
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ���������鷵��true�����򷵻�false
  */
 public static boolean isLongs(String str[]) {
  for (int i = 0; i < str.length; i++) {
   if (!isLong(str[i]))
    return false;
  }
  return true;
 }

 /**
  * ����ַ�������str�Ƿ�Ϊ��������
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ�������鷵��true�����򷵻�false
  */
 public static boolean isIntegers(String str[]) {
  for (int i = 0; i < str.length; i++)
   if (!isInteger(str[i]))
    return false;
  return true;
 }

 /**
  * ����ַ�������str�Ƿ�Ϊ����������
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return boolean strΪ���������鷵��true�����򷵻�false
  */
 public static boolean isBooleans(String str[]) {
  for (int i = 0; i < str.length; i++)
   if (!isBoolean(str[i]))
    return false;
  return true;
 }

 /**
  * ����ַ���str�Ƿ�Ϊʱ��
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return strΪʱ���ͷ���true�����򷵻�false
  */
 public static boolean isTimestamp(String str) {
  if (isBlank(str))
   return false;
  try {
   java.sql.Date d = java.sql.Date.valueOf(str.trim());
   return true;
  } catch (Exception ex) {
  }
  return false;
 }

 /**
  * ����ַ���str�Ƿ�Ϊ(yyyy-MM-dd HH:mm:ss)ģʽ��ʱ��
  * 
  * @param str
  *            Ҫ�����ַ���
  * @return strΪʱ���ͷ���true�����򷵻�false
  */
 public static boolean isFullTimestamp(String str) {
  if (isBlank(str))
   return false;
  try {
   SimpleDateFormat format = new SimpleDateFormat(
     "yyyy-MM-dd HH:mm:ss");
   Date date = format.parse(str.trim());
   return date != null;
  } catch (Exception e) {
  }
  return false;
 }

 /**
  * ���ַ�����ת��Ϊ����������
  * 
  * @param str
  *            �ַ�����
  * @return Long[] ����������
  */
 public static Long[] stringsToLongs(String str[]) {
  Long lon[] = new Long[str.length];
  for (int i = 0; i < lon.length; i++)
   lon[i] = new Long(str[i]);
  return lon;
 }

 /**
  * ���ַ�����ת��Ϊ��������
  * 
  * @param str
  *            �ַ�����
  * @return Integer[] ��������
  */
 public static Integer[] stringsToIntegers(String str[]) {
  Integer array[] = new Integer[str.length];
  for (int i = 0; i < array.length; i++)
   array[i] = new Integer(str[i]);
  return array;
 }

 /**
  * ���ַ�����ת��Ϊ����������
  * 
  * @param str
  *            �ַ�����
  * @return Boolean[] ����������
  */
 public static Boolean[] stringsToBooleans(String str[]) {
  Boolean array[] = new Boolean[str.length];
  for (int i = 0; i < array.length; i++)
   array[i] = new Boolean(str[i]);
  return array;
 }
 
 /**
	 * 
	 * ��������:���������ַ�
	 * @param str
	 * @return true-�������ַ� false-û�������ַ�
	 */
	public static String stringFilter(String str) {
		if(str==null)
			return "";
		String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~��@#��%����&*��������+|{}������������������������]";   
		Pattern p=Pattern.compile(regEx);  
		Matcher m=p.matcher(str);      
		return  m.replaceAll("").trim();      
	}

 /**
  * ���ַ�����ת��Ϊ����������
  * 
  * @param str
  *            �ַ�����
  * @return double[] ����������
  */
 public static double[] stringsToDoubles(String str[]) {
  double array[] = new double[str.length];
  for (int i = 0; i < array.length; i++)
   array[i] = Double.parseDouble(str[i]);
  return array;
 }

 /**
  * ����ָ��ʱ��͸�ʽ�ַ����õ�ʱ���ʽ�ַ���
  * 
  * @param d
  *            ʱ��
  * @param pattern
  *            ��ʽ�ַ���
  * @return String ʱ���ʽ�ַ���
  */
 public static String formatDate(Date d, String pattern) {
  if (isBlank(d))
   return "";
  SimpleDateFormat format = new SimpleDateFormat(
    isBlank(pattern) ? "yyyy-MM-dd HH-mm-ss" : pattern);
  return format.format(d);
 }

 /**
  * ����ʱ���ַ����õ�ʱ��(yyyy-MM-dd)
  * 
  * @param str
  *            ʱ���ַ���
  * @return Timestamp ʱ��
  */
 public static Timestamp getTimestamp(String str) {
  try {
   Date d = java.sql.Date.valueOf(str.trim());
   return new Timestamp(d.getTime());
  } catch (Exception ex) {
  }
  return null;
 }

 /**
  * ����ʱ���ַ����õ�(yyyy-MM-dd HH-mm-ss)��ʽʱ��
  * 
  * @param str
  *            ʱ���ַ���
  * @return Timestamp ʱ��
  */
 public static Timestamp getFullTimestamp(String str) {
  try {
   SimpleDateFormat format = new SimpleDateFormat(
     "yyyy-MM-dd HH:mm:ss");
   Date date = format.parse(str.trim());
   return new Timestamp(date.getTime());
  } catch (Exception ex) {
  }
  return null;
 }

 /**
  * �õ����ָ�ʽ������ַ���
  * 
  * @param number
  *            Number����
  * @param minFractionDigits
  *            С����Сλ��
  * @param maxFractionDigits
  *            С�����λ��
  * @return String ��ʽ������ַ���
  */
 public static String formatNumber(Number number, int minFractionDigits,
   int maxFractionDigits) {
  NumberFormat format = NumberFormat.getInstance();
  format.setMinimumFractionDigits(minFractionDigits);
  format.setMaximumFractionDigits(maxFractionDigits);
  return format.format(number);
 }

 /**
  * �ַ�������<br>
  * ����˸���ǰ׺�������׺��Ҫ������ʾ���ַ��������ڴ���ʱ�����⣬���ݱ��㷨�ɽ��JS������ʾʱ��ͬ������
  * 
  * @param text
  *            ����
  * @param replaceStrs
  *            Ҫ������ʾ���ַ�������
  * @param beginStr
  *            ����ǰ׺����<font color=red>
  * @param endStr
  *            ������׺����</font>
  * @return
  */
 public static String heightLight(String text, String[] replaceStrs,
   String beginStr, String endStr) {
  if (text.length() == 0)
   return text;
  StringBuilder str = new StringBuilder();
  for (int i = 0; i < replaceStrs.length; i++) {
   String replaceStr = replaceStrs[i];
   int index = text.indexOf(replaceStr);
   if (index >= 0) {
    String afterStr = null;
    if (index > 0) {
     String beforeStr = text.substring(0, index);
     afterStr = text.substring(index + replaceStr.length());
     str.append(heightLight(beforeStr, replaceStrs, beginStr,
       endStr));
    } else
     afterStr = text.substring(replaceStr.length());
    str.append(beginStr).append(replaceStr).append(endStr);
    str
      .append(heightLight(afterStr, replaceStrs, beginStr,
        endStr));
    break;
   }
  }
  if (str.length() == 0)
   return text;
  return str.toString();
 }

 /**
  * �滻ָ�����ַ�������Ϊһ���ַ���<br>
  * �ٶȱ�String.replaceAll��3�����ң���apache-common StringUtils.replace��2������
  * 
  * @param text
  * @param replaceStrs
  * @param newStr
  * @return
  */
 public static String replaceAll(String text, String[] replaceStrs,
   String newStr) {
  if (text.length() == 0)
   return text;
  StringBuilder str = new StringBuilder();
  for (int i = 0; i < replaceStrs.length; i++) {
   String replaceStr = replaceStrs[i];
   int index = text.indexOf(replaceStr);
   if (index >= 0) {
    String afterStr = null;
    if (index > 0) {
     String beforeStr = text.substring(0, index);
     afterStr = text.substring(index + replaceStr.length());
     str.append(replaceAll(beforeStr, replaceStrs, newStr));
    } else
     afterStr = text.substring(replaceStr.length());
    str.append(newStr);
    str.append(replaceAll(afterStr, replaceStrs, newStr));
    break;
   }
  }
  if (str.length() == 0)
   return text;
  return str.toString();
 }

 /**
  * �滻ָ�����ַ���Ϊһ���ַ���<br>
  * �ٶȱ�String.replaceAll��3�����ң���apache-common StringUtils.replace��2������
  * 
  * @param text
  * @param replaceStr
  * @param newStr
  * @return
  */
 public static String replaceAll(String text, String replaceStr,
   String newStr) {
  if (text.length() == 0)
   return text;
  StringBuilder str = new StringBuilder();
  int index = text.indexOf(replaceStr);
  if (index >= 0) {
   String afterStr = null;
   if (index > 0) {
    String beforeStr = text.substring(0, index);
    afterStr = text.substring(index + replaceStr.length());
    str.append(replaceAll(beforeStr, replaceStr, newStr));
   } else
    afterStr = text.substring(replaceStr.length());
   str.append(newStr);
   str.append(replaceAll(afterStr, replaceStr, newStr));
  }
  if (str.length() == 0)
   return text;
  return str.toString();
 }

 /**
  * �滻ָ�����ַ�������Ϊһ���ַ�������<br>
  * �ٶȱ�String.replaceAll��3�����ң���apache-common StringUtils.replace��2������
  * 
  * @param text
  * @param replaceStrs
  * @param newStrs
  * @return
  */
 public static String replaceAllArray(String text, String[] replaceStrs,
   String[] newStrs) {
  if (text.length() == 0)
   return text;
  StringBuilder str = new StringBuilder();
  for (int i = 0; i < replaceStrs.length; i++) {
   String replaceStr = replaceStrs[i];
   int index = text.indexOf(replaceStr);
   if (index >= 0) {
    String afterStr = null;
    if (index > 0) {
     String beforeStr = text.substring(0, index);
     afterStr = text.substring(index + replaceStr.length());
     str
       .append(replaceAllArray(beforeStr, replaceStrs,
         newStrs));
    } else
     afterStr = text.substring(replaceStr.length());
    str.append(newStrs[i]);
    str.append(replaceAllArray(afterStr, replaceStrs, newStrs));
    break;
   }
  }
  if (str.length() == 0)
   return text;
  return str.toString();
 }

 /**
  * ����HTML(��&gt;,&lt;,&quot;,&amp;ת����>,<,",& )
  * 
  * @param html
  * @return
  */
 public static String decodeHTML(String html) {
  if (isBlank(html))
   return "";
  String[] replaceStr = { "&amp;", "&lt;", "&gt;", "&quot;" };
  String[] newStr = { "&", "<", ">", "\"" };
  return replaceAllArray(html, replaceStr, newStr);
 }

 /**
  * ����HTML(��>,<,",&
  * ת����&gt;,&lt;,&quot;,&amp;)(��Ч�ʣ�����FreeMarkerģ��Դ�룬��replaceAll�ٶȿ�ܶ�)
  * 
  * @param html
  * @return
  */
 public static String encodeHTML(String html) {
  if (isBlank(html))
   return "";
  int ln = html.length();
  char c;
  StringBuffer b;
  for (int i = 0; i < ln; i++) {
   c = html.charAt(i);
   if (c == '<' || c == '>' || c == '&' || c == '"') {
    b = new StringBuffer(html.substring(0, i));
    switch (c) {
    case '<':
     b.append("&lt;");
     break;
    case '>':
     b.append("&gt;");
     break;
    case '&':
     b.append("&amp;");
     break;
    case '"':
     b.append("&quot;");
     break;
    }
    i++;
    int next = i;
    while (i < ln) {
     c = html.charAt(i);
     if (c == '<' || c == '>' || c == '&' || c == '"') {
      b.append(html.substring(next, i));
      switch (c) {
      case '<':
       b.append("&lt;");
       break;
      case '>':
       b.append("&gt;");
       break;
      case '&':
       b.append("&amp;");
       break;
      case '"':
       b.append("&quot;");
       break;
      }
      next = i + 1;
     }
     i++;
    }
    if (next < ln)
     b.append(html.substring(next));
    html = b.toString();
    break;
   }
  }
  return html;
 }

 /**
  * MD5����
  * 
  * @param plainText
  *            Ҫ���ܵ��ַ���
  * @return ���ܺ���ַ���
  */
 public static String Md5(String plainText) {
  StringBuffer buf = new StringBuffer("");
  try {
   MessageDigest md = MessageDigest.getInstance("MD5");
   md.update(plainText.getBytes());
   byte b[] = md.digest();
   int i = 0;
   for (int offset = 0; offset < b.length; offset++) {
    i = b[offset];
    if (i < 0)
     i += 256;
    if (i < 16)
     buf.append("0");
    buf.append(Integer.toHexString(i));
   }
  } catch (Exception e) {
   e.printStackTrace();
  }
  return buf.toString();
 }

 /**
  * MD5����(32)
  * 
  * @param plainText
  *            Ҫ���ܵ��ַ���
  * @return
  */
 public final static String MD5(String plainText) {
  char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'a', 'b', 'c', 'd', 'e', 'f' };
  try {
   byte[] strTemp = plainText.getBytes();
   MessageDigest mdTemp = MessageDigest.getInstance("MD5");
   mdTemp.update(strTemp);
   byte[] md = mdTemp.digest();
   int j = md.length;
   char str[] = new char[j * 2];
   int k = 0;
   for (int i = 0; i < j; i++) {
    byte byte0 = md[i];
    str[k++] = hexDigits[byte0 >>> 4 & 0xf];
    str[k++] = hexDigits[byte0 & 0xf];
   }
   return new String(str);
  } catch (Exception e) {
  }
  return "";
 }

 	//���ɽӴ�id
	public static String getLoginAccept(){
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String dateStr=sf.format(new Date());
		return dateStr;
	}
}