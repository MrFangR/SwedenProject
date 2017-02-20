
<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.activity.detail"></i18n:get></title>
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
	<div class="list-con clearfix" style=" background:none;">
		<div class="list-tab">
			<div class="list-title curr" style="width:220px">比赛简介</div>
			<c:if test="${fn:length(secondList) <= 0}">
				<div class="list-title" style="width:220px">对阵</div>
			</c:if>
			<c:if test="${fn:length(secondList) > 0}">
				<div class="list-title" style="width:220px">第一轮对阵</div>
				<div class="list-title" style="width:220px">第二轮对阵</div>
			</c:if>
            <div class="list-title" style="width:220px">排行榜</div>
            <div class="list-title" style="width:220px">评价</div>
            <div class=" clearfix"></div>
		</div>
		<div class="listtabcon">
			<!--比赛介绍 S-->	
			<div class="tabsub">
				<!--cont-con S-->
					<div class="cont-con" style="margin-top:0px;">
						<h1 class="contitle">${match.NAME }</h1>
						<input type="hidden" id="introMatchId" value="${match.ID }">
						<p class="confutitle">
						<c:if test="${match.STATUS == 0}">
							<c:choose>
								<c:when test="${applyFlag==0 }">
									<input id="addMatch" name="addMatch" class="contbtn" value="+参加比赛" type="button">
								</c:when>
								<c:when test="${applyFlag==1 }">
									<input name="addMatch" class="contbtn" value="+已报名" type="button" disabled="disabled" style="background: #C8C8C8">
								</c:when>
								<c:when test="${applyFlag==2 }">
									<input name="addMatch" class="contbtn" value="+报名人数已满" type="button" disabled="disabled">
								</c:when>
							</c:choose>
						</c:if>
						<span>时间：${match.startDateStr }</span><span class="mgl-200"></span></p>
                                       <p class="conline"></p>
                                       <div class="cont-text">
                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${match.DESCRIPTION }
                                        </div>
                                        <input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
                                         <div id="matchUserList"></div>
                                         <div class="paging clearfix" id="matchPageDiv"></div>
					</div>
				<!--cont-con E-->
			</div>
			<!--对阵 S-->	
            <div class="tabsub"  style="display:none; margin:0px;">
				<!--第一tab  一列是320px 目前展示5列宽为1600px  如果对阵图列数超过3需要代码判断列数给 box-n div 输入宽度 s-->
				<c:set var="boxMgt" value="${fn:split('0,50,140,340,740', ',') }" />
				<c:set var="tempMgt" value="${fn:split('20,120,320,720', ',') }" />
				<c:set var="svgHeight" value="${fn:split('56,100,200,400', ',') }" />

				<c:set var="lBoxMgt" value="${fn:split('50,0,50,0,100,60,260,220', ',') }" />
				<c:set var="lTempMgt" value="${fn:split('20,20,120,120,320,320,60,100', ',') }" />
				<c:set var="lSvgHeight" value="${fn:split('56,56,56,100,56,200,56,56', ',') }" />

				<input type="hidden" id="winTitleLength" value="${fn:length(winTitleList)}">
				<input type="hidden" id="loseTitleLength" value="${fn:length(loseTitleList)}">

				<div id="boxDiv" class="box-n on1" style="width:1600px;">
					<div class="clearfix">
						<!--比赛标题  s-->
						<div class="matchtitle">
							<c:forEach items="${winTitleList}" var="title">
								<li>${title}</li>
							</c:forEach>
							<div class="clear"></div>
						</div>
						<!--比赛标题  e-->
						<!--比赛内容框  s-->
						<div class="clearfix">
							<c:forEach items="${winList}" var="gList" varStatus="status">
							<c:if test="${status.index == 0}">
							<!--可拖动部分  s-->
							<c:choose>
							<c:when test="${match.STATUS == 0 }">
							<div class="dropbox">
								</c:when>
								<c:otherwise>
								<div class="nodrop">
									</c:otherwise>
									</c:choose>
									</c:if>
									<c:if test="${status.index > 0}">
									<!--可拖动部分  s-->
									<div class="nodrop" style="margin-top: ${boxMgt[status.index]}px;">
										</c:if>
										<c:forEach items="${gList}" var="game" varStatus="gStatus">
										<c:if test="${gStatus.index mod 2 == 0}">
										<!--完整模板  s-->
										<div class="matchgroup">

											<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${tempMgt[status.index]}px;"</c:if>>
												<h3>${game.SEQ }</h3>
												<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
												<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
											</div>
											</c:if>
											<c:if test="${gStatus.index mod 2 == 1}">
											<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${tempMgt[status.index]}px;">
												<h3>${game.SEQ }</h3>
												<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
												<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
											</div>
											<c:if test="${not status.last }">
												<div class="matchline">

													<svg  x="0" y="0" width="290px" height="${svgHeight[status.index] }px">
														<path d="M 228 1 L 236 1 L 236 ${svgHeight[status.index] } " class="bracket-line"/>
													</svg>
													<svg  x="0" y="0"  width="290px" height="${svgHeight[status.index] }px" style="margin-top:-6px">
														<path d="M 228,${svgHeight[status.index] } L 236,${svgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
													</svg>
												</div>
											</c:if>
										</div>
										</c:if>
										<c:if test="${status.last and fn:length(secondList) <= 0}">
									</div>
										<c:if test="${not empty thirdGame}">
											<div class="matchgroup mgt-60">
												<div wId="${thirdGame.winnerId }" tNum="${thirdGame.tableNum }" sTime="${thirdGame.startTime }" gType="${thirdGame.TYPE }" gSeq="${thirdGame.SEQ }" gId="${thirdGame.ID}" wSeq="${thirdGame.WNextId}" lSeq="${thirdGame.LNextId}" class="template js_template">
													<h3>${thirdGame.SEQ }</h3>
													<div class="group" id="${thirdGame.ID }_1" ><i><c:if test="${thirdGame.u1_SEQ != 0}">${thirdGame.u1_SEQ}</c:if></i><span id="${thirdGame.USER1 }">${thirdGame.u1_NAME }</span><input name="" type="text" value="${thirdGame.SCORE1 }"></div>
													<div class="group" id="${thirdGame.ID }_2" ><i><c:if test="${thirdGame.u2_SEQ != 0}">${thirdGame.u2_SEQ}</c:if></i><span id="${thirdGame.USER2 }">${thirdGame.u2_NAME }</span><input name="" type="text" value="${thirdGame.SCORE2 }"></div>
												</div>
											</div>
										</c:if>
									</c:if>
									<!--完整模板  e-->
									</c:forEach>
								</div>
								</c:forEach>
								<!--比赛内容框 e-->
							</div>
						</div>

						<c:if test="${fn:length(loseTitleList) > 0}">
						<div class="clearfix mgt-40">
							<!--比赛标题  s-->
							<div class="matchtitle">
								<c:forEach items="${loseTitleList}" var="title">
									<li>${title}</li>
								</c:forEach>
								<div class="clear"></div>
							</div>
							<!--比赛标题  e-->
							<!--比赛内容框  s-->
							<div class="clearfix">
								<c:forEach items="${loseList}" var="gList" varStatus="status">
									<!--可拖动部分  s-->
									<div class="nodrop" style="margin-top: ${lBoxMgt[status.index]}px;">
										<c:forEach items="${gList}" var="game" varStatus="gStatus">
											<c:if test="${status.index mod 2 == 0}">
												<!--完整模板  s-->
												<div class="matchgroup">
													<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template"  <c:if test="${gStatus.index > 0}">style="margin-top: ${lTempMgt[status.index]}px;"</c:if>>
														<h3>${game.SEQ }</h3>
														<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
														<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
													</div>
													<c:if test="${not status.last }">
														<div class="matchline">
															<svg  x="0" y="0" width="290px" height="${lSvgHeight[status.index] }px" style="margin-top:-86px">
																<path d="M 228,${lSvgHeight[status.index] } L 236,${lSvgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
															</svg>
														</div>
													</c:if>
												</div>
											</c:if>

											<c:if test="${status.index mod 2 == 1}">
												<c:if test="${gStatus.index mod 2 == 0}">
													<!--完整模板  s-->
													<div class="matchgroup">
													<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${lTempMgt[status.index]}px;"</c:if>>
														<h3>${game.SEQ }</h3>
														<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
														<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
													</div>
												</c:if>
												<c:if test="${gStatus.index mod 2 == 1}">
													<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${lTempMgt[status.index]}px;">
														<h3>${game.SEQ }</h3>
														<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
														<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
													</div>
													<c:if test="${not status.last }">
														<div class="matchline">

															<svg  x="0" y="0" width="290px" height="${lSvgHeight[status.index] }px">
																<path d="M 228 1 L 236 1 L 236 ${lSvgHeight[status.index] } " class="bracket-line"/>
															</svg>
															<svg  x="0" y="0"  width="290px" height="${lSvgHeight[status.index] }px" style="margin-top:-6px">
																<path d="M 228,${lSvgHeight[status.index] } L 236,${lSvgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
															</svg>
														</div>
													</c:if>
													</div>
												</c:if>

												<!--完整模板  e-->
											</c:if>
										</c:forEach>
									</div>
								</c:forEach>
								<!--比赛内容框 e-->
							</div>
							<c:if test="${fn:length(secondList) <= 0}">
						</div>
						</c:if>
					</div>
					</c:if>
				</div>
			</div>
            <!--对阵 E-->

			<c:if test="${fn:length(secondList) > 0}">
			<!--对阵 S-->
			<div class="tabsub"  style="display:none; margin:0px;">
				<div class="clearfix">
					<!--比赛标题  s-->
					<div class="matchtitle">
						<c:forEach items="${secondTitleList}" var="title">
							<li>${title}</li>
						</c:forEach>
						<div class="clear"></div>
					</div>
					<!--比赛标题  e-->
					<!--比赛内容框  s-->
					<div class="clearfix">
						<c:forEach items="${secondList}" var="gList" varStatus="status">
						<c:if test="${status.index == 0}">
						<!--可拖动部分  s-->
						<div class="dropbox">

								</c:if>
								<c:if test="${status.index > 0}">
								<!--可拖动部分  s-->
								<div class="nodrop" style="margin-top: ${boxMgt[status.index]}px;">
									</c:if>
									<c:forEach items="${gList}" var="game" varStatus="gStatus">
									<c:if test="${gStatus.index mod 2 == 0}">
									<!--完整模板  s-->
									<div class="matchgroup">

										<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${tempMgt[status.index]}px;"</c:if>>
											<h3>${game.SEQ }</h3>
											<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
											<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
										</div>
										</c:if>
										<c:if test="${gStatus.index mod 2 == 1}">
										<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime='<fmt:formatDate value="${game.startTime }" pattern="dd/MM/yyyy HH:mm"/>' gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${tempMgt[status.index]}px;">
											<h3>${game.SEQ }</h3>
											<div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
											<div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
										</div>
										<c:if test="${not status.last }">
											<div class="matchline">

												<svg  x="0" y="0" width="290px" height="${svgHeight[status.index] }px">
													<path d="M 228 1 L 236 1 L 236 ${svgHeight[status.index] } " class="bracket-line"/>
												</svg>
												<svg  x="0" y="0"  width="290px" height="${svgHeight[status.index] }px" style="margin-top:-6px">
													<path d="M 228,${svgHeight[status.index] } L 236,${svgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
												</svg>
											</div>
										</c:if>
									</div>
									</c:if>
									<c:if test="${status.last}">
								</div>
									<c:if test="${not empty thirdGame}">
										<div class="matchgroup mgt-60">
											<div wId="${thirdGame.winnerId }" tNum="${thirdGame.tableNum }" sTime="${thirdGame.startTime }" gType="${thirdGame.TYPE }" gSeq="${thirdGame.SEQ }" gId="${thirdGame.ID}" wSeq="${thirdGame.WNextId}" lSeq="${thirdGame.LNextId}" class="template js_template">
												<h3>${thirdGame.SEQ }</h3>
												<div class="group" id="${thirdGame.ID }_1" ><i><c:if test="${thirdGame.u1_SEQ != 0}">${thirdGame.u1_SEQ}</c:if></i><span id="${thirdGame.USER1 }">${thirdGame.u1_NAME }</span><input name="" type="text" value="${thirdGame.SCORE1 }"></div>
												<div class="group" id="${thirdGame.ID }_2" ><i><c:if test="${thirdGame.u2_SEQ != 0}">${thirdGame.u2_SEQ}</c:if></i><span id="${thirdGame.USER2 }">${thirdGame.u2_NAME }</span><input name="" type="text" value="${thirdGame.SCORE2 }"></div>
											</div>
										</div>
									</c:if>
								</c:if>
								<!--完整模板  e-->
								</c:forEach>
							</div>
							</c:forEach>
							<!--比赛内容框 e-->
						</div>
					</div>
				</div>
				<!--对阵 E-->
				</c:if>





            <!--排行榜  S-->	
            <div class="tabsub"   style="display:none; margin:0px; background:#fff; padding-top:40px; padding-bottom:40px;">
           		<table class="table-con">
           			<tr>
                      <th>排名</th>
                      <th>参与者名字</th>
                      <th>比赛历史</th>
                    </tr>
                    <c:forEach var="rink" items="${rinkMap }">
                    		<c:forEach var="rinkV" items="${rink.value }" varStatus="status">
                    	<tr class="table-tr-even">
                    		<c:if test="${status.first }"><td rowspan="${fn:length(rink.value)}" >${rink.key }</td></c:if>
                    		  <td>${rinkV.userName }</td>
		                      <td>
		                      	<c:forEach var="flag" items="${rinkV.matchFlag }">
		                      		<c:if test="${flag=='win' }">
		                      			<i class="win" title="胜利">胜利</i>
		                      		</c:if>
		                      		<c:if test="${flag=='loser' }">
		                      			<i class="fail" title="失败">失败</i>
		                      		</c:if>
		                      	</c:forEach>
		                      </td>
                    		</c:forEach>
                    	</tr>
                    </c:forEach>
                    <!-- 
                    <c:forEach var="rink" items="${rinkList }">
	                    <tr class="table-tr-even">
	                      <td >${rink.seq }</td>
	                      <td>${rink.userName }</td>
	                      <td>
	                      	<c:forEach var="flag" items="${rink.matchFlag }">
	                      		<c:if test="${flag=='win' }">
	                      			<i class="win" title="胜利">胜利</i>
	                      		</c:if>
	                      		<c:if test="${flag=='loser' }">
	                      			<i class="fail" title="失败">失败</i>
	                      		</c:if>
	                      	</c:forEach>
	                      </td>
	                    </tr>
                    </c:forEach>
                     -->
           		</table>
           	</div>
           	<!--排行榜 E-->
           	<!--评论S-->
           	<div class="tabsub"   style="display:none; margin:0px;background:#fff">
           	<%@ include file="/ninclude/frontMember/evaluation.jsp"%>
			</div>
			<form enctype="multipart/form-data" action="" id="evaForm">
			  	<input type="hidden" value="${match.ID}" id="OBJ_ID" name="evaluation.OBJ_ID"/>
			   	<input type="hidden" value="3" id="OBJ_TYPE" name="evaluation.OBJ_TYPE"/>
			   	<input type="hidden" value="" id="CONTENT" name="evaluation.CONTENT"/>
			   	<input type="hidden" value="" id="P_ID" name="evaluation.P_ID"/>
			</form>
           	<!--评论E-->
		</div>

		<div class="clearfix"></div>
	</div>
