/**
 * @Filename: sysLayout.js
 * @Description: sysLayout
 * @Version: 1.0.0
 * @Author: wangyq.si-tech
 * @UpdateBy: wangyq 20121206
 * @UpdateBy: wangcw 20130403
 * Copyright (c) 2012-2013 si-tech
 *
 * @example
 *说明：
 *1.布局上：整个div设置相对定位，左侧绝对定位，left:0,top:为上部div的高度，右侧绝对定位，right:0,top为上部div的高度，中间的不能设置浮动，也不设置宽度，margin-left:左边div的宽度+间距+边框等，margin-right：右边div的宽度+间距+边框等
 *2.页面只有中间的div是必须显示的，上下左右4个div可根据实际取舍保留，只要结构中不出现相应的标签即可
 *3.初始化时，对于根据内容适应高度的情况，对左中右div设置高度，必须先确定宽度，然后才能确定高度，
 *4.已经考虑到窗口大小改变时会出现滚动条的问题，窗口尺寸改变时会相应$(window).resize(function(){	_init(models,option);})
 *5.初始高度会有3种情况，100%（以window高），auto（以左中右div的内容自适应,取三者中最大的作为公用高度），还可以配置固定高度（比如设置成500，则上中下div高度+间距，总值为500）
 *
 *

 */
