<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>活的内容</title>
    <%@include file="/ninclude/back/header.jsp"%>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header >
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header >
<!--cont-con S-->		
  	<div class="cont-con">
    	<h1 class="contitle">${act.TITLE}</h1>
    	<p class="confutitle"><input name=""  class="contbtn" type="button" value="+参加活动"><span>时间：${act.actTime}</span><span class="mgl-200">地点：大南门**台球厅</span></p>
       		<p class="conline"></p>
       		<div class="cont-text">
       			${act.CONTENT}
        	</div>
	</div>
<!--cont-con E-->	
 
 <!--评论 S-->
	<div class="tabber">
        <div class="tab-item tab-comments">
            <i class="icon"></i>
            <h2 class="tab-title">评论</h2>
            <i class="arrow-d"></i>
		</div>
	</div>
 
 
	<div class="ct-dt-pl-main mgt-30 clearfix">
		<p class="tx-img fl"><img src="${ctx}/front-ui/images/ct_dt_pl_icon.png" alt=""></p>
		<div class="ct-dt-pl-right fl">
			<div class="ct-dt-pl-area">
				<textarea id="J_ctDtPlText" class="ct-dt-pl-textarea" name="context" rows="" cols="" maxlength="150" onfocus="if(this.value=='我来说两句...') {this.value='';}" onblur="if(this.value=='') {this.value='我来说两句...';}">我来说两句...</textarea>
				<p class="limit">还可输入150个字</p>	
			</div>
			<div class="ct-dt-pl-foot clearfix">
				<a id="J_ctDtPlFaceBtn" class="face fl" href="javascript:;"><i class="icon"></i>插入表情</a>
				<input class="btn fr" value="发表评论" type="button">
				<div id="J_ctDtPlFaceBox" class="ct-dt-pl-face">
					
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>

	<div class="pl-con">
		<!--评论 start-->
		<div class="ct-dt-pl-body mgt-5">
			<dl class="ct-dt-pl clearfix">
				<dt class="face fl"> <img class="comment-obj" src="../pub-ui/images/ct_dt_pl_icon.png" alt="头像"></dt>
				<dd class="fr">
					<div class="row clearfix">
						<h5 class="nickname fl">用户昵称：风之巅</h5>
						<span class="time">05-01 14:01</span>
					</div>
					<div class="context">
						不是说不能去其他人的区域的嘛，为啥 刘万全和赵琳琳可以去冰原呢？
					</div>
					<ul class="ct-dt-pl-reply">
						<li>
							<div class="r-row clearfix">
								<h5 class="r-nickname fl">用户昵称：风之巅</h5>
								<span class="r-time">05-01 14:01</span>
							</div>
							<div class="r-context">
								为什么我不能下载！~
							</div>
						</li>
					</ul>
					<div class="ct-dt-pl-do">
						
						<a title="" href="#none"  class="js_huifu">回复(1)</a>
					</div>
				</dd>
			</dl>
			
			<dl class="ct-dt-pl clearfix">
				<dt class="face fl"><img class="comment-obj" src="../pub-ui/images/ct_dt_pl_icon.png" alt="头像"></dt>
				<dd class="fr">
					<div class="row clearfix">
						<h5 class="nickname fl">用户昵称：风之巅</h5>
						<span class="time">05-01 14:01</span>
					</div>
					<div class="context">
						不是说不能去其他人的区域的嘛，为啥 刘万全和赵琳琳可以去冰原呢？
					</div>
                               
					<div class="ct-dt-pl-do">
						
						<a title="" href="#none" class="js_huifu">回复(1)</a>
					</div>
				</dd>
			</dl>
			<dl class="ct-dt-pl clearfix">
				<dt class="face fl"><img class="comment-obj" src="../pub-ui/images/ct_dt_pl_icon.png" alt="头像"></dt>
				<dd class="fr">
					<div class="row clearfix">
						<h5 class="nickname fl">用户昵称：风之巅</h5>
						<span class="time">05-01 14:01</span>
					</div>
					<div class="context">
						不是说不能去其他人的区域的嘛，为啥 刘万全和赵琳琳可以去冰原呢？
					</div>
					<div class="ct-dt-pl-do">
						
						<a title="" href="javascript:;" class="js_huifu">回复(1)</a>
					</div>
				</dd>
			</dl>
			<dl class="ct-dt-pl clearfix">
				<dt class="face fl"><img class="comment-obj" src="../pub-ui/images/ct_dt_pl_icon.png" alt="头像"></dt>
				<dd class="fr">
					<div class="row clearfix">
						<h5 class="nickname fl">用户昵称：风之巅</h5>
						<span class="time fl">05-01 14:01</span>
					</div>
					<div class="context">
						不是说不能去其他人的区域的嘛，为啥 刘万全和赵琳琳可以去冰原呢？
					</div>
					<div class="ct-dt-pl-do">
						
						<a title="" href="javascript:;" class="js_huifu">回复(1)</a>
					</div>
				</dd>
			</dl>
		</div>
        <!--评论 end-->
        <!--分页 start-->
		<div class="paging clearfix">
             <a href="#" class="prev">上一页</a>
             <a href="#">1</a>
             <em>...</em>
             <a href="#">3</a>
             <a href="#">4</a>
             <a href="#" class="on">5</a>
             <a href="#">6</a>
             <a href="#">7</a>
             <em>...</em>
             <a href="#">380</a>
             <a href="#" class="next-on">下一页</a>
             <span>到<input type="text" style="color: rgb(153, 153, 153); font-weight: normal;" class="paging-text">页</span>
             <a href="#" class="bg-on">确定</a>
         </div>
        <!--分页 end-->  
</div>
 <!--评论 E-->
 
<!--bottom S-->
		<div class="bottombg">
           <p>Copyright © you name 2016 公司信息</p>
           <p>使用本网站即构成接受本网站的条款和条件以及隐私政策</p>
           
        </div>
<!--bottom E-->
<!--回复内容 start-->
<div id="js_huifucon" style="display:none">

 				<div class="pub-mood-container pub-container-area2 mgt-10 mgb-25">
                                        <textarea class="pub-mood-txt pub-txt-area2">发表新心情...</textarea>
                                        <span>还可输入150个字</span>
                                        <ul class="pub-mood-footer">
                                             <li class="fl pub-face js-reply-sure"><a href="javascript:void(0)">确定回复</a></li>
                                        </ul>
                 </div>

</div>
<!--回复内容 end-->
</body>
</html>

