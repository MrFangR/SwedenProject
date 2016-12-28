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
            <!--比赛标题  s-->
            <div class="matchtitle">
            	<c:forEach items="${titleList}" var="title">
	               <li>${title}</li>
            	</c:forEach>
               <div class="clear"></div>
            </div>
            <!--比赛标题  e-->
            <c:forEach items="${list}" var="gList" varStatus="status">
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
	                    <div class="template">
	                        <h3>${game.SEQ }</h3>
	                    <div class="group" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i>${game.u1_SEQ }</i><span>${game.u1_NAME }</span><input name="" type="text" value="10"></div>
	                    <div class="group" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i>${game.u2_SEQ }</i><span>${game.u2_NAME }</span><input name="" type="text" value="4"></div>
	                    </div>  
            		</c:if>
                    <c:if test="${gStatus.index mod 2 == 1}">
                    <div class="template ${tempMgt[status.index]}">
                        <h3>${game.SEQ }</h3>
                        <div class="group" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i>${game.u1_SEQ }</i><span>${game.u1_NAME }</span><input name="" type="text" value="0"></div>
                        <div class="group" <c:if test="${status.index == 0 }"> ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"</c:if>><i>${game.u2_SEQ }</i><span>${game.u2_NAME }</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="${svgHeight[status.index] }px">
                          <path d="M 228 1 L 236 1 L 236 ${svgHeight[status.index] } " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="${svgHeight[status.index] }px" style="margin-top:-6px">
                            <path d="M 228,${svgHeight[status.index] } L 236,${svgHeight[status.index] }  L 236,1  L 244,1" class="bracket-line"/>
                        </svg>
                    </div>
                  </div>
                  </c:if>
                  <!--完整模板  e--> 
            	</c:forEach>
            	</div>
            </c:forEach>
            
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
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/lib/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/ui.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
<script type="text/javascript" src='${ctx}/back-ui/pub-ui/js/plugin/dragula.js'></script>
 <script type="text/javascript"> 
 $(function(){
	 
	  //高度设置
    var contWrapH = $("div.ued-layout").height();
    $("#ued-ztree").css("height",contWrapH-94);
	//ztree.json为你的url
	$("#ued-ztree").UED_tree();
	
	//弹出框
	$(".js_dialog").bind("click",function(){		
        $("#btn-dialog").trigger("dialog-open");
	})
	 $(".container i.mtch_del").click(function(){
		  $(this).parent().remove();
		    
		 })
	 
	 
	 })
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