<!--list-con E-->
	<!--弹框编辑比分  s-->
	<div data-role="ued-dialog" class="ued-dialog" id="btn-matchbtn">
		<div class="dialog-header">
			<h3>比赛详情</h3> <span class="dialog-tool">
            <a title="关闭" class="dialog-close">X</a>
        </span>
		</div>
		<div class="dialogtitle"><ul><li class="cur">比赛信息</li><li>比分信息</li></ul></div>
		<div class="clear"></div>
		<div class="dialogcon">
			<ul>
				<li class="cur">
					<p class=" tc"><b class="editUser1" uid=""></b>VS<b class="editUser2" uid=""></b></p>
					<table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
						<tbody>
						<tr>
							<th>球桌编号：</th>
							<td id="editTableNum" style="width: 50%;">

							</td>
						</tr>
						<tr>
							<th>比赛类型：</th>
							<td id="editType">

							</td>
						</tr>
						<tr>
							<th>开始时间：</th>
							<td id="editStartTime">
							</td>

						</tr>

						</tbody>
					</table>
				</li>
				<li>
					<h3 class="tit">比赛胜者</h3>
					<div class="clearfix" style="width:180px; margin:0 auto"><span id="editUser1" class="btn editUser1"></span><span id="editUser2" class="btn editUser2"></span> </div>
					<h3 class="tit">比赛比分</h3>
					<input type="hidden" id="editGameId"/>
					<table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
						<tbody>
						<tr>
							<th><span class="editUser1" uid=""></span>：</th>
								<td id="editScore1" style="width: 50%;">
							</td>
						</tr>
						<tr>
							<th><span class="editUser2" uid=""></span>：</th>
								<td id="editScore2">
							</td>

						</tr>

						</tbody>
					</table>
				</li>
			</ul>

		</div>

		<div class="pd-10 tc">
			<button type="button" class="ued-button-3 dialog-close">关闭</button>
		</div>

	</div>
	<!--弹框编辑比分  e-->
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script	 type="text/javascript" src="${ctx}/front-ui/js/dialog.js"></script>
<script	 type="text/javascript" src="${ctx}/front-ui/js/dragula.js"></script>
<script type="text/javascript">
$(function(){
	showMatchUserList(1);
	$("#addMatch").bind("click",function(){
		$("#addMatch").unbind("click");
		$.ajax({
			type:"post",
			url:"${ctx}/front/matchdetail/addMatch",
			data:{
				"matchId" : $("#introMatchId").val()
			},
			dataType : "json",
			success : function(json){
				var mark = json.retCode;
				if(mark==0){
					var matchId = $("#introMatchId").val();
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'参加比赛',//注册
						text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
						'ok':function(){window.location.href = '${ctx}/front/matchdetail?matchId='+matchId;},
						tag:'zq-ring'}
		               );
				}else{
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'参加比赛',
						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
						'ok':function(){$("#addMatch").bind("click");;},
						tag:'cw-ring'}
		               );
				}
			},
			error:function(){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'参加比赛',
					text:'<div style=" font-size:18px; color:#ff0000;"> 报名失败 </div>',
					'ok':function(){$("#addMatch").bind("click");;},
					tag:'cw-ring'}
	               );
			}
		});
	});

    $(".js_template")
        .hover(
            function() {
                initDialog(this);
                $(this)
                    .append(
                        "<div class='matchbtn js_matchbtn'><i class='mtch_see' title='查看比赛'></i></div>");
            }, function() {
                $(this).find(".js_matchbtn").remove();
            });

    //tab切换
    $(".dialogtitle ul li").live("click",function(){
        var index_no = $(this).index();
        $(this).addClass("cur").siblings().removeClass("cur");
        $(".dialogcon ul li").eq(index_no).addClass("cur").siblings().removeClass("cur");
    })


    //高度设置
    var contWrapH = $("div.ued-layout").height();
    //弹出框比分
    $(".mtch_edit").bind("click", function() {
        $("#btn-fen").trigger("dialog-open");
    });
    //弹出框
    $(".js_dialog").bind("click", function() {
        $("#btn-dialog").trigger("dialog-open");
    });
    //编辑比分弹框
    $(".js_matchbtn").live("click", function() {
        $("#btn-matchbtn").trigger("dialog-open");
    });

	initBoxWidth();
});

