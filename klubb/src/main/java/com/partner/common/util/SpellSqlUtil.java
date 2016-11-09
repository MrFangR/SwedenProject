package com.partner.common.util;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * 拼sql常用的一些语句 Tools
 * @author YangKai
 */
public class SpellSqlUtil {
	/**
	 * 拼单语句
	 * @param type -and/or/like
	 * @param columnName 列名
	 * @param value 值，可为?
	 * @return type columnName=value
	 */
	public static String spell(String type, String columnName, String relax, Object value){
		if (StringUtils.isBlank(type) || StringUtils.isBlank(columnName) || StringUtils.isBlank(relax)) {
			return "";
		} else if (relax.equalsIgnoreCase("like")) {
			return " " + type + " " + columnName + " like " + value;
		}
		return " " + type + " " + columnName + relax + value;
	}
	
	/**
	 * 拼 and 语句
	 * @param columnName
	 * @return and comumnName=?
	 */
	public static String spellAndEqual(String columnName){
		return spell("and", columnName, "=", "?");
	}
	/**
	 * 拼 and 语句
	 * @param columnName
	 * @param value
	 * @return and columnName=value
	 */
	public static String spellAndEqual(String columnName, Object value){
		return spell("and", columnName, "=", value);
	}
	
	/**
	 * 拼 or 语句
	 * @param columnName
	 * @return or columnName=?
	 */
	public static String spellOrEqual(String columnName){
		return spell("or", columnName, "=", "?");
	}
	/**
	 * 拼 or 语句
	 * @param columnName
	 * @param value
	 * @return or columnName=value
	 */
	public static String spellOrEqual(String columnName, Object value){
		return spell("or", columnName, "=", value);
	}
	
	/**
	 * 拼 between and 语句
	 * @param low 最小值int
	 * @param high 最大值int
	 * @param columnName
	 * @return and(columnName between low and high)
	 */
	public static String spellBetweenAnd(int low, int high, String columnName){
		if (StringUtils.isBlank(columnName)) {
			return "";
		}
		return " and(" + columnName + " between " + low + " and " + high + ")";
	}
	
	/**
	 * 拼 between and 语句
	 * @param low 最小值 date
	 * @param high 最大值 date
	 * @param columnName
	 * @return and(columnName between low and high)
	 */
	public static String spellBetweenAnd(Date low, Date high, String columnName){
		if (StringUtils.isBlank(columnName)) {
			return "";
		}
		return " and(" + columnName + " between " + low + " and " + high + ")";
	}
	
	/**
	 * 拼 like 语句
	 * @param columnName
	 * @return and columnName like ?
	 */
	public static String spellAndLike(String columnName){
		return spell("and", columnName, "like", "?");
	}
	/**
	 * 拼 like 语句
	 * @param columnName
	 * @param value
	 * @return and columnName like '%value%'
	 */
	public static String spellAndLike(String columnName, Object value){
		return spell("and", columnName, "like", "'%"+value+"%'");
	}
}
