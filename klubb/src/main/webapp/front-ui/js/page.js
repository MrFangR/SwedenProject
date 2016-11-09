var _changePage;

/**
 * 设置分页信息
 * @param eleId 分页HTML展示的DOM的ID
 * @param data Page对象
 * @param changePage 回调函数，翻页功能实现
 */
function setPageInfo(eleId, data, changePage){
	_changePage = changePage;
	
	/**分页start**/
	var pageTotal = data.totalPage;
	var pageIndex = data.pageNumber;
	var showNum = 5; //分页连续显示几个数
	
	htmlStr = "";
	htmlStr += "<div class='paging mgtb-15 clearfix'>";
	if(pageIndex <= 1){ //第一页
		htmlStr += "    <a class='prev-on' href='javascript:;'>上一页</a>";
	}else{
		htmlStr += "    <a class='prev' href='javascript:;' onclick='_changePage(" + (pageIndex - 1) + ")'>上一页</a>";
	}
	if(pageTotal > 0){ //有页数
		if(pageTotal == 1){//只有1页
			htmlStr += "    <a href='javascript:;'>1</a>";
		}else{//不止一页
			if(pageIndex <= 1){ //第一页
				htmlStr += "    <a href='javascript:;' class='on'>1</a>";
			}else{
				htmlStr += "    <a href='javascript:;' onclick='_changePage(1)'>1</a>";
			}
			
			var startIndex = pageIndex - Math.floor(showNum/2);
			if(startIndex > pageTotal - showNum){
				startIndex = pageTotal - showNum;
			}
			if(startIndex <= 1){
				startIndex = 2;
			}
			var endIndex = startIndex + showNum;
			if(endIndex > pageTotal){
				endIndex = pageTotal;
			}
			
			if(startIndex > 2){ //需要显示...
				htmlStr += "    <em>...</em>";
			}
			
			for(var i = startIndex; i < endIndex; i++){
				if(pageIndex == i){
					htmlStr += "    <a href='javascript:;' class='on'>" + i + "</a>";
				}else{
					htmlStr += "    <a href='javascript:;' onclick='_changePage(" + i + ")'>" + i + "</a>";
				}
			}
			if(endIndex < pageTotal){ //需要显示...
				htmlStr += "    <em>...</em>";
			}
			if(pageIndex >= pageTotal){ //最后一页
				htmlStr += "    <a href='javascript:;' class='on'>" + pageTotal + "</a>";
			}else{
				htmlStr += "    <a href='javascript:;' onclick='_changePage(" + pageTotal + ")'>" + pageTotal + "</a>";
			}
		}
	}
	if(pageIndex >= pageTotal){ //最后一页
		htmlStr += "    <a class='next-on' href='javascript:;'>下一页</a>";
	}else{
		htmlStr += "    <a class='next' href='javascript:;' onclick='_changePage(" + (pageIndex + 1) + ")'>下一页</a>";
	}
	htmlStr += "    <span>到<input type='text' class='paging-text' style='color: rgb(153, 153, 153); font-weight: normal;'/>页</span>"
			+ "    <a class='bg-on' href='javascript:;' onclick='goToPage(this)'>确定</a>"
			+ "</div>";
	$("#" + eleId).html(htmlStr);
}

function goToPage(obj){
	var page = $(obj).siblings("span").find(".paging-text").val();
	if(page != null && page != ""){
		_changePage(page);
	}
}