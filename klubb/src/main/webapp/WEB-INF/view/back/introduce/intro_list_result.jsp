<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* 会员管理查询结果 */
%>

<div class="ued-title">
	<h4>查询结果</h4>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	<colgroup>
		<col width="30%" />
		<col width="40%" />
		<col width="20%" />
		<col />
	</colgroup>
	<tbody>
		<tr class="ued-tr-even">
			<th>类型</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		
		<c:if test="${empty list}">
			<td colspan="3">抱歉，未查询到符合条件的记录</td>
		</c:if>
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="intro">
				<tr class="ued-tr-odd">
					<td>
						<c:choose>
							<c:when test="${intro.TYPE eq 1}">
								<font class="color-4">台球厅介绍</font>
							</c:when>
							<c:when test="${intro.TYPE eq 2}">
								<font class="color-5">人员介绍</font>
							</c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${intro.createTime}" type="both"/></td>
					<td>
						<a class="mgr-10" href="javascript:;" onclick="edit('${intro.ID}')">[编辑]</a>
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
