<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* 活动列表查询结果 */
%>

<div class="ued-title">
	<h4>查询结果</h4>
</div>
<div class="clearfix pdl-10 pdr-10">
	<ul class="ued-keys fl js_keys">
		<li><a class="amend" id="addUser">添加</a></li>
		<li><a class="amend" href="javascript:edit();">编辑</a></li>
	</ul>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	<colgroup>
		<col width="2%" />
		<col width="8%" />
		<col width="8%" />
		<col width="10%" />
		<col width="15%" />
		<col width="13%" />
		<col width="5%" />
		<col width="5%" />
		<col width="15%" />
		<col width="15%" />
	</colgroup>
	<tbody>
		<tr class="ued-tr-even">
			<th></th>
			<th>姓名</th>
			<th>昵称</th>
			<th>人口号</th>
			<th>邮箱</th>
			<th>手机号</th>
			<th>性别</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		
		<c:if test="${empty paginate.list}">
			<tr>
			<td colspan="10">抱歉，未查询到符合条件的记录</td>
			</tr>
		</c:if>
		<c:if test="${not empty paginate.list}">
			<c:forEach items="${paginate.list}" var="user">
				<tr class="ued-tr-odd">
					<td class="pdl-10">
						<input type="radio" name="userId" class="inp-radio" value="${user.ID}"/>
						<span class="b-radio"><b></b></span>
					</td>
					<td><a href="javascript:viewUser(${user.ID});">${user.NAME}</a></td>
					<td>${user.NICKNAME }</td>
					<td>${user.idNumber }</td>
					<td>${user.EMAIL }</td>
					<td>${user.PHONE }</td>
					<td>
						<c:choose>
							<c:when test="${user.GENDER eq 0}">
								<font class="color-4">女</font>
							</c:when>
							<c:when test="${user.GENDER eq 1}">
								<font class="color-5">男</font>
							</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${user.STATUS eq 0}">
								<font class="color-5">可用</font>
							</c:when>
							<c:when test="${user.STATUS eq 1}">
								<font class="color-4">不可用</font>
							</c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${user.createTime}" type="both"/></td>
					<td>
							<c:choose>
								<c:when test="${user.STATUS eq 0}">
						<button class="ued-button-4" onclick="delUser(${user.ID},'${user.NAME}',${user.STATUS})">
									禁用</button>
								</c:when>
								<c:when test="${user.STATUS eq 1}">
									<button class=".ued-button-7" onclick="delUser(${user.ID},'${user.NAME}',${user.STATUS})">启用</button>
								</c:when>
							</c:choose>
						<button class="ued-button-6" onclick="viewUser(${user.ID})">详情</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<div class="tc">
	<%@include file="/ninclude/back/page.jsp"%>
</div>

<script type="text/javascript">
$(function(){
	//弹出框比分
	$("#addUser").bind("click", function() {
		$("#btn-dialog").trigger("dialog-open");
	});
});
$(".b-radio").click(function(){
	$(this).closest("tbody").find(".b-radio").removeClass("bon-radio");
	$(this).addClass("bon-radio");
	$(this).siblings("input").attr("checked", "checked");
});

</script>
