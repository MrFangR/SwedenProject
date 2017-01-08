<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.activity.title"></i18n:get></title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header >
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header >

  <div class="search">
       <p class="w1000">
          <input name="" type="text"  class="inputfont" value=""><input name="" type="button" onclick="searchMat(1)" class="inputbut" value="<i18n:get key='portal.activity.search.button'></i18n:get>">
       </p>
  </div>
<!--ist-con S-->		
  <div class="list-con">
     <div class="list-contitle">比赛列表</div>
      <ul id="resultDIV">
      	     <li class="listbox mr20">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at1.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">中式台球锦标赛落户顺义 花式第一人打....</a></div>
                	<div class="listdate">比赛时间：2016/12/21下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
               <li class="listbox mr20">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at2.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">中式台球锦标赛落户顺义 花式第一人打....</a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
             <li class="listbox mr20">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at3.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">中式台球锦标赛落户顺义 花式第一人打....</a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设山西省太原市杏花岭区建设北路山西省太原市杏花岭区建设北路北路331</div>
               </div>
        	</li>
             <li class="listbox">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at4.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">中式台球锦标赛落户顺义 花式第一人</a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
            
               <li class="listbox">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at3.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">TWF SFV積分賽第3季第8週 </a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
             <li class="listbox">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at4.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">中式台球锦标赛落户顺义 花式第一人</a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
            
             <li class="listbox">
             	<div class="listboximg"><a href="#none"  target="_blank"><img  src="../pub-ui/images/at4.jpg" class="attachment-thumbnail wp-post-image" ></a></div>
              	 <div class="listinfo">
                	<div class="listtitle"><a href="#none"  target="_blank">TWF SFV積分賽第3季第8週 </a></div>
                	<div class="listdate">比赛时间：2017/01/11下午9:00</div>
                    <div class="listplace">比赛地点：山西省太原市杏花岭区建设北路331</div>
               </div>
        	</li>
      </ul>
          <!--Match 备注图片用li分割， 如果加日期要加日期分页符-->
      <!--分页 start-->
      <div class="paging clearfix" id="pageDiv">
      </div>
      <!--分页 end-->      
      <div class="clearfix"></div>
  </div>
<!--list-con E-->	
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
	<script type="text/javascript" src="${ctx}/front-ui/local-ui/match.js"></script>
</html>

