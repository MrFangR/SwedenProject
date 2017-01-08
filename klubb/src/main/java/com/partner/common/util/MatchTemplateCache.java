/**
 * 
 */
package com.partner.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.ehcache.CacheKit;
import com.partner.busi.model.MatchTemplate;
import com.partner.busi.model.MatchTemplate.GameTemplate;

import net.sf.json.JSONObject;

/** 
 * @ClassName: MatchTemplateCache 
 * @Description: 
 * @author zhanglei
 * @date 2016年12月29日 下午9:53:47  
 */
public class MatchTemplateCache {
	private static final String SINGLE_PATH = "match_templet/single";
	private static final String DOUBLE_PATH = "match_templet/double";
	public static final String SINGLE_CACHE_NAME = "singleMatchTempCache";
	public static final String DOUBLE_CACHE_NAME = "doubleMatchTempCache";
	
	public static void init(){
		initCache(SINGLE_PATH, SINGLE_CACHE_NAME);
		initCache(DOUBLE_PATH, DOUBLE_CACHE_NAME);
	}
	
	public static void initCache(String path, String cacheName){
		URL url = MatchTemplateCache.class.getClassLoader().getResource(path);
		File file = new File(url.getFile());
		File[] tempList = file.listFiles();
		for (int i = 0; i < tempList.length; i++) {
			if (tempList[i].isFile()) {
				System.out.println("文     件：" + tempList[i]);
				String cacheKey = tempList[i].getName().substring(0, tempList[i].getName().indexOf("."));
				System.out.println(cacheKey);
				FileReader fileread;
				BufferedReader bufread;
				String line = null;
				StringBuilder sb = new StringBuilder();
				try {
					fileread = new FileReader(tempList[i]);
					bufread = new BufferedReader(fileread);
					while ((line = bufread.readLine()) != null) {
						sb.append(line);
					}
					CacheKit.put(cacheName, cacheKey, sb.toString());
					System.out.println(sb.toString());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}
	}
	
	public static List<GameTemplate> getGameList(String cacheName, int userSum){
		String jsonStr = CacheKit.get(cacheName, String.valueOf(userSum));
		JSONObject obj = JSONObject.fromObject(jsonStr);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("gameList", GameTemplate.class);
		MatchTemplate tmp = (MatchTemplate) JSONObject.toBean(obj, MatchTemplate.class, map);
		return tmp.getGameList();
	}

}
