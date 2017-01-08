<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：比赛管理</div>
	
	<div class="ued-tab js_tab">
        <!--tab  s-->
        <div class="ued-tab-tit clearfix js_tab_tit">
            <ul class="ued-tab-1 fl clearfix">
                <li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑对阵图</a></li>
                <li class="liQuery"><a class="ued-see" href="javascript:void(0)">编辑参与者</a></li>
                
            </ul>
    
        </div>
        <!--tab  e-->
        <!--tabcon  s-->
        <div class="ued-tab-con mgt-20">	
               <!--第一tab  一列是320px 目前展示5列宽为1600px  如果对阵图列数超过3需要代码判断列数给 box-n div 输入宽度 s-->
            <c:set var="boxMgt" value="${fn:split(' , ,mgt-20,mgt-160,mgt-20', ',') }" />
            <c:set var="groupMgt" value="${fn:split('mgt-60,mgt-80,mgt-200,mgt-200,mgt-230', ',') }" />
            <c:set var="tempMgt" value="${fn:split('mgt-60,mgt-200,mgt-300,mgt-400', ',') }" />
            <c:set var="svgHeight" value="${fn:split('76,140,140,140', ',') }" />
            <div class="box-n on1" style="width:1600px;">
            <div class="clearfix">
            <!--比赛标题  s-->
            <div class="matchtitle">
            	<c:forEach items="${winTitleList}" var="title">
	               <li>${title}</li>
            	</c:forEach>
               <div class="clear"></div>
            </div>
            <!--比赛标题  e-->
            <c:forEach items="${winList}" var="gList" varStatus="status">
            	<c:if test="${status.index == 0}">
            		<!--可拖动部分  s-->
                     <div class="dropbox">
            	</c:if>
            	<c:if test="${status.index > 0}">
            		<!--可拖动部分  s-->
                     <div class="nodrop ${boxMgt[status.index]}">
            	</c:if>
            	<c:forEach items="${gList}" var="game" varStatus="gStatus">
            		<c:if test="${gStatus.index mod 2 == 0}">
	            		<!--完整模板  s-->
	            		<c:choose>
	            			<c:when test="${game.SEQ == 1}">
	            				<div class="matchgroup">
	            			</c:when>
	            			<c:otherwise>
	            				<div class="matchgroup ${groupMgt[status.index]}">
	            			</c:otherwise>
	            		</c:choose>
	                    <div wId="${game.winnerId }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template">
	                        <h3>${game.SEQ }</h3>
	                    <div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
	                    <div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
	                    </div>  
            		</c:if>
                    <c:if test="${gStatus.index mod 2 == 1}">
                    <div wId="${game.winnerId }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template ${tempMgt[status.index]}">
                        <h3>${game.SEQ }</h3>
                        <div class="group" id="${game.ID }_1" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
                        <div class="group" id="${game.ID }_2" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
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
                  <!--完整模板  e--> 
            	</c:forEach>
            	</div>
            </c:forEach>
            </div>
            </div>

			<div class="clearfix mgt-40">
            <!--比赛标题  s-->
            <div class="matchtitle">
            	<c:forEach items="${loseTitleList}" var="title">
	               <li>${title}</li>
            	</c:forEach>
               <div class="clear"></div>
            </div>
            <!--比赛标题  e-->
            <c:forEach items="${loseList}" var="gList" varStatus="status">
       			<!--可拖动部分  s-->
                <div class="nodrop ${boxMgt[status.index]}">
            	<c:forEach items="${gList}" var="game" varStatus="gStatus">
            		<c:if test="${status.index mod 2 == 0}">
	            			<!--完整模板  s-->
		            		<c:choose>
		            			<c:when test="${status.index == 0 and gStatus.index == 0}">
		            				<div class="matchgroup">
		            			</c:when>
		            			<c:otherwise>
		            				<div class="matchgroup ${groupMgt[status.index]}">
		            			</c:otherwise>
		            		</c:choose>
            			<div wId="${game.winnerId }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template ${tempMgt[status.index * 2 + 1]}">
	                        <h3>${game.SEQ }</h3>
	                    <div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER2 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
	                    <div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
	                    </div>
	                    <c:if test="${not status.last }">
		                    <div class="matchline">
		                       <svg  x="0" y="0" width="290px" height="${svgHeight[status.index] }px" style="margin-top:-${svgHeight[status.index] }px">
		                          <path d="M 228,${svgHeight[status.index] } L 236,${svgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
		                        </svg>
		                     </div>
	                    </c:if>
	                    </div>
            		</c:if>
            		
            		
            		
            	
            		<c:if test="${status.index mod 2 == 1}">
	            		<c:if test="${gStatus.index mod 2 == 0}">
		            		<!--完整模板  s-->
		            		<c:choose>
		            			<c:when test="${game.SEQ == 1}">
		            				<div class="matchgroup">
		            			</c:when>
		            			<c:otherwise>
		            				<div class="matchgroup ${groupMgt[status.index]}">
		            			</c:otherwise>
		            		</c:choose>
		                    <div wId="${game.winnerId }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template">
		                        <h3>${game.SEQ }</h3>
		                    <div class="group" id="${game.ID }_1" ><i><c:if test="${game.u1_SEQ != 0}">${game.u1_SEQ}</c:if></i><span id="${game.USER1 }">${game.u1_NAME }</span><input name="" type="text" value="${game.SCORE1 }"></div>
		                    <div class="group" id="${game.ID }_2" ><i><c:if test="${game.u2_SEQ != 0}">${game.u2_SEQ}</c:if></i><span id="${game.USER2 }">${game.u2_NAME }</span><input name="" type="text" value="${game.SCORE2 }"></div>
		                    </div>  
	            		</c:if>
	                    <c:if test="${gStatus.index mod 2 == 1}">
	                    <div wId="${game.winnerId }" gSeq="${game.SEQ }" gId="${game.ID}" wSeq="${game.WNextId}" lSeq="${game.LNextId}" class="template js_template ${tempMgt[status.index]}">
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
                  <!--完整模板  e--> 
                  </c:if>
            	</c:forEach>
            	</div>
            </c:forEach>
            </div>
            </div>
            
             <!--第一tab  e-->
             <!--第二tab  s-->
            <div class="box-n">
                    <div id='single1' class='container'>
                        <div>1, but you can only drop me somewhere in this container. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>2If you try to drop me somewhere other than here, I'll die a fiery death. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 3. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 4. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 5. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 6. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                   </div>

                  <div class="tc" style="width:60%; margin-top:30px;"><button class="ued-button-2 js_dialog">添加人员</button></div>
             </div>
            <!--第二tab  e-->
        </div>
        <!--tabcon  e-->

