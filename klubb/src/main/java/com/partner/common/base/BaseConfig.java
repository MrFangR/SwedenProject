/**
 * 
 */
package com.partner.common.base;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;
import com.partner.busi.back.controller.BackLoginController;
import com.partner.busi.back.controller.BackMainController;
import com.partner.busi.front.controller.IndexController;
import com.partner.busi.model._MappingKit;
import com.partner.common.plugin.PropertiesPlugin;
import com.partner.common.tag.I18nTag;

/**
 * @author issuser
 * 
 */
public class BaseConfig extends JFinalConfig {

	@SuppressWarnings("unused")
	private Routes routes;
	private boolean isDev = false;

	@Override
	public void configConstant(Constants me) {
		// TODO Auto-generated method stub
		new PropertiesPlugin(loadPropertyFile("config.properties")).start();
		isDev = getPropertyToBoolean("devMode", false);
		me.setViewType(ViewType.JSP);
		me.setBaseViewPath("WEB-INF/view/");
		I18nTag.locale = "en_US";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.jfinal.config.JFinalConfig#configRoute(com.jfinal.config.Routes)
	 */
	@Override
	public void configRoute(Routes me) {
		// TODO Auto-generated method stub
		this.routes = me;
		me.add("/", IndexController.class);
		me.add("/sys", SysController.class);
		me.add("/back", BackLoginController.class, "/back");
		me.add("/back/main",BackMainController.class,"/back");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.jfinal.config.JFinalConfig#configPlugin(com.jfinal.config.Plugins)
	 */
	@Override
	public void configPlugin(Plugins me) {
		// TODO Auto-generated method stub
		DruidPlugin druid = new DruidPlugin(getProperty("jdbcUrl"),
				getProperty("user"), getProperty("password").trim());
		druid.setInitialSize(1);
		druid.setMaxActive(5);
		druid.setMinIdle(1);
		druid.setMaxWait(60000);
		druid.setFilters("stat");
		me.add(druid);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druid);
		me.add(arp);
		//arp.addMapping("c_user", User.class);
		// 所有配置在 MappingKit 中搞定
		_MappingKit.mapping(arp);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.jfinal.config.JFinalConfig#configInterceptor(com.jfinal.config.
	 * Interceptors)
	 */
	@Override
	public void configInterceptor(Interceptors me) {
		// TODO Auto-generated method stub
		//me.add(new AuthInterceptor());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.jfinal.config.JFinalConfig#configHandler(com.jfinal.config.Handlers)
	 */
	@Override
	public void configHandler(Handlers me) {
		// TODO Auto-generated method stub
		me.add(new ContextPathHandler());
	}

}
