/*
 * myLoad(url, params, beforeFn, refreshId, afterFn, errorFn);
 * url 加载内容的请求地址;String
 * params 为提交时传递的参数,数据形式为ajax形式数据;"a=1&b=2&c=3"或者对象形式{}
 * refreshId 为要刷新的区域的id,或者选择器;'#bd'
 * beforeFn 加载之前要执行的事件;function
 * afterFn 加载完成后要执行的事件;function // 不用的话可以直接忽略不写
 * errorFn 加载失败要执行的事件;function // 不用的话可以直接忽略不写
 例如:
 myLoad(url, params, closeKeyboard,'#bd'); // 后面的两个方法用不到的话可以不写
 */
function myLoad(url, params, beforeFn, refreshId, afterFn, errorFn){
	$.ajax({
		type: "post",
		cache: false,
		url: url,
		data: params,
		success: function(data){
			if ($.isFunction(beforeFn)) {
				beforeFn.apply();
			}
			$(refreshId).html(data);
			try {
				initPage();//初始化页面元素
			} catch (e) {
			}
			if ($.isFunction(afterFn)) {
				afterFn.apply();
			}
		},
		error: function(){
			myAlert('对不起，网络故障，请您再试一次！');
			if ($.isFunction(errorFn)) {
				errorFn.apply();
			}
		}
	});
}