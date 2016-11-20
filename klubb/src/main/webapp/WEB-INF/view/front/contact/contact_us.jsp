<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>contact us</title>
    <script  src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx }/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
    <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >
  <!--cont-con S-->		
  <div class="list-con">
    
        <div class="mapcon">
        	<!-- <iframe style="width: 1200px;height: 685px;" src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJH3bGnUxnZEYRIGEWn6ybP2g&zoom=17&key=AIzaSyAnSqMOGPqI615A_ASt5pWkDqDP987OdaM"></iframe> -->
        </div>
   
  
   
</div>
<!--cont-con E-->	

<!--contactq S-->	
<div class="contactq">
        <div class="contact-left">
            <div class="list-contitle"><i18n:get key="portal.contact.form.title"></i18n:get></div>
             <!--us-bd-base S-->	
             <div class="us-bd-base xmfb_con_text">
						
						<form enctype="multipart/form-data" id="contactForm">
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span><i18n:get key="portal.contact.form.name"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" name="contact.NAME"/></dd>
										<dd class="notice" id="name_msg"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span><i18n:get key="portal.contact.form.phone"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" name="contact.PHONE"/></dd>
										<dd class="notice"  id="phone_msg"></dd>
									</dl>
                                   <dl class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span><i18n:get key="portal.contact.form.content"></i18n:get>：</dt>
										<dd class="fl"><textarea cols="" rows="5" name="contact.CONTENT"></textarea></dd>
										<dd class="notice" id="content_msg"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span><i18n:get key="portal.contact.form.code"></i18n:get>：</dt>
										<dd class="fl"><input style="width:100px;" type="text" name="code">
									    <img id="codeImg" onclick="getRandImg()"></dd>
										<dd class="notice" id="code_msg"></dd>
									</dl>
                             </form>      
                                   
                                 
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn" onclick="save()"><i18n:get key="portal.contact.form.submit"></i18n:get></div>
										</dd>
									</dl>
                                  
                                 <div class="clearfix"></div>
                                          
								
						</div>
                         <!--us-bd-base E-->
        </div>
        <div class="contact-right">
           <h2><i18n:get key="portal.contact.info.title"></i18n:get></h2>
           <div class="contactright">
                <p><i18n:get key="portal.contact.info.company"></i18n:get>：${config.NAME }</p>
                <p  class="mg0-30"><i18n:get key="portal.contact.info.phone"></i18n:get>: ${config.PHONE }</p>
                <p><i18n:get key="portal.contact.info.business"></i18n:get>：${config.businessTime }</p>
                <p><i18n:get key="portal.contact.info.address"></i18n:get>：${config.ADDRESS }</p>
              </div>
        </div>
        <div class="clearfix"></div>
</div>
 
 <!--contactq E-->	
 <!--bottom S-->           
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script type="text/javascript">
var rootContext = '${ctx}';
$(function(){
	getRandImg();
});

//保存
function save(){
	if(validData()){
		$.ajax({
			type : "POST",
			url : "${ctx}/contact/contactUs",
			dataType : "json",
			data : $("#contactForm").serialize(),
			success: function(data){
				if(data.rsFlag){
					pop.success(data.rsMsg, function(){});
				}else{
					showNotice(data);
				}
				getRandImg();
			}
		});
	}
}

//显示提示信息
function showNotice(data){
	$(".notice").each(function(){
		var tip = eval("data." + this.id);
		if(tip != null && tip != "" && tip != undefined && tip != "undefined"){
			$(this).html(tip);
		}else{
			$(this).html("");
		}
	});
}

//验证数据
function validData(){
	return true;
}

function getRandImg(){
	$("#codeImg").attr('src', "${ctx}/sys/randCodeImage?"+Math.random());
}
</script>
</html>

