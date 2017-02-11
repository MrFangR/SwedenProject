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
		<li><a class="amend" href="javascript:release();">新增</a></li>
	</ul>
</div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
	<colgroup>
		<col width="5%" />
		<col width="30%" />
		<col width="20%" />
		<col width="5%" />
		<col width="20%" />
		<col width="20%" />
	</colgroup>
	<tbody>
		<tr class="ued-tr-even">
			<th></th>
			<th>活动标题</th>
			<th>活动时间</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		
		<c:if test="${empty paginate.list}">
			<td colspan="3">抱歉，未查询到符合条件的记录</td>
		</c:if>
		<c:if test="${not empty paginate.list}">
			<c:forEach items="${paginate.list}" var="act">
				<tr class="ued-tr-odd">
					<td class="pdl-10">
						<input type="radio" name="activityID" class="inp-radio" value="${act.ID}"/>
						<span class="b-radio"><b></b></span>
					</td>
					<td><a href="javascript:viewAct(${act.ID});">${act.TITLE}</a></td>
					<td><fmt:formatDate value="${act.actTime}" type="both"/></td>
					<td>
						<c:choose>
							<c:when test="${act.STATUS eq 0}">
								<font class="color-4">未发布</font>
							</c:when>
							<c:when test="${act.STATUS eq 1}">
								<font class="color-5">正常</font>
							</c:when>
							<c:when test="${act.STATUS eq 2}">
								<font class="color-5">隐藏</font>
							</c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${act.createTime}" type="both"/></td>
					<td>
						<button class="ued-button-4" onclick="deleteAct(${act.ID},${act.STATUS})">删除</button>
						<button class="ued-button-6" onclick="hideAct(${act.ID},${act.STATUS})">隐藏</button>
						<c:if test="${act.STATUS}!=1">
							<button class="ued-button-4" onclick="ReRelease(${act.ID},${act.STATUS})">发布</button>
						</c:if>
						
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
$(".b-radio").click(function(){
	$(this).closest("tbody").find(".b-radio").removeClass("bon-radio");
	$(this).addClass("bon-radio");
	$(this).siblings("input").attr("checked", "checked");
});
</script>
