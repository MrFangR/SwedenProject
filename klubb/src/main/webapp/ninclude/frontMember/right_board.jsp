<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/ninclude/import.jsp"%>
<%
// 右侧浮动栏
%>

<!--滚动导航-在线客服 star-->
<div class="roll-menu">
    <a href="${ctx}/myAccount">
    <div class="my">
    	<span class="roll-menu-link">个人中心</span>
    </div>
    </a>
    <a href="${ctx}/myFavorite">
    <div class="house">
    	<span class="roll-menu-link ">我的收藏</span>
    </div>
    </a>
    <a href="javascript:popQuick();">
    <div class="news">
    	<span class="roll-menu-link ">快速发布</span>
    </div>
    </a>
    <!-- 
    <a href="#none">
    <div class="history">
    	<span class="roll-menu-link ">浏览历史</span>
    </div>
    </a>
     -->
    <a href="#none">
     <div class="opinion  js_contrast-fold">
    	<span class="roll-menu-link ">加入对比</span>
    </div>
    </a>
   	<a href="javascript:message();">
     <div class="online">
    	<span class="roll-menu-link ">在线留言</span>
    </div>
    </a>
    <a href="http://cs.ecqun.com/mobile/rand?id=1828987" target="_blank">
     <div class="juan">
    	<span class="roll-menu-link ">在线咨询</span>
    </div>
    </a>
    <a href="http://t.qq.com/baitouweng8238" target="_blank">
    <div class="recharge">
    	<span class="roll-menu-link ">关注微博</span>
    </div>
    </a>
    <a href="#none">
    <div class="code">
    	<span class="roll-menu-link "><img  src="${ctx}/images/cord.jpg"  title="关注微信" /></span>
    </div>
    </a>
    <a href="#none">
    <div class="return">
    	<span class="roll-menu-link ">返回顶部</span>
    </div>
    </a>
</div>
<!--滚动导航-在线客服 end-->
<!--对比 star-->
<div class="contrast contrast-right js_contrast">
    <div class="contrast-unfold">
    	<h2 class="title-com4"><a href="#" class="a-hide">隐藏</a>对比栏</h2>
         <!--对比内容 star-->
                   <div class="tab-con ui-switchable-panel ui-switchable-panel-selected" style="display: block;">
                        <div class="diff-items clearfix" id="diff-items">
                        	<c:if test="${comparison == null }">
                        		<dl class="item-empty">
                                        <dt>1</dt>
                                        <dd>您还可以继续添加</dd>
                                </dl>
                                <dl class="item-empty">
                                        <dt>2</dt>
                                        <dd>您还可以继续添加</dd>
                                </dl>
                                <dl class="item-empty">
                                        <dt>3</dt>
                                        <dd>您还可以继续添加</dd>
                                </dl>
                                <dl class="item-empty">
                                        <dt>4</dt>
                                        <dd>您还可以继续添加</dd>
                                </dl>
                        	</c:if>
                        	<c:if test="${comparison != null }">
                        		<c:if test="${comparison.type == '1'}">
                        			<c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
                        				<dl fore="${status.index}" id="cmp_item_${shop.ID}" class="hasItem">  
	                                    	<dt><a href="${ctx}/shop/view?id=${shop.ID}" target="_blank"><img width="50" height="50" src="${uploadUrl}${shop.IMG_PATH}"></a>  </dt>  
	                                        <dd><a href="${ctx}/shop/view?id=${shop.ID}" class="diff-item-name" target="_blank">${shop.STREET_NAME}${shop.AREA}㎡转让</a>      
	                                        	<span class="p-price"><strong class="J-p-1510479">￥${shop.PRICE}元/年</strong><a  class="del-comp-item" href="javascript:delCom(${shop.ID},${comparison.type});" >删除</a></span>  
	                                        </dd>
	                                	</dl>
                        			</c:forEach>
                        			<c:if test="${comparison.num <= 4}">
                        				<c:forEach var="i" begin="${comparison.num+1}" end="4">
                        					<dl class="item-empty">
		                                        <dt>${i}</dt>
		                                        <dd>您还可以继续添加</dd>
		                                </dl>
                        				</c:forEach>
                        			</c:if>
                        		</c:if>
                        		<c:if test="${comparison.type == '2'}">
                        			
                        		</c:if>
                        	</c:if>
                         </div>
                         <div class="diff-operate">
                            <a class="btn-compare-b js_contrast_btn" href="#none" id="goto-contrast" target="_blank" >对比</a>
                            <a class="del-items" href="javascript:delComAll();">清空对比栏</a>
                         </div>
                 </div>
         <!--对比内容 end-->
        
         
    </div>
