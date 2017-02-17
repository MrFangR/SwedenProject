<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title></title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：比赛管理</div>
	
	<div class="ued-tab js_tab">
		<input type="hidden" id="matchId" value="${match.ID }">
		<input type="hidden" id="matchStatus" value="${match.STATUS }">
        <!--tab  s-->
        <div class="ued-tab-tit clearfix js_tab_tit">
            <ul class="ued-tab-1 fl clearfix">
				<c:if test="${fn:length(secondList) <= 0}">
					<li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑对阵图</a></li>
				</c:if>
				<c:if test="${fn:length(secondList) > 0}">
					<li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑第一轮对阵图</a></li>
					<li class="liQuery"><a class="ued-add" href="javascript:void(0)">编辑第二轮对阵图</a></li>
				</c:if>
                <li class="liQuery"><a class="ued-see" href="javascript:void(0)">编辑参与者</a></li>
                <li class="liLook"><a class="ued-see" href="javascript:void(0)">查看参与者</a></li>
            </ul>

        </div>
        <!--tab  e-->
        <!--tabcon  s-->
        <div class="ued-tab-con mgt-20">
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

                        <div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${tempMgt[status.index]}px;"</c:if>>
                            <h3>${game.SEQ }</h3>
	                    <div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
	                    <div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
	                    </div>
            		</c:if>
                    <c:if test="${gStatus.index mod 2 == 1}">
						<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${tempMgt[status.index]}px;">
							<h3>${game.SEQ }</h3>
							<div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
							<div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
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
            			<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template"  <c:if test="${gStatus.index > 0}">style="margin-top: ${lTempMgt[status.index]}px;"</c:if>>
	                        <h3>${game.SEQ }</h3>
	                    <div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER2 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
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
		                    <div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${lTempMgt[status.index]}px;"</c:if>>
		                        <h3>${game.SEQ }</h3>
		                    <div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
		                    <div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
		                    </div>
	            		</c:if>
	                    <c:if test="${gStatus.index mod 2 == 1}">
							<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${lTempMgt[status.index]}px;">
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

             <!--第一tab  e-->


			<c:if test="${fn:length(secondList) > 0}">
			<div id="boxDiv1" class="box-n" style="width:1600px;">
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
						<%--<c:choose>--%>
						<%--<c:when test="${match.STATUS == 0 }">--%>
						<%--<div class="dropbox">--%>
							<%--</c:when>--%>
							<%--<c:otherwise>--%>
							<%--<div class="nodrop">--%>
								<%--</c:otherwise>--%>
								<%--</c:choose>--%>
								</c:if>
								<c:if test="${status.index > 0}">
								<!--可拖动部分  s-->
								<div class="nodrop" style="margin-top: ${boxMgt[status.index]}px;">
									</c:if>
									<c:forEach items="${gList}" var="game" varStatus="gStatus">
									<c:if test="${gStatus.index mod 2 == 0}">
									<!--完整模板  s-->
									<div class="matchgroup">

										<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" <c:if test="${gStatus.index > 0}">style="margin-top: ${tempMgt[status.index]}px;"</c:if>>
											<h3>${game.SEQ }</h3>
											<div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
											<div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
										</div>
										</c:if>
										<c:if test="${gStatus.index mod 2 == 1}">
										<div wId="${game.winnerId }" tNum="${game.tableNum }" sTime="${game.startTime }" gType="${game.TYPE }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template" style="margin-top: ${tempMgt[status.index]}px;">
											<h3>${game.SEQ }</h3>
											<div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
											<div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 and match.STATUS == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
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
			</c:if>



            <!--第二tab  s-->
            <div class="box-n" style="width:100%" id="matchUserLst">
            		<c:if test="${match.STATUS == 0 }">
                    	<button class="ued-button-4 js_dialog mgl-25" id="randomSort">打散用户顺序</button> 
                    	<button class="ued-button-4 mgl-25" id="generateGame">重新生成对阵图</button>
            		</c:if>
                    <div id='single1' class='container'>
						<c:forEach var="user" items="${matchUser}">
							<c:if test="${not empty user.startScore}">
								<div>${user.NAME } <p class="input">初始分：<span>${user.startScore }</span></p><i class="mtch_del" dataValue="${user.ID }" dataName="${user.NAME }"></i><i class="mtch_edit" dataValue="${user.ID }" userValue="${user.userId }" startScore="${user.startScore }"></i></div>
							</c:if>
							<c:if test="${empty user.startScore}">
								<div>${user.NAME } <p class="input">初始分：<span>0</span></p><i class="mtch_del" dataValue="${user.ID }" dataName="${user.NAME }"></i><i class="mtch_edit" dataValue="${user.ID }" userValue="${user.userId }" startScore="${user.startScore }"></i></div>
							</c:if>
						</c:forEach>
                   </div>
					<c:if test="${match.STATUS == 0 }">
                  		<div class="tc" style="width:60%; margin-top:30px;"><button class="ued-button-2 js_dialog">添加人员</button></div>
                  	</c:if>
             </div>
            <!--第二tab  e-->
            <!-- 第三个tab s -->
           	<div class="box-n">
           		<input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
	            <div id="tab3List">
	            </div>
           	</div>
            <!-- 第三个tab e -->
        </div>
        <!--tabcon  e-->

