// JavaScript Document

$(function() {
	 //焦点图  start
  var regist_pageHeight = $(document).height(); 
  var regist_pageWidth = $(document).width(); 
  $(".focus li").css({ width:regist_pageWidth})
  $(".topfloat").css({ marginLeft:regist_pageWidth-836-418})
  
  
  var focuslen = $(".focus-con li").length; //获取焦点图个数
  var focusnum = $(this).index();
  var focusindex = 1;
  focusdtime();
	
	function focusdtime(){
		focusPicTimer = setInterval(function() {
			showPics(focusindex);
			focusindex++;
			if(focusindex == focuslen) {focusindex = 0;}
		},2000); //此2000代表自动播放的间隔，单位：毫秒
		
		}
	
	//显示图片函数，根据接收的focusindex值显示相应的内容
	function showPics(focusindex) {
	$(".focus .focus-con li").eq(focusindex).stop(true,false).animate({opacity:1},800).siblings().animate({opacity:0},800);
	$(".focus .focus-con li").eq(focusindex).addClass("on").siblings().removeClass("on");
	}
	//焦点图end
	
	
	

		
		$(".i-list").on("mouseover",".thumb-box",function(){
	    $(this).addClass("current");

	   })
	   $(".i-list").on("mouseout",".thumb-box",function(){
	    $(this).removeClass("current");

	   })
	   
	   
	   //滚动导航
		$(".roll-menu").find("div").hover(function(){
			var Tclass = $(this).attr("class");
			var Andclass = Tclass + "-h";
			$(this).addClass(Andclass).children(".roll-menu-link").stop(true,false).fadeIn("fast").animate({right:34},250);
		},function(){
			var Tclass = $(this).attr("class");
			var Andclass = Tclass + "-h";
			$(this).removeClass(Tclass.split(" ")[1]).children(".roll-menu-link").animate({right:54},250).hide();
		})
		$(".return").click(function(){
			$('body,html').animate({scrollTop:0},500);
		})
		window.onscroll = function(){
				var t = document.documentElement.scrollTop || document.body.scrollTop; 
				if( t >= 200 ) {
					$(".roll-menu").find(".return").show();
				} else {
					$(".roll-menu").find(".return").hide();
				}
			} 
	   //地图切换
	   
	
	   
	   $(".fsearch_con_map span").click(function(){
		   $(this).addClass("on").siblings().removeClass("on");
		   var choosenum = $(this).index()
		   if(choosenum==0){
			    $(".js_shopslist").show();
				$(".js_maplist").hide();
			   }else{
				 $(".js_shopslist").hide();
				 $(".js_maplist").show();
			   }
		   })
		
		// 模拟下拉
		
		$(".js_sectext").live("click",function(event){
			event.stopPropagation();
			$(this).find(".js_seclist").toggle();
			})
		$(document).live("click",function(event){
			var eo = $(event.target);
			if ($(".js_sectext").is(":visible") && eo.attr("class") != "js_seclist" && !eo.parent(".js_seclist").length)
					$('.js_seclist').hide();
			})
		$(".js_sectext ul.js_seclist li").live("click",function(){
			var value = $(this).text();
			var oldValue = $(this).parent().parent().find("span").attr("del");
			
			if(value == "不限"){
				  $(this).parent().parent().find("span").text(oldValue);
				}else{
				  $(this).parent().parent().find("span").text(value);	
					}
			})
			
	//筛选
		$(".js_condition span").live("click", function(){
			$(this).addClass("s-on").siblings().removeClass("s-on");
		})
		$(".js_condition span em").hover(function(){
			$(this).addClass("em-h");
		},function(){
			$(this).removeClass("em-h");
		})
		//删除已选择的
		$(".js_delete_slect").live("click", function(){

			var _txt = $(this).parent().text();
			_selects = $(".js_condition span em");
			_selects.each(function(index, element) {
			                	if($(element).text()==_txt){
						$(element).parent().removeClass("s-on");
						$(element).parent().siblings().eq(0).addClass("s-on");
					}
			            });
			//alert(_select)
			$(this).parent("span").remove();
		})
		//重置筛选条件
		$(".clear-di").click(function(){
			$(".js_condition_select").html("");
			$(".js_condition").find("span").each(function(i){
				$(this).removeClass("s-on");	
			})
			$(".js_condition").find("span:first").each(function(i){
				$(this).addClass("s-on");	
			})
		})
	
	 //排序
	 $(".shopslist_pricepx").toggle(
	 	   function(){
		   $(this).find("span").addClass("px_on")
		 },function(){
		   $(this).find("span").removeClass("px_on")
			 
			 })	
	 $(".shopslist_areapx").toggle(
	 	   function(){
		   $(this).find("span").addClass("px_on")
		 },function(){
		   $(this).find("span").removeClass("px_on")
			 
			 })	
	//tab
	$(".us-nav-box ul li").live("click",function(){
		
		 var indexnum = $(this).index();
		  $(this).addClass("curr").siblings().removeClass("curr");
		  $(this).parent().parent().next(".us-body").find(".box").eq(indexnum).show().siblings().hide();
		})
		
	//删除收藏
	$(".shopsc dl").hover(function(){
		 $(this).find(".shopxx").show()
		},function(){
		$(this).find(".shopxx").hide()	
			})
	//评分		
    bindStar();
	//左侧菜单
	$(".us-menu li").click(function(){
		 
		     $(this).find("a").addClass("curr").end().siblings().find("a").removeClass("curr");
		
		})
   //回复
   var huifu_text = $("#js_huifucon").html();
   
   $(".js_huifu").live("click",function(){
	     $(this).parents(".ct-dt-pl").find(".context").after(huifu_text);
	       
	   })
	   
	   
	   
	   
	//套餐对比、对比弹出层
	     var aaa = $(document).width()-1000;
		$(".js_contrast-fold").click(function(){
			$(".js_contrast .contrast-unfold").show().animate({"right":aaa/2});
			return false;
		})
		$(".js_contrast .contrast-unfold .a-hide").click(function(){
			$(this).parents(".contrast-unfold").animate({"right":"-259px"}).hide();
			return false;
		})
		$(".js_contrast_btn").click(function(){
			var _w = $(".thick-content").width() / 2;
			var _h = $(".thick-content").height() / 2;
			$(".thick-content").css("margin-left", -_w + "px");
			if (!(jQuery.browser.msie && jQuery.browser.version < 7)) { // take away IE6
				$(".thick-content").css({
					marginTop: -_h + 'px'
				});
			}
			$("#thick_bj").show();
			$(".thick-content").show();	
			$(".thick-close").click(function () {
				$("#thick_bj").hide();
				$(".thick-content").hide();
				return false;
			}) 		
			return false;
		})
		
		
});

function bindStar(){
	var stars=$("#J_amVmPfStar li"),
		len=stars.length,
		isCurr=false;
	for(var i=0;i<len;i++){
		stars[i]._i=i;
		$(stars[i]).bind("mouseover",function(){
			var me=this,
				curr_i=me._i;
			if(!isCurr){
				$(stars).removeClass('curr');
				change(curr_i);
			}
		});
		$(stars[i]).bind("mouseout",function(){
			var me=this,
				curr_i=me._i;
			if(!isCurr){
				$(stars).removeClass('curr');	
			}
		});
		$(stars[i]).bind("click",function(){
			var me=this,
				curr_i=me._i;
			isCurr=true;
		});
	}
	function change(index){
		for(var j=index;j>-1;j--){
			$(stars[j]).addClass('curr');
		}
	}}
