// JavaScript Document
/*
初始：$("#id").UED_navtab();
新开：$("#id").UED_navtab.open(id,title,url,option)
dom新开：<a href="url" tabid="1" prop="value">title</a>
*/

(function($){
	$.fn.UED_navtab=function(option){
        //默认配置
		var defaults={
            //配置参数
			activeClass:'active', //激活class
			height:'100%', //组件高度（包含tab标题栏的高度），可接受参数：auto（自适应？？尚未实现），100%（父容器高度），数字
            showMask:false, //是否显示loading遮罩
            dblClickClose:true, //双击关闭，尚未实现
            leftArrow:"<a class='leftArrow' href='#'>＜</a>", //左箭头dom
            rightArrow:"<a class='rightArrow' href='#'>＞</a>", //右箭头dom
            mask:"<div class='mask'></div>",  //遮罩dom
            titleLiMargin:5,//tab标题间的间距，用于计算滚动距离
            arrowWidth:13, //左右滚动箭头的宽度，用于宽度计算补差
            max:20, //tab数量限制

            //回调函数
            beforeActive:null,//激活前，传递参数（id，title，url），return可阻断，尚未实现
            onActive:null,//激活，传递参数（id，title，url，iframe），尚未实现
            beforeLoad:null,//iframe加载前，传递参数（id，title，url，iframe），return可阻断，尚未实现
            onLoad:null,//iframe加载完成，传递参数（id，title，url，iframe），尚未实现
            beforeClose:null,//关闭前，传递参数（id，title，url，iframe），return可阻断，尚未实现
            onClose:null //关闭前，传递参数（id，title，url，iframe），尚未实现
		};

		return this.each(function(i,n){
            var $this = $(this),
                _rel =  strToJson($this.attr("data-rel")),
                option = $.extend(true,{},defaults,option,_rel)
                $title = $this.children(".navtab-title"),
                $content = $this.children(".navtab-content"),
                $leftArrow = $(option.leftArrow),
                $rightArrow = $(option.rightArrow),
                $mask = $(option.mask)
                ;

            //方法：设置高度，参数（数字或100%）
            $.fn.UED_navtab.setHeight = function(h){
                var navtabHeight;
                if(h=="auto"){
                    navtabHeight = 400;
                }else if(option.height=="100%"){
                    navtabHeight = $this.parent().innerHeight();
                }else{
                    navtabHeight = h;
                }

                if(typeof navtabHeight == "number"){
                    var th = $title.outerHeight(true);
                    $this.data("height",navtabHeight-th-57);
                    $content.height(navtabHeight-th-57).find("iframe").height(navtabHeight-th-57);
                }else{
                    alert("$.fn.UED_navtab.setHeight()参数错误！");
                }
            };

            //方法：激活tab，参数（tabid）
            $.fn.UED_navtab.setActive = function(id){
                $title.find("a[tabid='"+id+"']").parent().addClass(option.activeClass).siblings().removeClass(option.activeClass);
                $content.find("iframe[tabid='"+id+"']").show().siblings("iframe").hide();
                option.showMask && $mask.hide();
            };

            //检测tab标题栏变化
            function monitor(){
                var tw = $title.width(),
                    liw = $this.data("liw");
                if(liw>tw-2*option.arrowWidth){
                    $leftArrow.show();
                    $rightArrow.show();
                    $title.find(">ul").css("margin-left","12px");
                }else{
                    $leftArrow.hide();
                    $rightArrow.hide();
                    $title.find(">ul").css("margin-left","0");
                }
            }

            //方法：将指定tab滚入视图，参数（tabid）
            $.fn.UED_navtab.srcollTo = function(id){
                var tw = $title.width(),
                    liw = $this.data("liw"),
                    target = $title.find("a[tabid='"+id+"']").parent(),
                    tgoffset = target.position().left + target.width(),
                    left = -$this.data("left")*1 || 0;
                monitor();
                if(tgoffset > tw+left){
                    var newleft = tw-tgoffset-2*option.arrowWidth;
                    newleft = newleft>0 ? 0 : newleft;
                    $title.find(">ul").animate({left:newleft},200);
                    $this.data("left",newleft);
                }else if(target.position().left < left){
                    var newleft = -target.position().left;
                    newleft = newleft>0 ? 0 : newleft;
                    $title.find(">ul").animate({left:newleft},200);
                    $this.data("left",newleft);
                }
            };

            //方法：向左滚动
            $.fn.UED_navtab.srcollLeft = function(){
                var left = -$this.data("left")*1;
                if(left>0){
                    $title.find("ul>li").each(function(){
                        var lileft = $(this).position().left,liw = $(this).width()+option.titleLiMargin;
                        if(left>lileft && left<=lileft+liw){
                            $title.find(">ul").animate({left:-lileft},200);
                            $this.data("left",-lileft);
                            return;
                        }
                    });
                }
            };

            //方法：向右滚动
            $.fn.UED_navtab.srcollRight = function(){
                var left = -$this.data("left")* 1,tw = $title.width()-2*option.arrowWidth,liw = $this.data("liw");
                if(left+tw<liw){
                    $title.find("ul>li").each(function(){
                        var lileft = $(this).position().left,liwidth = $(this).width();
                        if(lileft-option.titleLiMargin<=tw+left && lileft+liwidth>tw+left){
                            $title.find(">ul").animate({left:tw-lileft-liwidth},200);
                            $this.data("left",tw-lileft-liwidth);
                            return;
                        }
                    });
                }
            };

            //方法：新开或激活tab，参数（id,title,url,option）
            $.fn.UED_navtab.open = function(id,title,url,openopt){
                var def = {
                    closeable:true //是否带关闭按钮
                };
                var opt = $.extend(def,openopt);
                if($content.find("iframe[tabid='"+id+"']").length){ //已打开的tab，切换
                    $this.UED_navtab.setActive(id);
                }else{ //未打开的tab，加载
                    if($title.find("ul>li").length==option.max && $title.find("a[tabid='"+id+"']").length==0){
                        alert("已打开"+option.max+"个Tab，超出最大限制！");
                        return;
                    }
                    if($title.find("a[tabid='"+id+"']").length==0){
                        var li = $("<li><a tabid='"+id+"' href='"+url+"'>"+title+"</a></li>");
                        if(opt.closeable){
                            li.append("<a class='close' title='关闭'></a>")
                        }
                        $title.children("ul").append(li);
                        //更新tab标题栏宽度
                        $this.data("liw",$this.data("liw")*1+$title.find("a[tabid='"+id+"']").parent().width()+option.titleLiMargin);
                    }
                    //处理tab标题
                    $title.find("a[tabid='"+id+"']").parent().addClass(option.activeClass).siblings().removeClass(option.activeClass);
                    //iframe加载内容
                    var iframe = $("<iframe width='100%' height='"+$this.data("height")+"' tabid='"+id+"' src='"+url+"' frameborder='0'></iframe>");
                    option.showMask && $mask.show();
                    iframe.appendTo($content).show().siblings("iframe").hide();
                    iframe.load(function(){
                        option.showMask && $mask.hide();
                    });
                }
                //滚动tab标题至视口中
                $this.UED_navtab.srcollTo(id);
                $this.data("cur",id);
            };

            //方法：关闭tab，参数（id）
            $.fn.UED_navtab.close = function(id){
                var li = $title.find("a[tabid='"+id+"']").parent();
                var iframe = $content.find("iframe[tabid='"+id+"']");
                var active = li.hasClass(option.activeClass);
                var newli =  li.next("li").length ? li.next("li").children("a").eq(0) : li.prev("li").children("a").eq(0);
                var left = $this.data("left")*1 + li.width() + option.titleLiMargin;
                left = left>0 ? 0 : left;
                $this.data("liw",$this.data("liw")*1-li.width()-option.titleLiMargin);
                li.remove();
                iframe.remove();
                $this.data("left",left);
                $title.find(">ul").animate({left:left},200);
                monitor();
                active && newli.trigger("click");
            };

            //方法：关闭其他tab，参数（id）
            $.fn.UED_navtab.closeOther = function(id){
                var li = $title.find("a[tabid='"+id+"']").parent();
                var iframe = $content.find("iframe[tabid='"+id+"']");
                li.siblings("li").remove();
                iframe.siblings("iframe").remove();
                $this.data("liw",li.width()+option.titleLiMargin);
                $this.data("left",0);
                $title.find(">ul").animate({left:0},200);
                monitor();
                li.find("a[tabid]").trigger("click");
            };

            //方法：重载tab，参数（id）
            $.fn.UED_navtab.reload = function(id){
                var a = $title.find("a[tabid='"+id+"']");
                var iframe = $content.find("iframe[tabid='"+id+"']");
                if(iframe.length){
                    iframe.attr("src",iframe.attr("src"));
                }else{
                    a.trigger("click");
                }
            };

            //方法：获取当前激活tab
            $.fn.UED_navtab.getCur = function(){
                var id = $this.data("cur");
                var a = $title.find("a[tabid='"+id+"']");
                var result = { //返回对象需要说明
                    tabid : id,
                    title : a.text(),
                    url :a.attr("href"),
                    iframe : $content.find("iframe[tabid='"+id+"']")
                };
                return result;
            };

            //方法：关闭当前激活tab
            $.fn.UED_navtab.closeCur = function(){
                var id = $this.data("cur");
                $this.UED_navtab.close(id);
            };

            /*UI初始化*/
            //设置高度
            $this.UED_navtab.setHeight(option.height);
            //获取初始标题栏实际宽度
            var liw = 0;
            $title.find("ul>li").each(function(){
                liw = liw + $(this).width() + option.titleLiMargin;
                $this.data("liw",liw);
            });
            //插入左右滚动箭头
            $title.prepend($leftArrow).append($rightArrow);
            //生成loading遮罩
            $content.append($mask);

            /*绑定行为*/
            //左箭头行为
            $leftArrow.bind("click",function(e){
                var e = e || window.event;
                e.preventDefault();
                $this.UED_navtab.srcollLeft();
            });
            //右箭头行为
            $rightArrow.bind("click",function(e){
                var e = e || window.event;
                e.preventDefault();
                $this.UED_navtab.srcollRight();
            });
            //点击标题a行为
            $title.delegate("ul>li>a","click",function(e){ //点击标题行为
                var e = e || window.event;
                e.preventDefault();
                if($(this).hasClass("close")){ //点击关闭按钮
                    var id = $(this).prev("a[tabid]").attr("tabid");
                    $this.UED_navtab.close(id);
                }else{
                    var tabid = $(this).attr("tabid"),title = $(this).text(),url = $(this).attr("href");
                    if(tabid&&title&&url){
                        $this.UED_navtab.open(tabid,title,url);
                    }
                }
            });
            //默认激活第一个tab
            $title.find("ul>li>a").eq(0).trigger("click");

			//右键菜单，依赖于contextMenu.js插件
            $title.children("ul").contextMenu({
				selector: 'a[tabid]',
				build: function($trigger, e) {
					return {
						callback: function(key, options) {
							switch(key){
								case 'closeCurrent':
									//this指代的是li元素
									$this.UED_navtab.close($(this).attr('tabid'));
                                    break;
                                case 'closeOther':
                                    $this.UED_navtab.closeOther($(this).attr('tabid'));
                                    break;
                                case 'refresh':
                                    $this.UED_navtab.reload($(this).attr('tabid'));
                                    break;
							}
						},
						items: {
							"closeCurrent": {name: "关闭Tab页"},
							"closeOther": {name: "关闭其他Tab"},
							"refresh": {name: "刷新"}
						}
					};
				}
			});

        });
    }

    function strToJson(str){
        str = str? str:"";
        return  eval( "({" + str + "})" );
    }

	$(function(){
		$('div[data-role="navtab"]').UED_navtab();
	});
	
})(jQuery);