</div>
  <!--弹框  s-->
 <div data-role="ued-dialog" class="ued-dialog" id="btn-dialog">
	    <div class="dialog-header">
	        <h3>添加参赛人员</h3>
	        <span class="dialog-tool">
	            <a title="关闭" class="dialog-close">X</a>
	        </span>
	    </div>
	    <div>
	        <p class="pd-20 dialog-tipInfo clearfix">姓名：
	        <select size="1" style="width:180px;" id="addUser" name="addUser">
	        	<c:choose>
	        		<c:when test="${empty noMatchUser }">
	        			<option value="">暂无可添加成员</option>
	        		</c:when>
	        		<c:otherwise>
			        	<c:forEach var="user" items="${noMatchUser }">
			        		<option value="${user.ID }">${user.NAME }</option>
			        	</c:forEach>
	        		</c:otherwise>
	        	</c:choose>
	       </select>
	       </p>
	        <div class="pd-10 tc">
	            <c:if test="${!empty noMatchUser }">
	            	<button type="button" class="ued-button-2 mgr-25" id="submitUser">保存</button>
	            </c:if>
	            <button type="button" class="ued-button-3 dialog-close">取消</button>
	        </div>
	    </div>
	</div>

	<!--弹框初始化分数  s-->
	 <div data-role="ued-dialog" class="ued-dialog" id="btn-fen">
	    <div class="dialog-header">
	        <h3>设置初始分数</h3>
	        <span class="dialog-tool">
	            <a title="关闭" class="dialog-close">X</a>
	        </span>
	    </div>
	    <div>
	        <p class="pd-20 dialog-tipInfo clearfix">分数：
	       		<input name="startScore" id="startScore" type="text">
	       		<input type="hidden" id="matchUserId">
	       		<input type="hidden" id="userId">
	       </p>
	        <div class="pd-10 tc">
	            <button type="button" class="ued-button-2 mgr-25" id="setStartScore">保存</button>
	            <button type="button" class="ued-button-3 dialog-close">取消</button>
	        </div>
	    </div>
	</div>
  <!--弹框编辑比分  s-->
 <div data-role="ued-dialog" class="ued-dialog" id="btn-matchbtn">
    <div class="dialog-header">
        <h3>比赛详情</h3> <span class="dialog-tool">
            <a title="关闭" class="dialog-close">X</a>
        </span>
    </div>
     <div class="dialogtitle"><ul><li class="cur">比赛信息</li><li>编辑比分</li></ul></div>
     <div class="clear"></div>
     <div class="dialogcon">
        <ul>
          <li class="cur">
             <p class=" tc"><b class="editUser1" uid=""></b>VS<b class="editUser2" uid=""></b></p>
             <table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
                <tbody>
                	<tr>
                        <th>球桌编号：</th>
                        <td>
                            <input id="editTableNum" value="" class="ued-text-2" maxlength="30" type="text">
                        </td>
                    </tr>
                    <tr>
                        <th>比赛类型：</th>
                        <td>
                            <select size="1" style="width:180px;" id="editType">
                                <option value="">未指定</option>
                                <option value="8">8球</option>
                                <option value="9">9球</option>
                            </select>

                        </td>
                    </tr>
                   <tr>
                        <th>开始时间：</th>
                        <td>
                             	<input id="editStartTime" value="" class="Wdate ued-text-2" maxlength="30" type="text" onClick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })" style="border: 1px solid #e5e5e5;height: 28px;padding-left: 10px;">
                        </td>

                    </tr>

                </tbody>
            </table>
          </li>
          <li>
              <h3 class="tit">选择胜者</h3>
              <div class="clearfix" style="width:180px; margin:0 auto"><span  class="btn editUser1"></span><span  class="btn editUser2"></span> </div>
               <h3 class="tit">输入比分</h3>
               <input type="hidden" id="editGameId"/>
                <table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
                <tbody>
                	<tr>
                        <th><span class="editUser1" uid=""></span>：</th>
                        <td>
                            <input id="editScore1" value="" class="ued-text-2" maxlength="30" type="text">
                        </td>
                    </tr>
                   <tr>
                        <th><span class="editUser2" uid=""></span>：</th>
                        <td>
                             <input id="editScore2"  value="" class="ued-text-2" maxlength="30" type="text">
                        </td>

                    </tr>

                </tbody>
            </table>
          </li>
        </ul>

     </div>

        <div class="pd-10 tc">
            <button type="button" class="ued-button-2 mgr-25" id="editBtn">保存修改</button>
            <button type="button" class="ued-button-3 dialog-close">取消</button>
        </div>

