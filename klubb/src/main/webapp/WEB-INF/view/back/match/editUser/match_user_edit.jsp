<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：<a href="#none">比赛列表</a>&nbsp;&gt;&nbsp;编辑参与者</div></div>
	
	<div class="ued-tab js_tab">
	    <div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 fl clearfix">
                <li class="liQuery"><a class="ued-see" href="javascript:void(0)">编辑参与者</a></li>
                <li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑对阵图</a></li>
                
            </ul>
	    </div>
	    <div class="ued-tab-con mgt-20">
	    	<div class="box-n">
                    <div id='single1' class='container'>
                    	<c:forEach var="user" items="${matchUser }">
                    		<div>${user.name } <i class="mtch_del"></i></div>
                    	</c:forEach>
                    	<!-- 
                        <div>1, but you can only drop me somewhere in this container. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>2If you try to drop me somewhere other than here, I'll die a fiery death. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 3. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 4. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 5. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 6. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                    	 -->
                   </div>

                  <div class="tc" style="width:60%; margin-top:30px;"><button class="ued-button-2 js_dialog">添加人员</button></div>
             </div>
	    </div>
	</div>
</body>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backActivity.js"></script>
</html>
