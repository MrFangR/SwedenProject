<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${CONTEXT_PATH}"/>
<script>
		var ctx = "${ctx}";
</script>
<%
	/* 比赛列表查询结果 */
%>
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
							<c:if test="${empty paginate.list}">
								<tr><td colspan="7">抱歉，未查询到符合条件的记录</td></tr>
							</c:if>
							<c:if test="${not empty paginate.list}">
								<c:forEach items="${paginate.list}" var="user">
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
<div class="tc">
	<%@include file="/ninclude/back/page.jsp"%>
</div>