</div>
<!--对比 end-->
<!--对比弹出层 star-->
<div id="thick_bj"></div>
<div class="thick-content" style="overflow:auto; height:500px;">
	<div class="thick-top"><a href="#" class="thick-close">关闭</a><span class="fs18 font-f">对比栏</span><a href="#" class="empty">清空对比栏</a><span class="font-f font-gray fs14">温馨提示：对比支持4个商铺对比</span></div>
    <table border="0" width="100%" class="thick-table js_thick_table">
    	<c:if test="${comparison == null }">
    		<tr class="tr-bd">
    			<th class="th-left fs14" width="20%">商铺信息</th>
    			<th width="25%"></th>
    			<th width="25%"></th>
    			<th width="25%"></th>
    		</tr>
    		<tr>
        		<td class="td-first">租金</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	    	<tr>
	        	<th colspan="5" class="fs14 th-left">商铺属性</th>
	        </tr>
	        <tr>
	        	<td class="td-first">地址</td>
	            <td></td>
	            <td></td>
	            <td></td>
	             <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">面积</td>
	            <td></td>
	            <td></td>
	            <td></td>
	             <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">商铺现状</td>
	            <td></td>
	            <td></td>
	            <td></td>
	             <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">转让费</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">支付方式</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">合同年限</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">上下水</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">暖气</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">转让方式</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">行业</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">类型</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<td class="td-first">商铺特色</td>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	        <tr>
	        	<th colspan="5" class="fs14 th-left">外在因素</th>
	        </tr>
	        <tr>
	        	<td class="td-first">停车位</td>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	        </tr>
	        <tr>
	        	<td class="td-first">三相电</td>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	            <th class="th-left1"></th>
	        </tr>
    	</c:if>
    	<c:if test="${comparison != null }">
    		<c:if test="${comparison.type == '1'}">
    			<tr class="tr-bd">
            		<th class="th-left fs14" width="20%">商铺信息</th>
            		<c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
            			<th width="25%">
			            	<div class="position-rel">
			                    <a href="javascript:delCom(${shop.ID},${comparison.type});" class="th-close js_th_close"></a>
			                    <div class="contrast-title">
			                    	<p class="pdt-10 font-16 font-YaHei">${shop.STREET_NAME}${shop.AREA}㎡转让</p>
			                         <img src="${uploadUrl}${shop.IMG_PATH}" width="180" height="135" />
			                    </div>
			                </div>
			            </th>
    				</c:forEach>
    				<c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<th width="25%">
				            	<div class="position-rel">
				                    <a href="#" class="th-close js_th_close"></a>
				                    <div class="contrast-title">
				                    	<p class="pdt-10 font-16 font-YaHei"></p>
				                    </div>
				                </div>
				            </th>
                    	</c:forEach>
                    </c:if>
            	</tr>
            	<tr>
        			<td class="td-first">租金</td>
        			<c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
            			<td>${shop.PRICE}</td>
    				</c:forEach>
    				<c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
        		</tr>
            	<tr>
		        	<th colspan="5" class="fs14 th-left">商铺属性</th>
		        </tr>
		        <tr>
		        	<td class="td-first">地址</td>
		        	<c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
            			<td>${shop.SHOP_ADDRESS }</td>
    				</c:forEach>
    				<c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">面积</td>
		        	 <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.AREA }</td>
					</c:forEach>
					<c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		       	<tr>
		        	<td class="td-first">商铺现状</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.SHOP_STATUS == 1 }">经营中</c:when>
                        		<c:when test="${shop.SHOP_STATUS == 2 }">空置中</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">转让费</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.TRANSFER_FEE }元</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">支付方式</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.PAY_TYPE == 1 }">年付</c:when>
                        		<c:when test="${shop.PAY_TYPE == 2 }">半年付</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">合同年限</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.CONTRACT_YEAR }年</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">上下水</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.UP_LOW_WATER == 1 }">有</c:when>
                        		<c:when test="${shop.UP_LOW_WATER == 2 }">无</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">暖气</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.HEATING == 1 }">有</c:when>
                        		<c:when test="${shop.HEATING == 2 }">无</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">转让方式</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.lbStr }</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">行业</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.hyStr }</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">类型</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.lxStr }</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">商铺特色</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>${shop.tsStr }</td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<th colspan="5" class="fs14 th-left">外在因素</th>
		        </tr>
		        <tr>
		        	<td class="td-first">停车位</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.PARKING_SPACE == 1 }">有</c:when>
                        		<c:when test="${shop.PARKING_SPACE == 2 }">无</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
		        <tr>
		        	<td class="td-first">三相电</td>
		            <c:forEach var="shop" items="${comparison.shopList}" varStatus="status">
					   <td>
					   		<c:choose>
                        		<c:when test="${shop.THREE_PHASE_ELEC == 1 }">有</c:when>
                        		<c:when test="${shop.THREE_PHASE_ELEC == 2 }">无</c:when>
                        	</c:choose>
					   </td>
					</c:forEach>
		            <c:if test="${comparison.num <= 4}">
                    	<c:forEach var="i" begin="${comparison.num+1}" end="4">
                    		<td></td>
                    	</c:forEach>
                    </c:if>
		        </tr>
    		</c:if>
    	</c:if>
    </table>
