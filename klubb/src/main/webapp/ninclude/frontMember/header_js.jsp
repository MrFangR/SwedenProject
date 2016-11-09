<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link type="text/css"  href="${ctx}/front-ui/css/front-style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/ands-popAlert.css"/>
<link type="text/css"  href="${ctx}/css/qqtalk.css" rel="stylesheet"/>
<%@ include file="/ninclude/common_head.jsp"%>

<script  type="text/javascript" src="${ctx}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
if(!window.jST){
	document.write("<script type='text/javascript' language='javascript' src='${ctx}/js/jST.v0.1.4.min.js'><\/script>");
}
</script>
<script  type="text/javascript" src="${ctx}/front-ui/js/shop.js"></script>
<script  type="text/javascript" src="${ctx}/front-ui/js/login.js"></script>
<script  type="text/javascript" src="${ctx}/front-ui/js/quickRelease.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/My97DatePicker/WdatePicker.js"></script>
<script  type="text/javascript" src="${ctx}/front-ui/js/ands-popAlert.js"></script>

<script type="text/javascript">
 var ctx='${ctx}';
 $.ajaxSetup({
	 dataFilter: function(data, type) {
		 if(data.indexOf("LOGIN_FLAG") != -1){
			 var json = JSON.parse(data);
			 window.location = ctx+ "?toUrl=" + json.toUrl;
		 }else{
			 return data;
		 }
	 }
 })
</script>