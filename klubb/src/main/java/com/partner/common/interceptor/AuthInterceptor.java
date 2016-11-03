/**
 * 
 */
package com.partner.common.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * @author fangrui
 *
 */
public class AuthInterceptor implements Interceptor {

	public void intercept(Invocation inv) {
		// TODO Auto-generated method stub
		inv.invoke();
	}

}