</div>
  <!--弹框  s-->
 <div data-role="ued-dialog" class="ued-dialog" id="btn-dialog">
    <div class="dialog-header">
        <h3>添加参数人员</h3>
        <span class="dialog-tool">
            <a title="关闭" class="dialog-close">X</a>
        </span>
    </div>
    <div>
        <p class="pd-20 dialog-tipInfo clearfix">姓名：
        <select size="1" style="width:180px;">
          <option>昌盛</option>
          <option>lijianghui</option>
          <option>王二小</option>
       </select>
       </p>
        <div class="pd-10 tc">
            <button type="button" class="ued-button-2 mgr-25">保存</button>
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
             <p class=" tc"><b class="editUser1" uid="">王二小</b>VS<b class="editUser2" uid="">昌盛</b></p>
             <table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
                <tbody>
                	<tr>
                        <th>设置：</th>
                        <td>
                            <input value="" class="ued-text-2" maxlength="30" type="text">     
                        </td>
                    </tr>
                   <tr>
                        <th>计划时间：</th>
                        <td>
                             <input value="" class="ued-text-2" maxlength="30" type="text"> 
                        </td>
                    
                    </tr>
                  
                </tbody>
            </table>
          </li>
          <li>
              <h3 class="tit">选择胜者</h3>
              <div class="clearfix" style="width:180px; margin:0 auto"><span  class="btn editUser1">王二小</span><span  class="btn editUser2">昌盛</span> </div>
               <h3 class="tit">输入比分</h3>
               <input type="hidden" id="editGameId"/>
                <table class="ued-table-nobor mgt-15" width="100%" cellspacing="0" cellpadding="0">
                <tbody>
                	<tr>
                        <th><span class="editUser1" uid="">王二小</span>：</th>
                        <td>
                            <input id="editScore1" value="" class="ued-text-2" maxlength="30" type="text">     
                        </td>
                    </tr>
                   <tr>
                        <th><span class="editUser2" uid="">昌盛</span>：</th>
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
		$(this).parent().remove();

	})
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
			
		}else if(index == 1){ //编辑比分
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
						alert("编辑成功");
					}else{
						alert("编辑失败");
					}
				}
			});
		}
	});
});

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
	
		dragula([ single1 ], {
			removeOnSpill : true
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
			
			if($(self).attr("wId") != null && $(self).attr("wId") != ""){
				if($(self).attr("wId") == $div1.find("span").attr("id")){
					$("#btn-matchbtn span.editUser1").trigger("click");
				}else if($(self).attr("wId") == $div2.find("span").attr("id")){
					$("#btn-matchbtn span.editUser2").trigger("click");
				}
			}
		}
	</script>  
</body>
</html>