</div>
<!--对比弹出层 end-->

<script  type="text/javascript" src="${ctx}/front-ui/js/quickRelease.js"></script>
<script type="text/javascript">
function message(){
	//补充登录页面
	$.ajax({
		url : "${ctx}/custMsg",
		type : 'post',
		async: false,//使用同步的方式,true为异步方式
		success : function(rtnObj){
			ui_com_hallpop(".js_fastfb", "#ands_misoAlert_close","#ands-miso-popAlert", {type : 6,info : '在线留言', text : rtnObj, mywidth : "500"});
		}
	});
}
function sumbitMes(){
	$.ajax({
    	type: "post",
		url:ctx+"/custMsg/save",
		async: false,
		data: $("#msgForm").serialize(),
		success : function(json){
			var result = json.rsFlag;
			if (result==true) {
				//alert(json.rsMsg);
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'提示信息',
					text:'<div style=" font-size:18px; color:#ff0000;">留言成功</div>您好，的留言已经提交，稍后会有管理员跟您联系！',
					'ok':function(){window.location.reload();},
					tag:'zq-ring'}
	               );
	            //$(".ands-miso-cover").remove();
				//$("#ands-miso-popAlert").hide();
			} else {
				showNotice(json);
				enableBtn();
			}
			
		},
		error : function(json){
			alert("系统异常，请稍后重试  json="+json);
			location.href=ctx;
		}
	  });
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
function disableBtn(){
	$("#mesBut").attr("disabled", "disabled");
}

function enableBtn(){
	$("#mesBut").attr("disabled", "");
}
function delCom(id,type){
	var param = {
		type:type,
		id:id
	};
	$.ajax({
    	type: "post",
		url:ctx+"/myComparison/delCom",
		async: false,
		data : param,
		success : function(json){
			window.location.reload(true);
		},
		error : function(json){
			alert("系统异常，请稍后重试  json="+json);
		}
	  });
}
function delComAll(){
	$.ajax({
    	type: "post",
		url:ctx+"/myComparison/delComAll",
		async: false,
		success : function(json){
			window.location.reload(true);
		},
		error : function(json){
			alert("系统异常，请稍后重试  json="+json);
		}
	  });
}
</script>