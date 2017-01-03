<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：<a href="#none">比赛列表</a>&nbsp;&gt;&nbsp;编辑参与者</div></div>
	<!--面包屑 e-->
	<div class="ued-tab js_tab">
        <!--tab  s-->
        <div class="ued-tab-tit clearfix js_tab_tit">
            <ul class="ued-tab-1 fl clearfix">
                <li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑对阵图</a></li>
                <li class="liQuery"><a class="ued-see" href="javascript:void(0)">编辑参与者</a></li>
                <li class="liLook"><a class="ued-see" href="javascript:void(0)">查看参与者</a></li>
            </ul>
    
        </div>
        <!--tab  e-->
        <!--tabcon  s-->
        <div class="ued-tab-con mgt-20">	
               <!--第一tab  一列是320px 目前展示5列宽为1600px  如果对阵图列数超过3需要代码判断列数给 box-n div 输入宽度 s-->
            <div class="box-n on1" style="width:1600px;">
	            <!--比赛标题  s-->
	            <div class="matchtitle">
	               <li>第一轮</li>
	               <li>第二轮</li>
	               <li>第三轮</li>
	               <li>半决赛</li>
	               <li>决赛</li>
	               <div class="clear"></div>
	            </div>
	            <!--比赛标题  e-->
              
            </div>
             <!--第一tab  e-->
             <!--第二tab  s-->
            <div class="box-n">
                    <div id='single1' class='container'>
                        <div>2If you try to drop me somewhere other than here, I'll die a fiery death. <i class="mtch_del"></i></div>
						<c:forEach var="user" items="${matchUser.list }">
							<div>${user.NAME } <i class="mtch_del" dataValue="${user.ID }"></i></div>
						</c:forEach>
						<!-- 
                        <div>Item 3. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 4. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 5. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 6. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
						 -->
                   </div>

                  <div class="tc" style="width:60%; margin-top:30px;"><button class="ued-button-2 js_dialog">添加人员</button></div>
             </div>
            <!--第二tab  e-->
            <!-- 第三个tab s -->
           	<div class="box-n">
	            <div>
	            	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	            		<colgroup>
	            			<col width="5%" />
							<col width="10%" />
							<col width="5%" />
							<col width="15%" />
							<col width="15%" />
							<col width="10%" />
							<col width="10%" />
							<col width="30%" />
	            		</colgroup>
	            		<tbody>
	            			<tr class="ued-tr-even">
								<th>排序</th>
								<th>姓名</th>
								<th>性别</th>
								<th>邮箱</th>
								<th>手机号</th>
								<th>起始分</th>
								<th>报名时间</th>
							</tr>
							<c:if test="${empty allMatchUser}">
								<tr><td colspan="7">抱歉，未查询到符合条件的记录</td></tr>
							</c:if>
							<c:if test="${not empty allMatchUser}">
								<c:forEach items="${allMatchUser}" var="user">
									<tr class="ued-tr-odd">
										<td class="pdl-10">${user.SEQ }</td>
										<td>${user.NAME }</td>
										<td>
											<c:choose>
												<c:when test="${user.GENDER eq 0}">
													女
												</c:when>
												<c:when test="${user.GENDER eq 1}">
													男
												</c:when>
											</c:choose>
										</td>
										<td>${user.EMAIL }</td>
										<td>${user.PHONE }</td>
										<td>
											<c:choose>
												<c:when test="${empty user.startScore}">
													<font class="color-4">未设置</font>
												</c:when>
												<c:otherwise>
													${user.startScore }
												</c:otherwise>
											</c:choose>
										</td>
										<td>${user.createTime }</td>
									</tr>
								</c:forEach>
							</c:if>
	            		</tbody>
	            	</table>
	            </div>
           	</div>
            <!-- 第三个tab e -->
        </div>
        <!--tabcon  e-->

	</div>
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
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
 <script type="text/javascript" src='${ctx}/back-ui/pub-ui/js/plugin/dragula.js'></script>
<script type="text/javascript"> 
 $(function(){
	 
	 $(".js_template").hover(
		  function() {
			$(this).append("<div class='matchbtn js_matchbtn'><i class='mtch_edit' title='编辑比分'></i><i class='mtch_see' title='查看比赛'></i></div>");
		  },
		  function () {
			$(this).find(".js_matchbtn").remove();
		  }
		);
			 
	 
	 //tab切换
	 
	  $(".dialogtitle ul li").live("click",function(){
		   var index_no = $(this).index();
		     $(this).addClass("cur").siblings().removeClass("cur");
			 $(".dialogcon ul li").eq(index_no).addClass("cur").siblings().removeClass("cur");
		  });
	 
	 
	  //高度设置
    var contWrapH = $("div.ued-layout").height();
    $("#ued-ztree").css("height",contWrapH-94);
	//ztree.json为你的url
	$("#ued-ztree").UED_tree();
	
	//弹出框
	$(".js_dialog").bind("click",function(){	
        $("#btn-dialog").trigger("dialog-open");
	});
	 $(".container i.mtch_del").click(function(){
		  var userId = $(this).attr("dataValue");
		  var obj = $(this);
		  $.ajax({
			  type:"post",
			  url:ctx + "/back/match/editUser/delUser",
			  data:{
				  id: userId
			  },
			  async:false,
			  dataType:"json",
			  success:function(json){
				  if(json.retCode == 0 ){
					  obj.parent().remove();
					  location.href=ctx + "/back/match/editUser";
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
		 
    //编辑比分弹框
	$(".js_matchbtn").live("click",function(){		
        $("#btn-matchbtn").trigger("dialog-open");
	});
    
    //增加参赛人同
    $("#submitUser").bind("click",function(){
    	var id = $("#addUser").val();
    	$.ajax({
    		type:"post",
    		url:ctx+"/back/match/editUser/addUser",
    		data:{
    			id:id
    		},
    		dataType:"json",
    		success:function(json){
    			if(json.retCode == 0 ){
    				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
 	 					   {type:2,
 	 						info:'比赛管理',
 	 						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
 	 						'ok':function(){
 	 							$("#btn-dialog").trigger("dialog-close");
 	 							location.href=ctx + "/back/match/editUser";
 	 							$(".liQuery").addClass("on1").siblings().removeClass("on1");
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
	 
	 
	 });
  	dragula([single1], { removeOnSpill: true });
    function allowDrop(ev)  
    {  
    	ev.preventDefault();  
    }  
      
    var srcdiv = null;  
    function drag(ev,divdom)  
    {  
	    srcdiv=divdom;  
	    ev.dataTransfer.setData("text/html",divdom.innerHTML);  
    }  
      
    function drop(ev,divdom)  
    {
	    ev.preventDefault();  
	    if(srcdiv != divdom){  
	    srcdiv.innerHTML = divdom.innerHTML;  
	    divdom.innerHTML=ev.dataTransfer.getData("text/html");  
	    }  
    }
    
    </script>  
</body>
</html>
