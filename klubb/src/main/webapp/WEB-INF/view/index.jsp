<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>billiards</title>
    <script  src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx }/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
    <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >
  <div class="gonggao">
    <div class="ggfont">
    	<marquee id=go1 onMouseOver=go1.stop() onMouseOut=go1.start() scrollamount=2 scrolldelay=2 direction=left hspace="80px">
    	<p class="mgl-200"><i18n:get key="portal.index.notice"></i18n:get>：${notice.CONTENT }</p>
    	</marquee>
    </div>
  </div>

  	<!--轮播 S-->
			<div id="J_amLbBox" class="am-lb-box">
				<ul id="J_amLbBody" class="am-lb-body">
					<li  style="z-index:20;display: block;background:url(${ctx }/front-ui/images/banner1.jpg)"></li>
					<li style="background:url(${ctx }/front-ui/images/banner2.jpg)"></li>
					<li style="background:url(${ctx }/front-ui/images/banner3.jpg)"></li>
				</ul>
				<div class="am-lb-info">
					<div class="info-bg"></div>
					<ul id="J_amLbInfo" class="am-lb-info-ul">
						<li>
							<a class="clearfix" href="">
								<dl class="update fl">
									<dd><span class="num">01</span></dd>
								</dl>
								<dl class="cont fr">
									<dt>直播奥沙利文VS希金斯</dt>
							    </dl>
							</a>
						</li>
						<li>
							<a class="clearfix" href="">
								<dl class="update fl">
									<dd><span class="num">02</span> </dd>
								</dl>
								<dl class="cont fr">
									<dt>Improve Mathematics And Social</dt>
								</dl>
							</a>
						</li>
                        <li>
							<a class="clearfix" href="">
								<dl class="update fl">
									<dd><span class="num">03</span></dd>
								</dl>
								<dl class="cont fr">
									<dt>冠中冠奥沙利文一日两胜 单杆破百已达830杆</dt>
								</dl>
							</a>
						</li>
						
					</ul>
				</div>
				<a id="J_amLbPrev" class="dir prev" href="javascript:;"><i class="icon"></i></a>
				<a id="J_amLbNext" class="dir next" href="javascript:;"><i class="icon"></i></a>
				<ul id="J_amLbNav" class="am-lb-nav clearfix">
					<li class="curr"></li>
					<li></li>
					<li></li>
				</ul>
			</div>
			<!--轮播 E-->
            <!--最新比赛  注意为实现全屏自适应采用了特殊布局方式有些地方不能加空格 S-->
			<div class="hactivity">
				<c:if test="${not empty matchLst[1] }">
					<div class="hacfist"><i18n:get key="portal.index.game"></i18n:get></div><div class="image2"><a href="${ctx}/front/matchdetail?matchId=${matchLst[1].ID}"><img src="${uploadUrl }${matchLst[1].IMG}" ></a><p class="atc">${matchLst[1].NAME}</p></div>
				</c:if>
				<c:if test="${empty matchLst[1] }">
					<div class="hacfist"><i18n:get key="portal.index.game"></i18n:get></div><div class="image2"><a href="#none"><img src="${ctx }/front-ui/images/at1.jpg" ></a><p class="atc">大师赛第二阶段王岩邱</p></div>
				</c:if>
            </div>
            <div class="hactivity">
            	<c:if test="${not empty matchLst[0] }">
                	<div class="secleft"><a href="${ctx}/front/matchdetail?matchId=${matchLst[0].ID}"><img src="${uploadUrl }${matchLst[0].IMG}"></a><p class="atc2">${matchLst[0].NAME}</p></div><div class="secright">
               	</c:if>
               	<c:if test="${empty matchLst[0] }">
                	<div class="secleft"><a href="#none"><img src="${ctx }/front-ui/images/at2.jpg"></a><p class="atc2">@大师赛第二阶段王岩邱</p></div><div class="secright">
               	</c:if>
                <div class="secr-left">
                	<c:if test="${not empty matchLst[2] }">
                		<a href="${ctx}/front/matchdetail?matchId=${matchLst[2].ID}"><img src="${uploadUrl }${matchLst[2].IMG}"></a><p class="atc">${matchLst[2].NAME}</p>
                	</c:if>
                	<c:if test="${empty matchLst[2] }">
                		<a href="#none"><img src="${ctx }/front-ui/images/at3.jpg"></a><p class="atc">大师赛第二阶段王岩邱</p>
                	</c:if>
                </div><div class="secr-right">
                	<c:if test="${not empty matchLst[3] }">
                		<a href="${ctx}/front/matchdetail?matchId=${matchLst[3].ID}"><img src="${uploadUrl }${matchLst[3].IMG}" ></a><p class="atc">${matchLst[3].NAME}</p>
                	</c:if>
                	<c:if test="${empty matchLst[3] }">
                		<a href="#none"><img src="${ctx }/front-ui/images/at4.jpg" ></a><p class="atc">大师赛第二阶段王岩邱</p>
                	</c:if>
                </div>
                <div class="secr-left">
                	<c:if test="${not empty matchLst[4] }">
                		<a href="${ctx}/front/matchdetail?matchId=${matchLst[4].ID}"><img src="${uploadUrl }${matchLst[4].IMG}"></a><p class="atc">${matchLst[4].NAME}</p>
                	</c:if>
                	<c:if test="${empty matchLst[4] }">
                		<a href="#none"><img src="${ctx }/front-ui/images/at5.jpg"></a><p class="atc">大师赛第二阶段王岩邱</p>
                	</c:if>
                </div><div class="secr-right">
                	<c:if test="${not empty matchLst[5] }">
                		<a href="${ctx}/front/matchdetail?matchId=${matchLst[5].ID}"><img src="${uploadUrl }${matchLst[5].IMG}" ></a><p class="atc">${matchLst[5].NAME}</p>
                	</c:if>
                	<c:if test="${empty matchLst[5] }">
                		<a href="#none"><img src="${ctx }/front-ui/images/at3.jpg" ></a><p class="atc">大师赛第二阶段王岩邱</p>
                	</c:if>
                </div>
                </div>
            </div>
 <!--HappyTimes S-->
            <div class="htmleaf-container">
		        <p class="happptime-title"> HappyTimes</p> 
                <div class="poster-main" id="carousel" data-setting='{
                                    "width":1200,
                                    "height":300,
                                    "posterWidth":600,
                                    "posterHeight":300,
                                    "scale":0.8,
                                    "speed":1000,
                                    "autoPlay":true,
                                    "delay":3000,
                                    "verticalAlign":"middle"
                                    }'> 
                       <div class="poster-btn poster-prev-btn"></div> 
                       <ul class="poster-list"> 
                       		<c:forEach items="${pictures }"  var="picture">
                        			<li class="poster-item"><a href="${ctx}/front/happytimes/showHTdetails?picID=${picture.ID}"><p class="font-title">${picture.DESCRIPTION}</p><img src="${uploadUrl }${picture.URL}" alt="" width="100%" /></a></li>
                            </c:forEach>
                            <!-- 
						<li class="poster-item"><a href="#"><p class="font-title">花式第一人打响头炮</p><img src="${ctx }/front-ui/images/happytimes1.jpg" alt="" width="100%" /></a></li> 
                        <li class="poster-item"><a href="#"><p class="font-title">中式台球世界锦标赛</p><img src="${ctx }/front-ui/images/happytimes2.jpg" alt="" width="100%" /></a></li> 
                        <li class="poster-item"><a href="#"><p class="font-title">直播奥沙利文VS希金斯</p><img src="${ctx }/front-ui/images/happytimes3.jpg" alt="" width="100%" /></a></li> 
                        <li class="poster-item"><a href="#"><p class="font-title">中式台球锦标赛落户顺义 </p><img src="${ctx }/front-ui/images/happytimes4.jpg" alt="" width="100%" /></a></li> 
                        <li class="poster-item"><a href="#"><p class="font-title">冠中冠奥沙利文一日两胜 </p><img src="${ctx }/front-ui/images/happytimes5.jpg" alt="" width="100%" /></a></li> 
                             -->
                       </ul> 
                       <div class="poster-btn poster-next-btn"></div> 
                  </div> 
	
		 </div>
         <div class="hpbg"></div>
<!--HappyTimes E-->
<!--CONTACT  US S-->
	<div class="contact">
           <h2 class="contact-title"><i18n:get key="portal.index.contact.title"></i18n:get></h2>
            <div class="contact-con">
              <div class="contactlef"><img src="https://maps.googleapis.com/maps/api/staticmap?center=62.391036,17.3046913&zoom=13&size=470x400&
markers=color:red|62.391036,17.3046913&key=AIzaSyBJ4Kipc0KozKxGl36s4w0JyCWhywIFHas" ></div>
              <div class="contactright">
                <p><i18n:get key="portal.index.contact.company"></i18n:get>：Sundsvalls BiljardKlubb</p>
                <p  class="mg0-30"><i18n:get key="portal.index.contact.phone"></i18n:get>: ${config.PHONE }</p>
                <p><i18n:get key="portal.index.contact.address"></i18n:get>：${config.ADDRESS }</p>
              </div>
            </div>
        </div>
<!--CONTACT  US E-->
 <!--bottom S-->           
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script  src="${ctx }/front-ui/js/Carousel.js"></script>
<script type="text/javascript">
		$(function(){
			Carousel.init($("#carousel"));
			$("#carousel").init();
		});
</script>
</html>

