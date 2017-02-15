
$(function(){
	//左侧折叠	
	$(".js_side_fold").click(function(){
		if($(this).attr("class")=="side-fold js_side_fold"){
			$(this).addClass("side-fold-off");
			$(".left-control").addClass("left-control-off");
			$(".right-control").addClass("right-control-on");
		}else{
			$(this).removeClass("side-fold-off");
			$(".left-control").removeClass("left-control-off");
			$(".right-control").removeClass("right-control-on");
		}
	})

	//档位名称 添加
	$(".js_checkAdd").live("click",function(){
		var checkDiv = $("#checkDiv").html();
		$(".js_checkDiv").append(checkDiv);
	})
	$(".js_checkDiv .check-box").live("click",function(){

		var _inpChb2 = $(this),
			_bChb2 = _inpChb2.parent(".lab-ckb").prev(".inp-chb");
		
		_bChb2.trigger("click");
		if(!_inpChb2.hasClass("check-boxs")){
			_inpChb2.addClass("check-boxs");
		}else{
			_inpChb2.removeClass("check-boxs");
		}
	});
	$(".js_radioDiv .b-radio").live("click",function(){

		var _inpRadio = $(this),
			_bRadio = _inpRadio.prev(".inp-radio"),
			name = _bRadio.attr("name") || '';
		
		_inpRadio.click(function(){
			_bRadio.trigger("click");	
			if($("input[type='radio']:checked")){
				$("input[type='radio']:checked").next().addClass("bon-radio");	
				$("input[type='radio']:not(:checked)").next().removeClass("bon-radio");
			}
		});
	})
	//首页修改密码
	
	$(".root_ul li a").live("click",function(){
		$(this).addClass("on").parent().siblings().find("a").removeClass("on");

	})
	$(".js_pass a").toggle(function(){
		$(this).next(".ued-password").show();
		$(this).addClass("on")
	},function(){
		$(this).next(".ued-password").hide();
		$(this).removeClass("on")
	})
	//合约类型数选择
	$(".js_choose span").toggle(function(){
		$(this).addClass("onS")
	},function(){
		$(this).removeClass("onS")
	})
	//修改默认radio样式
	$("input[type='radio'].inp-radio").each(function(){
		var _inpRadio = $(this),
			_bRadio = _inpRadio.next(),
			name = _inpRadio.attr("name") || '';
		if(_inpRadio.is(":checked")){
			_bRadio.addClass("bon-radio");
		}else{
			if(_bRadio.hasClass("bon-radio"))_bRadio.removeClass("bon-radio");
		}
		_bRadio.click(function(e){
            _inpRadio.trigger("click");
            if($("input[type='radio']:checked")){
                $("input[type='radio']:checked").next().addClass("bon-radio");
                $("input[type='radio']:not(:checked)").next().removeClass("bon-radio");
            }
            e.stopImmediatePropagation();
		});
	})
	//修改默认checkbox样式
	$("input.inp-chb").each(function(){

		var _inpChb = $(this),
			_bChb = _inpChb.next(".lab-ckb").find(".check-box");
		// if(_inpChb.is(":checked")){
		// 	_bChb.addClass("check-boxs");
		// }else{
		// 	if(_bChb.hasClass("check-boxs"))_bChb.removeClass("check-boxs");
		// }
		_bChb.live("click",function(){
			_inpChb.trigger("click");
			if(_inpChb.is(":checked")){
				_bChb.addClass("check-boxs");
			}else{
				_bChb.removeClass("check-boxs");
			}
		})
	})
	
	showNav();

	//判断左侧菜单是否有第三级菜单
	$(".js_list_active li a").each(function(e) {
        if($(this).next('ul').length > 0 ) {
			$(this).addClass("list-second");
		}
		var $this = $(this);
		$(this).live("click",function(e){
			var e = e || window.event;
			e.preventDefault();
			$(".js_list_active li a").removeClass("li-active");
			$(this).addClass("li-active");
			if (!$(this).next('ul.list-c1-son').is(":hidden")) {
				$(this).next('ul.list-c1-son').hide();
			}else{
				$(this).next('ul.list-c1-son').show();
			}
	     //if($this.attr("target")=="iframe"){
			// $("#ued-iframe").attr("src",$(this).attr("href"));//设定当前框架iframe 的地址为 该链接地址
	     //}	       
		})		
    });
	$(".left-control .ued-side-tit").each(function() {
       
		$(this).live("click",function(){
			if (!$(this).next('ul.js_list_active').is(":hidden")) {
				$(this).next('ul.js_list_active').hide();
			}else{
				$(this).next('ul.js_list_active').show();
			}
		})		
    });

	ui_com_tab(".js_tab .js_tab_tit ul li");//tab切换

	ui_hover_tab(".js_htab .nav-tabs li");//tab切换
	
	//点击修改增加tab
	$(".js_amend").live("click",function(event){
		var lidiv = "<li id='lilast'><a class='ued-revamp' href='javascript:void(0)'>修改</a><span class='ued-tabClose'></span></li>",
			tabDiv = $("#editDiv").html();
		$(".js_tab_tit .ued-tab-1").append(lidiv);
		$(".ued-tab-con").append(tabDiv);
		setSelect($("#lilast")[0]);
		ui_hover_tab(".js_htab .nav-tabs li");//tab切换
	});

	$(".ued-tabClose").live("click",function(){		
		$("#lilast").remove();
		$(".ued-tab-con .js_copy").remove();
		setSelect($(".liQuery")[0]);
	});
	// 筛选菜单
	$(".ued-select .ued-lbtn").click(function(e){
		e.stopPropagation();
		if($(this).hasClass('clOn')){
			$(this).removeClass('clOn');
			$(this).next('.ued-s-list').hide();
		}else{
			$(this).addClass('clOn');
			$(this).next('.ued-s-list').show();
		}
	})
	$(".ued-select p").toggle(function(){
		$(this).addClass("on")
	},function(){
		$(this).removeClass("on")
	})
	$(document).bind("click",function(e){
		var target = $(e.target);
		if(!target.closest(".ued-s-list").is(":visible") && !target.parent(".ued-s-list").length){
			$(".ued-select .ued-s-list").hide();
			$(".ued-select .ued-lbtn").removeClass("clOn");
		}
	})
	//搜索框下拉样式
	$(".ued-sea-much .ued-sea-span").live("click",function(){
		if($(".ued-sea-much").find(".ued-sea-list").is(":hidden")){
			$(".ued-sea-much").find(".ued-sea-list").show();
		}else{
			$(".ued-sea-much").find(".ued-sea-list").hide();
		}
	})
	$(".ued-sea-list p").live("click",function(){
		$(this).addClass("clon").siblings().removeClass("clon");
	})
	$(".ued-sea-much").mouseleave(function(){
	  $(".ued-sea-list").hide();
	});

	$('.js_info').live('hover',function(event){
		if(event.type=='mouseenter'){
			$(this).find(".ued-tag").show(100);
		}else{
			$(this).find(".ued-tag").hide();
		}
	});
	//功能区域展开收起
	$(".ued-tab-1 li").live("click",function(event){
		//$("#ued-pack").show();
		if(!$(".liQuery").hasClass("on1")){
			$("#ued-pack").hide();
		}else{			
			$("#ued-pack").show();			
		}; 
		
	});
	$("#ued-pack").live("click",function(){
		if (!$('#ued-packBox').is(":hidden")) {
			$('#ued-packBox').hide();
			$("#ued-pack").addClass("ued-packUp").text("展开查询条件")
		}else{
			$('#ued-packBox').show();
			$("#ued-pack").removeClass("ued-packUp").text("收起查询条件")
		}
	})
	//政策档位 添加
	$(".js_titleAdd").live("click",function(){
		var tabDiv = $("#ued-analog").html();
		$(".js_title").append(tabDiv);
	})
	$(".ued-analog span").live("click",function(){
		$(this).next(".ued-log-list").css("display","block");
		$(this).parent(".ued-analog").siblings(".ued-analog").find(".ued-log-list").css("display","none");
	})
	$(".ued-log-list .js_log_btn").live("click",function(){
		$(this).closest(".ued-log-list").css("display","none");
	})
	$(".js_log_del").live("click",function(){
		$(this).closest(".ued-analog").remove();
	})
	
	
	//js_tr_add
	$(".js_tr_add").live("click",function(){
		var trDiv = "<tr><td></td><td></td><td></td><td><a class='js_tr_del' href='javascript:void(0)'>删除</a></td></tr>";
		$(this).closest(".ued-table").find("tbody").append(trDiv);
		$(".ued-table tbody tr").each(function(){
			$('.ued-table tbody tr:even').addClass('ued-tr-even');
			$('.ued-table tbody tr:odd').addClass('ued-tr-odd');
		})
	})
	$(".js_tr_del").live("click",function(){		
		$(this).closest("tr").remove();
	})
	
	//ued-table
	$(".ued-table tbody tr").each(function(){
		$('.ued-table tbody tr:even').addClass('ued-tr-even');
		$('.ued-table tbody tr:odd').addClass('ued-tr-odd');
	})
	//js_opt_table 展开收起
	$(".js_opt_table tr  a.ued-open").toggle(function() {
		$(this).closest("tr").next("tr.js_tabbox").removeClass("none");
		$(this).text("收起-")	
	},function() {
		$(this).closest("tr").next("tr.js_tabbox").addClass("none");
		$(this).text("展开+")		
	});
	//uedDraw
	$("#uedDraw").on("click",".ued-draw",function(){
		if (!$(this).hasClass("ued-back")) {
			$(this).closest('table').next(".js_drawBox").removeClass("none");
			$(this).addClass("ued-back");
		}else{
			$(this).closest('table').next(".js_drawBox").addClass("none");
			$(this).removeClass("ued-back");
		};
		
		console.log($(this).closest('table').next(".js_drawBox"))
	})
})
$(document).ready(function(){
	$(".js_select").live("click",function(event){   
		event.stopPropagation();
		$(this).find(".ued-option,.ued-sleOp").toggle();
	});
	$(document).click(function(event){
		var eo=$(event.target);
		if($(".js_select").is(":visible") && eo.attr("class")!="ued-option" && !eo.parent(".ued-option").length)
		$('.ued-option,.ued-sleOp').hide();
	});
	/*赋值给文本框*/
	$(".ued-option a,.ued-sleOp a").live("click",function(){
		var value=$(this).text();
		var className = $(this).attr("class");
		$(this).closest(".ued-option,.ued-sleOp").siblings(".ued-sel-txt").text(value);
	 })
});
$(window).resize(function() {
  showNav();
});
function showNav(){
	//获取登陆login-bg 高度
	var outerH = $(window).height();
	var lgtopH = $(".login-top").height();
	var lgfootH = $(".login-foot").height()
	$(".login-bg").height((outerH-lgtopH-lgfootH));
	
	var maxHei=$(window).height()
	var headerx=$(".ued-head").outerHeight();
	
	$(".ued-control-con").css({"height" : maxHei - headerx });
	$(".left-control,.right-control").css({"height" : maxHei - headerx -41 });
}

