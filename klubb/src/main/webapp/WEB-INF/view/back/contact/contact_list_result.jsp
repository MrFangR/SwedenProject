<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* 会员管理查询结果 */
%>

<div class="ued-title">
	<h4>查询结果</h4>
</div>
<div class="clearfix pdl-10 pdr-10">
	<ul class="ued-keys fl js_keys">
		<li><a class="start" href="javascript:updateStatus(0);">标记为未读</a></li>
		<li><a class="del" href="javascript:updateStatus(1);">标记为已读</a></li>
	</ul>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	<colgroup>
		<col width="5%" />
		<col width="15%" />
		<col width="15%" />
		<col width="30%" />
		<col width="10%" />
		<col width="10%" />
		<col />
	</colgroup>
	<tbody>
		<tr class="ued-tr-even">
			<th></th>
			<th>姓名</th>
			<th>手机号</th>
			<th>留言内容</th>
			<th>创建时间</th>
			<th>状态</th>
		</tr>
		
		<c:if test="${empty paginate.list}">
			<td colspan="6">抱歉，未查询到符合条件的记录</td>
		</c:if>
		<c:if test="${not empty paginate.list}">
			<c:forEach items="${paginate.list}" var="contact">
				<tr class="ued-tr-odd">
					<td class="pdl-10">
						<input type="radio" name="contactId" class="inp-radio" value="${contact.ID}"/>
						<span class="b-radio"><b></b></span>
					</td>
					<td>${contact.NAME}</td>
					<td>${contact.PHONE}</td>
					<td>${contact.CONTENT}</td>
					<td><fmt:formatDate value="${contact.createTime}" type="both"/></td>
					<td>
						<c:choose>
							<c:when test="${contact.STATUS eq 0}">
								<font class="color-4">未读</font>
							</c:when>
							<c:when test="${contact.STATUS eq 1}">
								<font class="color-5">已读</font>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>

<div class="tc">
	<%@include file="/ninclude/back/page.jsp"%>
</div>


<script>
$(".b-radio").click(function(){
	$(this).closest("tbody").find(".b-radio").removeClass("bon-radio");
	$(this).addClass("bon-radio");
	$(this).siblings("input").attr("checked", "checked");
});
</script>