</div>
  <!--弹框编辑比分  e-->
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/lib/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/ui.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
<script type="text/javascript" src='${ctx}/back-ui/pub-ui/js/plugin/dragula.js'></script>
 <script type="text/javascript">

$(function() {
	showTab3List(1);
	var tabFlag = '${tabFlag}';
	 if(tabFlag=='editUser'){
		 $("li.liQuery").trigger("click");
	 }
	 $("#randomSort").bind("click",function(){
		 var obj = $(this);
		 var matchId=$("#matchId").val();
		  $.ajax({
			  type:"post",
			  url:ctx + "/back/match/edit/randomSort",
			  data:{
				  id: matchId
			  },
			  async:false,
			  dataType:"json",
			  success:function(json){
				  if(json.retCode == 0 ){
					  obj.parent().remove();
					  location.href=ctx + "/back/match/edit?matchId="+matchId+"&flag=editUser";
				  }else{
					  ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'比赛管理',
						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
						'ok':function(){},
						tag:'cw-ring'}
		               );
				  }
			  },
			  error:function(){
				  ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'比赛管理',
					text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
					'ok':function(){},
					tag:'cw-ring'}
	               );
			  }
		  });
	 });

    $("#generateGame").bind("click",function(){
        var matchId=$("#matchId").val();
        $.ajax({
            type:"post",
            url:ctx + "/back/match/edit/generateGame",
            data:{
                matchId: matchId
            },
            async:false,
            dataType:"json",
            success:function(json){
                if(json.retCode == 0 ){
                    ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                        {type:2,
                            info:'比赛管理',
                            text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
                            'ok':function(){
                                location.href=ctx + "/back/match/edit?matchId="+matchId+"&flag=editUser";
							},
                            tag:'zq-ring'}
                    );
                }else{
                    ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                        {type:2,
                            info:'比赛管理',
                            text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
                            'ok':function(){},
                            tag:'cw-ring'}
                    );
                }
            },
            error:function(){
                ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                    {type:2,
                        info:'比赛管理',
                        text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
                        'ok':function(){},
                        tag:'cw-ring'}
                );
            }
        });
    });
	//tab切换
	$(".dialogtitle ul li").live(
			"click",
			function() {
				var index_no = $(this).index();
				$(this).addClass("cur").siblings().removeClass("cur");
				$(".dialogcon ul li").eq(index_no).addClass("cur")
						.siblings().removeClass("cur");
			});
	//高度设置
	var contWrapH = $("div.ued-layout").height();
	$("#ued-ztree").css("height", contWrapH - 94);
	//ztree.json为你的url
	$("#ued-ztree").UED_tree();

	//弹出框
	$(".js_dialog").bind("click", function() {
		$("#btn-dialog").trigger("dialog-open");
	});
	$(".container i.mtch_del").click(function() {
		//判断比赛是否在进行中
		var matchStatus = $("#matchStatus").val();
		if(matchStatus!=0){
			var retInfo = "";
			if(matchStatus==-1){
				retInfo = "比赛已取消，无法删除参赛人员";
			}else if(matchStatus==1){
				retInfo = "比赛正在进行中，无法删除参赛人员";
			}else if(matchStatus==2){
				retInfo = "比赛已完成，无法删除参赛人员";
			}
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'比赛管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> '+retInfo+' </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
			return;
		}
		var userId = $(this).attr("dataValue");
		var userName = $(this).attr("dataName");
	  var obj = $(this);
	  var matchId=$("#matchId").val();
	  ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'比赛管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> 确定要删除用户【'+userName+'】？？ </div>',
				'ok':function(){
					 $.ajax({
						  type:"post",
						  url:ctx + "/back/match/edit/delUser",
						  data:{
							  id: userId
						  },
						  async:false,
						  dataType:"json",
						  success:function(json){
							  if(json.retCode == 0 ){
								  obj.parent().remove();
								  location.href=ctx + "/back/match/edit?matchId="+matchId+"&flag=editUser";
							  }else{
								  ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
								   {type:2,
									info:'比赛管理',
									text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
									'ok':function(){},
									tag:'cw-ring'}
					               );
							  }
						  },
						  error:function(){
							  ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
							   {type:2,
								info:'比赛管理',
								text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
								'ok':function(){},
								tag:'cw-ring'}
				               );
						  }
					  });
				},
				tag:'tx-ring'}
	              );

	});
	$(".js_template")
			.hover(
					function() {
						initDialog(this);
						$(this)
								.append(
										"<div class='matchbtn js_matchbtn'><i class='mtch_edit' title='编辑比分'></i><i class='mtch_see' title='查看比赛'></i></div>");
					}, function() {
						$(this).find(".js_matchbtn").remove();
					});
	//弹出框比分
	$(".mtch_edit").bind("click", function() {
		var matchStatus = $("#matchStatus").val();
		if(matchStatus!=0){
			var retInfo = "";
			if(matchStatus==-1){
				retInfo = "比赛已取消，无法编辑起始分";
			}else if(matchStatus==1){
				retInfo = "比赛正在进行中，无法编辑起始分";
			}else if(matchStatus==2){
				retInfo = "比赛已完成，无法编辑起始分";
			}
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'比赛管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> '+retInfo+' </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
			return;
		}
		var matchId = $(this).attr("dataValue");
		var userId = $(this).attr("userValue");
		var startScore = $(this).attr("startScore");
		$("#matchUserId").val(matchId);
		$("#startScore").val(startScore);
		$("#userId").val(userId);
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

	$("#btn-matchbtn span.btn:not('.active')").live("click", function() {
		$(this).addClass("active").siblings("span.btn").removeClass("active");
	});

	$("#editBtn").live("click", function(){
		var index = $("#btn-matchbtn .dialogcon li.cur").index();
		if(index == 0){ //比赛详情
			var startTime = $("#editStartTime").val();
			var tableNum = $("#editTableNum").val();
			var type = $("#editType").val();
			var gameId = $("#editGameId").val();
			$.ajax({
				type : "POST",
				url : "${ctx}/back/match/edit/updateGameInfo",
				dataType : "json",
				data : {
					startTime : startTime,
					tableNum : tableNum,
					type : type,
					gameId : gameId
				},
				success : function(data) {
					if (data.rsFlag) {
                        var $game = $("div.ued-tab-con div[gId='"+gameId+"']");
                        $game.attr("sTime", startTime);
                        $game.attr("gType", type);
                        $game.attr("tNum", tableNum);
						$(".dialog-close").trigger("click");
                        ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                            {type:2,
                                info:'比赛管理',
                                text:'<div style=" font-size:18px; color:#ff0000;"> 编辑成功 </div>',
                                'ok':function(){},
                                tag:'zq-ring'}
                        );
					}else{
                        ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                            {type:2,
                                info:'比赛管理',
                                text:'<div style=" font-size:18px; color:#ff0000;"> 编辑失败 </div>',
                                'ok':function(){},
                                tag:'cw-ring'}
                        );
					}
				}
			});
		}else if(index == 1){ //编辑比分
			if($(".editUser1").attr("uid") == "" || $(".editUser2").attr("uid") == "" ){
                ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                    {type:2,
                        info:'比赛管理',
                        text:'<div style=" font-size:18px; color:#ff0000;">比赛人员不全，不得编辑比分及胜者</div>',
                        'ok':function(){},
                        tag:'cw-ring'}
                );
				return;
			}
			var winId = $("#btn-matchbtn span.active").attr("uid");
			var score1 = $("#editScore1").val();
			var score2 = $("#editScore2").val();
			var gameId = $("#editGameId").val();
			$.ajax({
				type : "POST",
				url : "${ctx}/back/match/edit/updateScore",
				dataType : "json",
				data : {
					winId : winId,
					score1 : score1,
					score2 : score2,
					gameId : gameId
				},
				success : function(data) {
					if (data.rsFlag) {
						//编辑比分及胜者属性
						var $game = $("div.ued-tab-con div[gId='"+gameId+"']");
						$game.attr("wId", winId);
						$("#" + gameId + "_1").find("input").val(score1);
						$("#" + gameId + "_2").find("input").val(score2);

						moveUserToGame(gameId, "w"); //移动到胜者组
						moveUserToGame(gameId, "l"); //移动到败者组
						$(".dialog-close").trigger("click");
                        ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                            {type:2,
                                info:'比赛管理',
                                text:'<div style=" font-size:18px; color:#ff0000;"> 编辑成功 </div>',
                                'ok':function(){},
                                tag:'zq-ring'}
                        );
					}else{
                        ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                            {type:2,
                                info:'比赛管理',
                                text:'<div style=" font-size:18px; color:#ff0000;"> 编辑失败 </div>',
                                'ok':function(){},
                                tag:'cw-ring'}
                        );
					}
				}
			});
		}
	});
    initBoxWidth();

  //增加参赛人同
    $("#submitUser").bind("click",function(){
    	var id = $("#addUser").val();
    	$.ajax({
    		type:"post",
    		url:ctx+"/back/match/edit/addUser",
    		data:{
    			id:id,
    			matchId:$("#matchId").val()
    		},
    		dataType:"json",
    		success:function(json){
    			if(json.retCode == 0 ){
    				$("#btn-dialog").trigger("dialog-close");
    				var matchId=$("#matchId").val();
    				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
 	 					   {type:2,
 	 						info:'比赛管理',
 	 						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
 	 						'ok':function(){
 	 							$("#btn-dialog").trigger("dialog-close");
 	 							location.href=ctx + "/back/match/edit?matchId="+matchId+"&flag=editUser";
 	 						},
 	 						tag:'zq-ring'}
 	 		               );
    			}else{
    				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
  	 					   {type:2,
  	 						info:'比赛管理',
  	 						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
  	 						'ok':function(){},
  	 						tag:'cw-ring'}
  	 		               );
    			}
    		},
    		error:function(){
    			 ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
    					   {type:2,
    						info:'比赛管理',
    						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
    						'ok':function(){},
    						tag:'cw-ring'}
    		               );
    		}
    	});
    });

    $("#setStartScore").bind("click",function(){
    	$.ajax({
    		type:"post",
    		url:ctx+"/back/match/edit/setScore",
    		data:{
    			id:$("#matchUserId").val(),
    			score:$("#startScore").val(),
    			uid:$("#userId").val()
    		},
    		dataType:"json",
    		success:function(json){
    			if(json.retCode == 0 ){
    			$("#btn-fen").trigger("dialog-close");
    			var matchId=$("#matchId").val();
    				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
 	 					   {type:2,
 	 						info:'修改起始分',
 	 						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
 	 						'ok':function(){
 	 							$("#btn-dialog").trigger("dialog-close");
 	 							location.href=ctx + "/back/match/edit?matchId="+matchId+"&flag=editUser";
 	 						},
 	 						tag:'zq-ring'}
 	 		               );
    			}else{
    				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
  	 					   {type:2,
  	 						info:'修改起始分',
  	 						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
  	 						'ok':function(){},
  	 						tag:'cw-ring'}
  	 		               );
    			}
    		},
    		error:function(){
   			 ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
   					   {type:2,
   						info:'修改起始分',
   						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
   						'ok':function(){},
   						tag:'cw-ring'}
   		               );
   		}
    	});
    });
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

	function moveUserToGame(gameId, type){
		var $fromGame = $("div.ued-tab-con div[gId='"+gameId+"']");
		var nextSeq = null;
		var nextIndex = null;
		if($fromGame.attr(type + "Seq") != ""){
			var next = $fromGame.attr(type + "Seq");
			nextSeq = next.split("_")[0];
			nextIndex = next.split("_")[1];
		}
		
		if(nextSeq != null && nextSeq != "" && nextIndex != null && nextIndex != ""){
			var $toGame = $("div.ued-tab-con div[gSeq='"+nextSeq+"']");
			var userId = "";
			if(type == "w"){ //胜者
				userId = $fromGame.attr("wId");
			}else{ //败者
				userId = $fromGame.find("span[id!='" + $fromGame.attr("wId") + "']").attr("id");
			}
			var $fromGroup = $fromGame.find("#" + userId).parent();
			var $toGroup = $("#"+ $toGame.attr("gId") + "_" + nextIndex);
			$toGroup.html($fromGroup.html());
			$toGroup.children("input").val("");
		}
	}
	
		var dragFirstIndex, dragSecondIndex;
		dragula([document.getElementById('single1')])
	   .on("drag", function(el){
	        dragFirstIndex = $("#single1 div.gu-transit").index();
	   }).on("drop", function(el){
	   	   ui_com_hallpop(".js_collect","#ands_misoAlert_close","#ands-miso-popAlert",{type:1,text:'页面加载中请稍后.....'});
	       dragSecondIndex = $("#single1 div.gu-transit").index();
	       var userId = $("#single1 div.gu-transit .mtch_edit").attr("userValue");
	       var matchUId = $("#single1 div.gu-transit .mtch_edit").attr("dataValue");
	       $.ajax({
	       		type : "POST",
				url : "${ctx}/back/match/edit/dragUser",
				dataType : "json",
				data : {
					id : userId,
					matchId : $("#matchId").val(),
					matchUId : matchUId,
					firstIndex : dragFirstIndex,
					secondIndex : dragSecondIndex
				},
				success : function(data) {
					ui_com_hallpop(".js_collect","#ands_misoAlert_close","#ands-miso-popAlert",{type:4});	
				}
	       });
	   });
		function allowDrop(ev) {
			ev.preventDefault();
		}

		var srcdiv = null;

		function drag(ev, divdom) {
			srcdiv = divdom;
			ev.dataTransfer.setData("text/html", divdom.innerHTML);
		}

		function drop(ev, divdom) {
			ev.preventDefault();
			console.log('drop');
			if (srcdiv != divdom) {
				srcdiv.innerHTML = divdom.innerHTML;
				divdom.innerHTML = ev.dataTransfer.getData("text/html");

				var gameId1 = srcdiv.id.split("_")[0];
				var gameId2 = divdom.id.split("_")[0];
				var userIndex1 = srcdiv.id.split("_")[1];
				var userIndex2 = divdom.id.split("_")[1];
				var userId1 = $(srcdiv).find("span").attr("id");
				var userId2 = $(divdom).find("span").attr("id");
				$.ajax({
					type : "POST",
					url : "${ctx}/back/match/edit/exchange",
					dataType : "json",
					data : {
						gameId1 : gameId1,
						gameId2 : gameId2,
						userIndex1 : userIndex1,
						userIndex2 : userIndex2,
						userId1 : userId1,
						userId2 : userId2
					},
					success : function(data) {
						if (!data.rsFlag) {
							var tmp = divdom.innerHTML;
							divdom.innerHTML = srcdiv.innerHTML;
							srcdiv.innerHTML = tmp;
						}
					}
				});
			}
		}

		function initDialog(self) {
			$("#btn-matchbtn span.btn").removeClass("active");
			
			var $div1 = $(self).children("div:first");
			var $div2 = $(self).children("div:last");

			$(".editUser1").html($div1.find("span").html());
			$(".editUser1").attr("uid", $div1.find("span").attr("id"));

			$(".editUser2").html($div2.find("span").html());
			$(".editUser2").attr("uid", $div2.find("span").attr("id"));
			
			$("#editScore1").val($div1.find("input").val());
			$("#editScore2").val($div2.find("input").val());
			
			$("#editGameId").val($(self).attr("gId"));
			
			$("#editTableNum").val($(self).attr("tNum"));
			$("#editStartTime").val($(self).attr("sTime"));
			$("#editType").val($(self).attr("gType"));
			
			if($(self).attr("wId") != null && $(self).attr("wId") != ""){
				if($(self).attr("wId") == $div1.find("span").attr("id")){
					$("#btn-matchbtn span.editUser1").trigger("click");
				}else if($(self).attr("wId") == $div2.find("span").attr("id")){
					$("#btn-matchbtn span.editUser2").trigger("click");
				}
			}
		}
		
		function chgType(type){
			$('#editType').val(type);
		}
		
		function showTab3List(pageNum){
			$('#pageNumIn').val(pageNum);
            $.ajax({
				type : 'get',
				cache : false,
				async : true,
				url : "${ctx}/back/match/edit/tab3list",
				data : {
					pageNum : $('#pageNumIn').val(),
					matchId: $("#matchId").val()
				},
				dataType : "html",
				success : function(data){
					$('#tab3List').html(data);
					return;
				},
				error : function(json){
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
   					   {type:2,
   						info:'修改起始分',
   						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
   						'ok':function(){},
   						tag:'cw-ring'}
   		               );
					return;
				}
			});
        }
		
		//翻页
		function qry4Page(pageNum){
			showTab3List(pageNum);
		}
		
	</script>  
</body>
</html>
