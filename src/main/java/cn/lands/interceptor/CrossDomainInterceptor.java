/**
 * Copyright (c) 2015-2016,  Jason(522914767@qq.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package cn.lands.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * 
 * 
 * 跨域支持拦截器
 *
 * @author Jason
 * @version 1.0
 * @date 2016年10月29日
 */
public class CrossDomainInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		// 增加跨域支持响应头
		inv.getController().getResponse().addHeader("Access-Control-Allow-Origin", "*");
		inv.invoke();
	}

}
