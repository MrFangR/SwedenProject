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
		<li><a class="amend" href="javascript:edit();">编辑</a></li>
		<li><a class="amend" href="javascript:release();">发布</a></li>
	</ul>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	<colgroup>
		<col width="5%" />
		<col width="30%" />
		<col width="15%" />
		<col width="20%" />
		<col width="20%" />
		<col width="10%" />
	</colgroup>
	<tbody>
		<tr class="ued-tr-even">
			<th></th>
			<th>姓名</th>
			<th>手机号</th>
			<th>邮箱</th>
			<th>报名时间</th>
			<th>操作</th>
		</tr>
		
		<c:if test="${empty paginate.list}">
			<td colspan="3">暂时没有人报名</td>
		</c:if>
		<c:if test="${not empty paginate.list}">
			<c:forEach items="${paginate.list}" var="user">
				<tr class="ued-tr-odd">
					<td class="pdl-10">
						<input type="radio" name="userID" class="inp-radio" value="${user.ID}"/>
						<span class="b-radio"><b></b></span>
					</td>
					<td>${user.NAME}</td>
					<td>${user.phone}</td>
					<td>${user.EMAIL}</td>
					<td>${user.createTime}</td>
					<td>
						<button class="ued-button-4" onclick="cancleUser(${user.ID})">取消报名</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<script>
$(".b-radio").click(function(){
	$(this).closest("tbody").find(".b-radio").removeClass("bon-radio");
	$(this).addClass("bon-radio");
	$(this).siblings("input").attr("checked", "checked");
});
</script>
