<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：首页</div>
	<div class="index-wap">
		<ul>
     <li>
     	<i class="ico3"></i>
        <div class="text-x">今日访问量</div>	
        <div class="text-z"><span class="number">${todayNum }</span>次</div>	
         
     </li>
    
     <li class="last">
     	<i class="ico3"></i>
         <div class="text-x" style="color:#7aae87">累计访问量</div>	
        <div class="text-z"><span class="number">${hisNum }</span>次</div>	
     </li>
   </ul>
	</div>
	<!-- 
	
	<div class="index-wap">
		<ul>
			<li><i class="ico1"></i>
				<p class="tup1"></p>
				<div class="text-x">
					今日新增<span class="number">${shopCreate}</span>家
				</div>
				<div class="text-z">
					总商铺数<span class="number">${shopTotal}</span>家
				</div>
			</li>
			<li><i class="ico2"></i>
				<p class="tup2"></p>
				<div class="text-x">
					今日新增<span class="number">${projectCreate}</span>家
				</div>
				<div class="text-z">
					总项目数<span class="number">${projectTotal}</span>家
				</div>
			</li>
			<li class="last"><i class="ico3"></i>
				<p class="tup3"></p>
				<div class="text-x">
					今日新增<span class="number">${userCreate}</span>个
				</div>
				<div class="text-z">
					总用户数<span class="number">${userTotal}</span>个
				</div>
			</li>
		</ul>
	</div>

	<div class="index-wap2">
		<div class="index-left">
			<h2>
				<em>我的待办</em>
			</h2>
			<ul>
				<li>待审批商铺：
					<span class="mgr-30">待初审<a href="${ctx}/back/shop/init">${waitChkFirstShop}</a>条</span>
					<span>待终审<a href="${ctx}/back/shop/init">${waitChkLastShop}</a>条</span>
				</li>
				<li>待审批项目：
					<span class="mgr-30">待初审<a href="${ctx}/back/pro/init">${waitChkFirstProject}</a>条</span>
					<span>待终审<a href="${ctx}/back/pro/init">${waitChkLastProject}</a>条</span>
				</li>
				<li>快速发布申请：
					<span class="mgr-30">项目<a href="${ctx}/back/release/init">${projectApply}</a>条</span>
					<span>商铺<a href="${ctx}/back/release/init">${shopApply}</a>条</span>
				</li>
				<li>待回复留言：<span><a href="${ctx}/back/custMsg/init">${waitReply}</a>条</span></li>
			</ul>
		</div>
		<div class="index-right">
			<h2>
				<em>我的提醒</em>
			</h2>
			<ul>
				<li>置顶项目需求：<span><a href="${ctx}/back/pro/init">${projectTopApplyCount}</a></span>条</li>
				<li>全景图制作需求：<span><a href="${ctx}/back/shop/init">${shop3DApplyCount}</a></span>条</li>
			</ul>

		</div>
		<div class="clear"></div>
	</div>
	 -->
</body>

</html>
