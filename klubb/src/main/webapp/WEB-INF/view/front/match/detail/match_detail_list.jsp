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
<input id="userList" type="hidden" value="${page }">
<input id="userTotalPage" type="hidden" value="${page.totalPage }">
<input id="userPageNum" type="hidden" value="${page.pageNumber }">
<table class="table-con">
  <tr class="table-tr-even">
    <th>报名顺序</th>
    <th>参赛人员姓名</th>
    <th>起始分</th>
  </tr>
  <c:forEach var="user" items="${page.list }">
  	<tr>
     <td>${user.SEQ }</td>
     <td>${user.NAME }</td>
     <td>${user.startScore }</td>
   </tr>
  </c:forEach>
</table>