//tab切换
function ui_com_tab(obj){
	$(obj).live("click",function(){
		setSelect(this)
	})
}
//tab hover效果
function ui_hover_tab(ds){
	$(ds).hover(function(){
		$(ds).siblings().removeClass("active");
		$(this).addClass("active");
		var t_ind = $(ds).index($(this));
		$(ds).closest(".js_htab").find(".tab-content").find(">.tab-pane").eq(t_ind).show().siblings(".tab-pane").hide();
	})
}
function setSelect(obj){
   $(obj).addClass("on1").siblings().removeClass("on1");
	var temp_id = $(obj).index();
	$(obj).closest(".js_tab").find(".ued-tab-con").find(">.box-n").eq(temp_id).show().siblings(".box-n").hide();
}
(function($){
    $.fn.UED_tabs = function(option){
        var defaults = {
            activeClass: "active",
            activeIndex: 0,
            trigger: "click"
        };
        function _setActive(o){
            var  _o = $(o),
                 _targetConId = _o.children("a").attr("href");
			           
			var oDiv=_o.parent('ul').parent('div.title-bg').next('div.tab-content');
			/*
			*  href="javascript:;" || href="javascript:void(0);" ||  href="#"
			*  href="#Id"
			*              {   has 'target'
			*  href= url   {
			*              {   no  'target'
			*/
			if(_targetConId==="#" || _targetConId==="javascript:;" || _targetConId==="javascript:void(0);"){
				 _o.addClass(option.activeClass).siblings("li").removeClass(option.activeClass);
				 var i=_o.index();
				 oDiv.find('div.tab-pane').eq(i).addClass(option.activeClass).siblings(".tab-pane").removeClass(option.activeClass);
			}else{
				if(oDiv.find($(_targetConId)).length==1 ){
					 _o.addClass(option.activeClass).siblings("li").removeClass(option.activeClass);
					$(_targetConId).addClass(option.activeClass).siblings(".tab-pane").removeClass(option.activeClass);
				}else if(oDiv.find($(_targetConId)).length==0){
							if(_o.children("a").attr("target")){
							}else{
								 _o.addClass(option.activeClass).siblings("li").removeClass(option.activeClass);
								 var i=_o.index();
								 oDiv.find('div.tab-pane').eq(i).addClass(option.activeClass).siblings(".tab-pane").removeClass(option.activeClass);
								 //href='#无效的字符串'
								 var reg=/^#\w{1,}$/g;
								 if(reg.test(_targetConId)){
								 }
								 else{
									$.ajax({
											url:_targetConId,
											type:'GET',
											dataType:"html",
											success:function(html){
												oDiv.find('div.tab-pane').eq(i).empty().append(html);
											},
											beforeSend: function(){
												oDiv.find('div.tab-pane').eq(i).empty().append('正在加载中...')
											},
											error:function(){
												oDiv.find('div.tab-pane').eq(i).empty().append('加载失败，请检查请求链接，或者稍后重试!')
											}
										})
								 }
							}
				}else{
					alert("页面中id为"+_targetConId+"的div存在"+oDiv.find($(_targetConId)).length+"个，页面中id是唯一的，请检查后重新配置！");
				}
			}
			
        }
        function _init(_ul, _li){
            if(_li.hasClass(option.activeClass)){
                _setActive( _ul.find("li."+option.activeClass+":first") );
            }else if( option.activeIndex >= 0 ){
                _setActive( _li.eq(option.activeIndex) );
            }
        }
        function strToJson(str){
            str = str? str:"";
             return  eval( "({" + str + "})" );
        }

        //Interlace change color
        return this.each(function(i, n){
            var  _ul = $(n).children("div.title-bg").children("ul:first"),
                    _li = _ul.children("li"),
                    _rel =  strToJson( $(n).attr("data-rel") );

            /* 合并默认参数和用户自定义参数 */
            option = $.extend(true, {}, defaults, option, _rel);

            // init
            _init(_ul, _li);

            // event
            _li.bind(option.trigger?option.trigger:option.trigger, function(e){
                _setActive($(this));
                if($(this).children("a").attr("target")==undefined){
                    e.preventDefault();
                }
            })
        })
    }

    // auto init plugin
    $(function(){
        $("*[data-role='ued-tabs']").UED_tabs();
    })
})(jQuery);
