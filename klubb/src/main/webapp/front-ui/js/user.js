/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2015-06-10 09:14:25
 * @version $Id$
 */
$(function(){
	$("#J_usEditBtn").on("click",function(){
		var docH=$(document).height();
		$('#J_comUserFix').css("height",docH+"px").removeClass('none');
		$('#J_comUserFixBox').removeClass('none');
	});

	$("#J_usBtn").on("click",function(){
		var userName=$("#J_usInfoUserName .us-ipt"),
			_userName=$.trim(userName.val()),
			usInfoQm=$("#J_usInfoQm .us-ipt"),
			_usInfoQm=$.trim(usInfoQm.val()),
			usInfoDate=$("#J_usInfoDate .us-ipt"),
			_usInfoDate=$.trim(usInfoDate.val()),
			usInfoZy=$("#J_usInfoZy .us-ipt"),
			_usInfoZy=$.trim(usInfoZy.val()),
			usInfoAddress=$("#J_usInfoAddress .us-ipt"),
			_usInfoAddress=$.trim(usInfoAddress.val());
		if(_userName==""){
			userName.addClass('border');
			$("#J_usInfoUserName .notice").html("昵称不能为空");
			return false;
		}
		if(_usInfoQm==""){
			usInfoQm.addClass('border');
			$("#J_usInfoQm .notice").html("签名不能为空");
			return false;
		}
		if(_usInfoDate==""){
			usInfoDate.addClass('border');
			$("#J_usInfoDate .notice").html("出生年月不能为空");
			return false;
		}
		if(_usInfoZy==""){
			usInfoZy.addClass('border');
			$("#J_usInfoZy .notice").html("职业不能为空");
			return false;
		}
	});
	tabChange($("#J_usNavUl > li.nav"),$("#J_usBody > .box"));
});
function usSafeToTwo(){
	$("#J_usSafeOne").addClass('none');
	$("#J_usSafeTwo").removeClass('none');
}
function usSafeToOne(){
	$("#J_usSafeOne").removeClass('none');
	$("#J_usSafeTwo").addClass('none');
}
function tabChange(navs,bodys){
	var old=0;
	for(var i=0,ii=navs.length;i<ii;i++){
		navs[i]._i=i;
		navs[i].onclick=function(){
			var index=this._i;
			if(old==index)return false;
			$(this).addClass("curr");
			$(navs[old]).removeClass("curr");
			$(bodys[index]).removeClass("none");
			$(bodys[old]).addClass("none");
			old=index;
		}
	}
}