(function($){
    $.fn.UED_sysLayout = function(option){

        var defaults = {
            //初始配置
            height:"100%",//初始高度，100%、auto、300
            isLeftCollapse: false,      //初始化时 左边是否隐藏
            isRightCollapse: false,     //初始化时 右边是否隐
            allowLeftCollapse: true,      //是否允许 左边可以隐藏
            allowRightCollapse: false,     //是否允许 右边可以隐藏

            //回调配置
            topHeight: 0,
            bottomHeight: 0,
            leftWidth: 180,
            rightWidth: 0,
            space:0 //间隔
        };

       
		
        function _init(models, option){
            var height = option.height;
			//中间三个div的高度
			var centerH=0;
			var iMarginTop=option.topHeight+option.space;
			if(models.top!==null){
				$(models.top).css({'width':'100%','margin-bottom':option.space+'px','height':option.topHeight+'px'});
			}else{
				$(models.middle).css({'margin-top':0});
				iMarginTop=0;
			}
			if(models.left!==null){
				$(models.left).css({'left':0,'top':iMarginTop+'px','position':'absolute'}).show();
			};
			$(models.middle).css({'margin-left':option.leftWidth+option.space+'px', 'margin-right':option.rightWidth+option.space+'px','margin-bottom':option.space+'px'}).parent().css({'position':'relative'});
			if(models.right!==null){
				$(models.right).css({'right':0,'top':iMarginTop+'px','position':'absolute'});
			};
			if(models.bottom!==null){
				$(models.bottom).css({'width':'100%','float':'left','height':option.bottomHeight+'px' });
			}else{
				$(models.middle).css({'margin-bottom':0});
			}
			
			//先确定宽度，然后才能确定高度值
			var leftH=models.left==null?0:$(models.left).height();
			var centerH=$(models.middle).height();
			//var rightH=models.right==null?0:$(models.right).height();
			//iLength用来计算上下间距的个数，如果上div或者下div没有，则只有一个间距，如果上下都没有，则有0个间距，默认是上下都有，
			var iLength;
			if(models.top==null && models.bottom==null){
				iLength=0;
			}else if(models.top==null || models.bottom==null){
				iLength=1;
			}else{
				iLength=2
			}
            if(height=="100%"){
				centerH=$(window).height()-option.topHeight-option.bottomHeight-iLength*option.space-3;
            }else if(height==='auto'){
				centerH=centerH>rightH?centerH:rightH;
				centerH=centerH>leftH?centerH:leftH;
			}else{
				centerH=height-option.topHeight-option.bottomHeight-iLength*option.space-3;
            }
			
			
			$(models.middle).css({'height':centerH+'px'});
			if(models.left!==null){
				$(models.left).css({'width':option.leftWidth+'px','height':centerH+'px'});
				$(models.middle).css({'margin-left':(option.leftWidth+option.space)+'px'});
				//如果左侧可以收缩，添加操作相关的标签，并且修改相关样式
				if(option.allowLeftCollapse){
					if($(models.middle).parent().find(".layout-collapse-left").length){
						$(models.middle).parent().find(".layout-collapse-left").css({top:iMarginTop +'px',height:centerH+'px'});
					}else{
						$(models.middle).parent().append('<div class="layout-collapse-left" style="top:'+ iMarginTop +'px;height:'+centerH+'px;"><div class="layout-collapse-left-toggle"></div></div>');
						$(models.left).prepend('<div class="layout-header-left"><div class="layout-header-toggle-left"></div></div>');
					}
					
					if(option.isLeftCollapse=='true'){
						//初始化时收缩
						$(models.left).hide();
						$(".layout-collapse-left").show();
						$(".layout-header-left").hide();
						$(models.middle).css({'margin-left':($(".layout-collapse-left").width()+option.space+2)+'px'});
					}else{
						//初始化时显示
						$(".layout-collapse-left").hide();
						$(".layout-header-left").show();
						$(models.left).show();
						$(models.middle).css({'margin-right':(option.leftWidth+option.space)+'px'});
					}	
				}
			}else{
				$(models.middle).css({'margin-left':0});
			}
			
			if(models.right!==null){
				$(models.right).css({'width':option.rightWidth+'px','height':centerH+'px'});
				$(models.middle).css({'margin-right':(option.rightWidth+option.space)+'px'});
				if(option.allowRightCollapse){
					if($(models.middle).parent().find(".layout-collapse-right").length){
						$(models.middle).parent().find(".layout-collapse-right").css({top:iMarginTop +'px',height:centerH+'px'});
					}else{
						$(models.middle).parent().append('<div class="layout-collapse-right" style="top:'+ iMarginTop +'px;height:'+centerH+'px;"><div class="layout-collapse-right-toggle"></div></div>');
						$(models.right).prepend('<div class="layout-header-right"><div class="layout-header-toggle-right"></div></div>');
					}
					
					if(option.isRightCollapse=='true'){
						$(models.right).hide();
						$(".layout-collapse-right").show();
						$(models.middle).css({'margin-right':($(".layout-collapse-right").width()+option.space+2)+'px'});
					}else{
						$(".layout-collapse-right").hide();
						$(models.right).show();
						$(models.middle).css({'margin-right':(option.rightWidth+option.space)+'px'});
					}	
				}
			}else{
				$(models.middle).css({'margin-right':0});
			}
        }
		
		
		 function fnResize(models, option){
            var height = option.height;
			//中间三个div的高度
			var centerH=0, iLength=2;
			if(models.top==null || models.bottom==null){
				iLength=1;
			}else if(models.top==null && models.bottom==null){
				iLength=0;
			}
            if(height=="100%"){
				centerH=$(window).height()-option.topHeight-option.bottomHeight-iLength*option.space-3;
				$(models.left).css({'height':centerH+'px'});
				$(models.middle).css({'height':centerH+'px'});
				$(models.right).css({'height':centerH+'px'});
				$(models.middle).parent().find('.layout-collapse-right').css({'height':centerH+'px'});
				$(models.middle).parent().find('.layout-collapse-left').css({'height':centerH+'px'});
				var contWrapH = $("div.ued-layout").height();
    			$("#ued-ztree").css("height",contWrapH-94);
            }
			
        }
		
        function strToJson(str){
            str = str? str:"";
            return  eval( "({" + str + "})" );
        }

        return this.each(function(i, n){
			var _rel =  strToJson( $(n).attr("data-rel") );
            var models = {};
            models.top = $(n).children("div[position='top']").get(0) || null;
            models.bottom = $(n).children("div[position='bottom']").get(0) || null;
            models.left = $(n).children("div[position='left']").get(0) || null;
            models.right = $(n).children("div[position='right']").get(0) || null;
            models.middle = $(n).children("div[position='center']").get(0) || null;
			if(models.top==null){
				defaults.topHeight=0;
			};
			if(models.left==null){
				defaults.leftWidth=0;
			};
			if(models.right==null){
				defaults.rightWidth=0;
			};
			if(models.bottom==null){
				defaults.bottomHeight=0;
			};
            /* 合并默认参数和用户自定义参数 */
            option = $.extend(true, {}, defaults, option, _rel);
            _init(models,option);
			
			$(window).resize(function(){
				fnResize(models,option);
			});
			
			$(n).find(".layout-collapse-left").bind('click',function(){
				if(!$(n).find(models.middle).is(":animated")){
					$(this).hide();
					$(n).find(models.left).animate({left:0},400);
					$(n).find(".layout-header-left").show();
					$(n).find(models.middle).animate({'margin-left':(option.leftWidth+option.space)+'px'},400);
				}
			})
			$(n).find(".layout-header-left").bind('click',function(){
				if(!$(n).find(models.middle).is(":animated")){
					$(models.left).animate({'left': '-'+option.leftWidth+"px"},400);
					$(n).find(".layout-collapse-left").show();
					$(this).hide();
					$(n).find(models.middle).animate({'margin-left':($(".layout-collapse-left").width())+'px'},400);
				}
			})
			$(n).find(".layout-collapse-right").bind('click',function(){
				if(!$(n).find(models.middle).is(":animated")){
					$(this).hide();
					$(n).find(models.right).show();
					$(n).find(models.middle).animate({'margin-right':(option.rightWidth+option.space)+'px'});
				}
			})
			$(n).find(".layout-header-right").bind('click',function(){
				if(!$(n).find(models.middle).is(":animated")){
					$(n).find(models.right).animate({'width':option.rightWidth},200).hide();
					$(n).find(".layout-collapse-right").show();
					$(n).find(models.middle).animate({'margin-right':($(".layout-collapse-right").width()+option.space)+'px'},400);
				}
			})
        })
    }

    $(function(){
        $("*[data-role='ued-layout']").UED_sysLayout();
    });
})(jQuery);