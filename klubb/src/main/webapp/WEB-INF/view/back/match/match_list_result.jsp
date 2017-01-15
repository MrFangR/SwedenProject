<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* 比赛列表查询结果 */
%>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ued-table mgt-20">
    <tbody>
        <tr class="ued-tr-even">
            <th>序号<i class="ued-cor-d"></i></th>
            <th>比赛名称<i class="ued-cor-d"></i></th>
            <th>比赛制度<i class="ued-cor-up"></i></th>
            <th>参与人数</th>
            <th>比赛时间</th>
            <th>比赛状态</th>
            <th>操作</th>
        </tr>
        <c:if test="${empty paginate.list}">
			<td colspan="3">抱歉，未查询到符合条件的记录</td>
		</c:if>
		<c:if test="${not empty paginate.list}">
			<c:forEach items="${paginate.list}" var="match">
				<tr class="ued-tr-odd">
					<td>${match.ID}</td>
		            <td>${match.NAME}</td>
		            <td>
		            	<c:choose>
							<c:when test="${match.TYPE eq 1}">单败</c:when>
							<c:when test="${match.TYPE eq 2}">双败</c:when>
							<c:when test="${match.TYPE eq 3}">单败plus</c:when>
							<c:when test="${match.TYPE eq 4}">双败plus</c:when>
						</c:choose>
		            </td>
		            <td>${match.playerNum}</td>
		            <td><fmt:formatDate value="${match.startDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
		            <td>
		            	<c:choose>
							<c:when test="${match.STATUS eq -1}">已取消</c:when>
							<c:when test="${match.STATUS eq 0}">未开始</c:when>
							<c:when test="${match.STATUS eq 1}">进行中</c:when>
							<c:when test="${match.STATUS eq 2}">已完成</c:when>
						</c:choose>
		            </td>
		            <td>
		            	<c:choose>
							<c:when test="${match.STATUS eq 0}">
								<a href="javascript:;" onclick="startMat(${match.ID})">开始比赛</a>
							</c:when>
						</c:choose>
		            	
		            	<a href="javascript:;" onclick="cancleMat(${match.ID},${match.STATUS})" class="js_collect2">取消比赛</a>
		            	<a href="#none">编辑对阵图</a>
		            </td>
				</tr>
			</c:forEach>
		</c:if>
        <tr class="ued-tr-odd">
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