function initBoxWidth(){
    var winLen = $("#winTitleLength").val();
    var loseLen = $("#loseTitleLength").val();
    var len = winLen;
    if(loseLen > 0){
        len = loseLen;
    }
    $("#boxDiv").css("width", 320*len + "px");
}

function initDialog(self) {
    $("#btn-matchbtn span.btn").removeClass("active");

    var $div1 = $(self).children("div:first");
    var $div2 = $(self).children("div:last");

    var userName1 = $div1.find("span").html();
    if(userName1 == ""){
        userName1 = "&nbsp;";
    }
    $(".editUser1").html(userName1);
    $(".editUser1").attr("uid", $div1.find("span").attr("id"));

    var userName2 = $div2.find("span").html();
    if(userName2 == ""){
        userName2 = "&nbsp;";
    }
    $(".editUser2").html(userName2);
    $(".editUser2").attr("uid", $div2.find("span").attr("id"));

    $("#editScore1").html($div1.find("input").val());
    $("#editScore2").html($div2.find("input").val());

    $("#editGameId").val($(self).attr("gId"));

    $("#editTableNum").html($(self).attr("tNum"));
    $("#editStartTime").html($(self).attr("sTime"));
    var typeName = "未指定";
    if($(self).attr("gType") != ""){
        typeName = $(self).attr("gType") + "球";
	}
    $("#editType").html(typeName);
    $("#typeTxt").html($("#typeSelect a[tn='" + $(self).attr("gType") + "']").html());

    if($(self).attr("wId") != null && $(self).attr("wId") != ""){
        if($(self).attr("wId") == $div1.find("span").attr("id")){
            $("#editUser1").addClass("active").siblings("span.btn").removeClass("active");
        }else if($(self).attr("wId") == $div2.find("span").attr("id")){
            $("#editUser2").addClass("active").siblings("span.btn").removeClass("active");
        }
    }else{
        $("#btn-matchbtn span.btn").removeClass("active");
	}
}

function showMatchUserList(pageNum){
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : false,
		url : "${ctx}/front/matchdetail/matchUserList",
		data : {
			pageNum : $('#pageNumIn').val(),
			matchId: $("#introMatchId").val()
		},
		dataType : "html",
		success : function(data){
			$('#matchUserList').html(data);
			//设置分页
			var pageData = new Object();
			pageData.totalPage=parseInt($("#userTotalPage").val());
			pageData.pageNumber=parseInt($("#userPageNum").val());
			setPageInfo("matchPageDiv", pageData, showMatchUserList);
			return false;
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'比赛详情',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
			return;
		}
	});
}
//
////翻页
//function qry4Page(pageNum){
//	showMatchUserList(pageNum);
//}
</script>
</html>

