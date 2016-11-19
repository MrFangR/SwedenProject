<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 <!--评论 S-->
	<div class="tabber">
        <div class="tab-item tab-comments">
            <i class="icon"></i>
            <h2 class="tab-title">评论</h2>
            <i class="arrow-d"></i>
		</div>
	</div>
	
	<div class="ct-dt-pl-main mgt-30 clearfix">
		<p class="tx-img fl"><img src="${ctx}/front-ui/images/ct_dt_pl_icon.png" alt=""></p>
		<div class="ct-dt-pl-right fl">
			<div class="ct-dt-pl-area">
				<textarea id="J_ctDtPlText" class="ct-dt-pl-textarea" name="context" rows="" cols="" maxlength="150" onfocus="if(this.value=='我来说两句...') {this.value='';}" onblur="if(this.value=='') {this.value='我来说两句...';}">我来说两句...</textarea>
				<p class="limit">还可输入150个字</p>	
			</div>
			<div class="ct-dt-pl-foot clearfix">
				<a id="J_ctDtPlFaceBtn" class="face fl" href="javascript:;"><i class="icon"></i>插入表情</a>
				<input id="objID" name="objID" type="hidden" value="${act.ID}"/>
				<input id="objType" name="objType" type="hidden" value="2"/>
				<input id="PID" name="PID" type="hidden" value="0"/>
				<input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
	            <input id="pageSizeIn" name="pageSize" type="hidden" value="3"/>
				<input name="evaluation" id="evaluation" onclick="saveEval()" class="btn fr" value="发表评论" type="button">
				<div id="J_ctDtPlFaceBox" class="ct-dt-pl-face">
					
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>

	<div class="pl-con">
		<!--评论 start-->
		<div class="ct-dt-pl-body mgt-5">
		</div>
        <!--评论 end-->
		<!--分页 start-->
		<div class="paging clearfix" id="pageDiv">
		</div>
		<!--分页 end-->  
</div>
<!--回复内容 start-->
<div id="js_huifucon" style="display:none">
	<div class="pub-mood-container pub-container-area2 mgt-10 mgb-25">
		<textarea class="pub-mood-txt pub-txt-area2"></textarea>
			<span>还可输入150个字</span>
			<ul class="pub-mood-footer">
			     <li class="fl pub-face js-reply-sure"><a href="javascript:void(0)">确定回复</a></li>
			</ul>
		</div>
</div>
<!--回复内容 end-->
<script type="text/javascript">
$(function(){
	showEvaluation(1);
	initReply();
});
function initReply(){
	$(".js_huifu").live("click",function(){
		$(this).parent().hide();
		$(this).parents(".ct-dt-pl").siblings().find(".pub-mood-container").remove();
		$(this).parents(".ct-dt-pl").siblings().find(".js_huifu").parent().show();
	});
	
	$(".js-reply-sure").live("click",function(){
		$("#evaForm #P_ID").val($(this).parents(".ct-dt-pl").find(".evaId").val());
		$("#evaForm #CONTENT").val($(this).parents(".ct-dt-pl").find(".pub-mood-txt").val());
		save();
	});
}

//保存评论
function saveEval(){
	var content = $("#J_ctDtPlText").val();
	$("#evaForm #CONTENT").val(content);
	$("#evaForm #P_ID").val("0");
	save();
}

function save(){
	var content = $("#evaForm #CONTENT").val();
	if(content == "我来说两句..."){
		return false;
	}
	if (content.trim().length == 0) {
		return false;
	}
	$.ajax({
		type : "POST",
		url : ctx + "/front/evaluation/addEva",
		dataType : "json",
		data : $("#evaForm").serialize(),
		success: function(data){
			alert(data.rsMsg);
			$("#J_ctDtPlText").val("");
			showEvaluation(1);
		}
	});
}

function showEvaluation(pageNum){
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'POST',
		url : ctx + "/front/evaluation/showEva",
		data: {
			objID : $("#evaForm #OBJ_ID").val(),
			objType : $("#evaForm #OBJ_TYPE").val(),
			pageNum : pageNum,
			pageSize : $('#pageSizeIn').val()
		},
		dataType : "json",
		success : function(data){
			var htmlStr = "";
			$.each(data.page.list, function(i, eva){
				htmlStr += "<dl class='ct-dt-pl clearfix'>"
							+ "	<dt class='face fl'><img class='comment-obj' src='${ctx}/front-ui/images/ct_dt_pl_icon.png' alt='头像'></dt>"
							+ "	<dd class='fr'>"
							+ "		<div class='row clearfix'>"
							+ "			<h5 class='nickname fl'>用户昵称：" + eva.NICKNAME + "</h5>"
							+ "			<span class='time fl'>" + eva.CREATE_TIME + "</span>"
							+ "		</div>"
							+ "		<input type='hidden' value='" + eva.ID + "' class='evaId'/>"
							+ "		<div class='context'>" + eva.CONTENT + "</div>";
				if(eva.replyList != null && eva.replyList != "" && eva.replyList != "undefined"){
					for(var i=0;i<eva.replyList.length;i++){
					htmlStr += "			<ul class='ct-dt-pl-reply'>"
							+"				<li>"
							+"					<div class='r-row clearfix'>"
							+"						<h5 class='r-nickname fl'>用户昵称：" + eva.replyList[i].NICKNAME + "</h5>"
							+"						<span class='r-time fl'>" + eva.replyList[i].CREATE_TIME + "</span>"
							+"					</div>"
							+"					<div class='r-context'>" + eva.replyList[i].CONTENT + "</div>"
							+"				</li>"
							+"			</ul>";
					};
				}
					htmlStr += "		<div class='ct-dt-pl-do'>";
					
						htmlStr += "			<a title='' href='javascript:;' class='js_huifu'>回复</a>";
					
					htmlStr += "		</div>";
							
				htmlStr += "	</dd>"
							+ "</dl>";
			});
			$(".ct-dt-pl-body").html(htmlStr);
				
			//设置分页
			setPageInfo("pageDiv", data.page, showEvaluation);
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
function replyEva(){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/evaluation/addEva",
		data: {
			context : $('#J_ctDtPlText').val(),
			objID : $('#objID').val(),
			objType : $('#objType').val(),
			PID : $('#PID').val()
		},
		dataType : "json",
		success : function(data){
			alert(data.rsMsg);
			showEvaluation(1);
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
</script>
