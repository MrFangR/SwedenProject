<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>用户中心-happytimes上传</title>
    <script src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
	<script src="${ctx}/front-ui/js/ui.js"></script>
	<script type="text/javascript" src="${ctx}/front-ui/js/ands-popAlert.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/ands-popAlert.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
     <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >
<!--内容 start-->
     <div class="main_body" style="margin-top:110px;">
          <div class="us-set mgt-30 clearfix">
          		 <!--us-set-lf start-->
          		<div class="us-set-lf fl">
                	<div class="us-set-top">
						<dl class="info clearfix">
							<dd>
								<h3 class="nic">用户名 ： <a href="">成成成</a></h3>
							</dd>
                            <dd>
								<h3 class="num">绑定手机号：13700012130</h3>
							</dd>
						</dl>
					</div>
					<ul class="us-menu mgt-25">
					    <li>
							<a href="#none" class="link  clearfix">
								<i class="icon fl diyi"></i>
								<h5 class="name fl">信息管理</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link  clearfix">
								<i class="icon fl diliu"></i>
								<h5 class="name fl">活动管理</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link curr clearfix">
								<i class="icon fl disan"></i>
								<h5 class="name fl">happytimes</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link clearfix">
								<i class="icon fl disi"></i>
								<h5 class="name fl">参赛管理</h5>
							</a>
						</li>
					</ul>
                </div>
                 <!--us-set-lf end-->
                 <!--us-set-rt start-->
          		<div class="us-set-rt fl" style="padding-left:10px; position:relative">
                   <input name="" class="contbtn" value="<返回列表" type="button" style=" position:absolute; right:40px; top:40px">  
                  <div class="xmfb_title" style="width:200px;margin:10px auto 30px auto">
                    <h2>HappyTimes</h2>
                  </div>
                   
                   <div class="xmfb_xx"></div>
                   
                        <!--上传图片 start-->
                    				<div class="us-bd-base xmfb_con_text">
                                        <dl class="us-info-dl clearfix">
                                            <dt class="fl">上传图片：</dt>
                                            <dd class="fl upload_wrap">
                                          
                                                     <div class="localUpload_wrap">		    
                                                        <div class="localTitle">上传电脑中图片</div>		    
                                                        <div class="localUpload"><input multiple="multiple" type="file"></div>		
                                                      </div>
                                                 </dd>
                                            
                                        </dl>
                                    
                                    	<dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="rose">*</span>图片标题：</dt>
                                            <dd class="fl"><input  type="text" /></dd>
                                            <dd class="notice"></dd>
									   </dl>
                                       
                                       <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="rose">*</span>图片描述：</dt>
                                            <dd class="fl"><textarea name="" cols="" rows=""></textarea></dd>
                                            <dd class="notice"></dd>
									   </dl>
                                       <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn">确定</div>
										</dd>
									</dl>
                                    </div>
                        <!--上传图片 end-->
                
                </div>
           <!--us-set-rt end-->
           
          </div>
      <div class="clearfix"></div>
     </div>
 
 <!--内容 end-->
 
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script type="text/javascript">

</script>
</html>

