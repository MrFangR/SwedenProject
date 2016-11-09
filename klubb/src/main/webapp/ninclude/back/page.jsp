<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/*
		功能：分页
		用法：	1.使用时需在父页面request中setAttribute("paginate")
				2.父页面必须申明 翻页执行方法 function qry4Page(page)
	 */
%>
<c:if test="${not empty paginate}">
	<div class="ued-pading mgt-15 clearfix">
		<span>共&nbsp;<font class="color-3">${paginate.totalRow}</font>&nbsp;条记录</span>
		<span>共&nbsp;<font class="color-3">${paginate.totalPage}</font>&nbsp;页</span>
		<c:choose>
			<c:when test="${paginate.pageNumber < 2}">
				<a href="javascript:void(0);" class="bg-on">首页</a>
				<a href="javascript:void(0);" class="prev-on">上一页</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:qryFirstPage();">首页</a>
				<a href="javascript:qryPrevPage();" class="prev">上一页</a>
			</c:otherwise>
		</c:choose>
		<a href="javascript:void(0);" class="on">${paginate.pageNumber}</a>
		<c:choose>
			<c:when test="${paginate.pageNumber >= paginate.totalPage}">
				<a href="javascript:void(0);" class="next-on">下一页</a>
				<a href="javascript:void(0);" class="bg-on">末页</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:qryNextPage();" class="next">下一页</a>
				<a href="javascript:qryLastPage();">末页</a>
			</c:otherwise>
		</c:choose>
		<span>到<input type="text" class="ued-pading-text" id="pageTo"/>页</span>
		<a href="javascript:jumpToPage();">确定</a>
	</div>


	<script>
	var qryMethodName = "qry4Page";// 指定的翻页执行方法封装后方法名，必须在父页面什么同名同参方法 格式：function qry4Page(page);
	var currPage = Number(${paginate.pageNumber});
	var totalPage = Number(${paginate.totalPage});
	
	// 查询首页
	function qryFirstPage(){
		if (currPage <= 1) {
			pop.fail("当前已经是首页。");
			return;
		}
		doQryMethod(1);
	}
	// 查询上一页
	function qryPrevPage(){
		if (currPage <= 1) {
			pop.fail("当前已经是首页。");
			return;
		}
		doQryMethod(currPage-1);
	}
	// 查询下一页
	function qryNextPage(){
		if (currPage == totalPage) {
			pop.fail("当前已经是末页。");
			return;
		}
		doQryMethod(currPage+1);
	}
	// 查询末页
	function qryLastPage(){
		if (currPage == totalPage) {
			pop.fail("当前已经是末页。");
			return;
		}
		doQryMethod(totalPage);
	}
	// 跳转到
	function jumpToPage(){
		var pageTo = $("#pageTo").val();
		if (pageTo == "") {
			pop.fail("请输入要跳转的页数", function(){
				$("#pageTo").focus();
			});
			return;
		}
		pageTo = Number(pageTo);
		if (pageTo<1 || pageTo>totalPage) {
			pop.fail("请输入1-"+totalPage+"之间的页数", function(){
				$("#pageTo").focus();
			});
			return;
		}
		doQryMethod(pageTo);
	}
	
	// 封装的翻页方法
	function doQryMethod(page){
		try{
			if(typeof(eval(qryMethodName)) == "function"){
				eval(qryMethodName+"("+Number(page)+")");
				return;
			}else{
				pop.fail("请求失败，请稍后重试！");
				return;
			}
		}catch(e){
			pop.fail("翻页方法未定义，请确认！");
			return;
		}
	}
	</script>
</c:if>