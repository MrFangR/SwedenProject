 
function ui_com_hallpop(objShow,objHide,objhallpop,obj){
		  $(objhallpop).remove();
		   if(obj&&obj.type == 4){$(".ands-miso-cover").remove();return;}
		  var cover_flag = true;
		   if(cover_flag){
		   var miso_cover =  document.createElement('div');	
		   $(miso_cover).addClass("ands-miso-cover");
		   $("body").prepend(miso_cover);
		   cover_flag = false;
		   }
		  var ands_miso_popAlert =  document.createElement('div');	
		  $(ands_miso_popAlert).attr("id","ands-miso-popAlert");
		 		

		       var ands_loadbar = document.createElement('div')
			   $(ands_loadbar).addClass("ands-loadbar");
			    
					  var ands_loadbar_text = document.createElement('div')
					   $(ands_loadbar_text).addClass("ands-loadbar-text");
					   $(ands_loadbar_text).html(obj.text);
					   
					   var ands_loadbar_img = document.createElement('div')
					   $(ands_loadbar_img).addClass("ands-loadbar-img");
					   
					   $(ands_loadbar).append(ands_loadbar_text);
					   $(ands_loadbar).append(ands_loadbar_img);
					   $(ands_miso_popAlert).append(ands_loadbar);
					   
		       var ands_misoAlert = document.createElement('div')
			   $(ands_misoAlert).addClass("ands-misoAlert");
			          if(obj&&obj.mywidth){
							$(ands_misoAlert).css({"width":obj.mywidth});
							$(ands_miso_popAlert).css({"width":obj.mywidth})
							}
			         var ands_misoAlert_head = document.createElement('div')
			         $(ands_misoAlert_head).addClass("ands-misoAlert-head");
					 
					     var ands_misoAlert_close = document.createElement('div')
			             $(ands_misoAlert_close).attr("id","ands_misoAlert_close");
						 $(ands_misoAlert_close).addClass("close");
						 	$(".close").live("mouseover",function(){
								$(this).addClass("closehove");
								}).live("mouseout",function(){
								$(this).removeClass("closehove");
								})
						 
						 
						 var ands_misoAlert_title = document.createElement('span')
						 $(ands_misoAlert_title).addClass("ands-misoAlert-title");
						 $(ands_misoAlert_title).html(obj.info)
						 
					     $(ands_misoAlert_head).append(ands_misoAlert_close);  
						 $(ands_misoAlert_head).append(ands_misoAlert_title); 
						   
					 var ands_misoAlert_content = document.createElement('div')
			         $(ands_misoAlert_content).addClass("ands-misoAlert-content");
					 
					     var ands_misoAlert_content_alert = document.createElement('div')
			             $(ands_misoAlert_content_alert).addClass("ands-misoAlert-content-alert");
						 $(ands_misoAlert_content_alert).html(obj.text)
				    
				         var ands_misoAlert_content_pop = document.createElement('div')
			             $(ands_misoAlert_content_pop).addClass("ands-misoAlert-content-pop");
						 
						 	var ands_misoAlert_content_popleft = document.createElement('div')
			                $(ands_misoAlert_content_popleft).addClass("ands-misoAlert-content-popleft");
								var ands_misoAlert_content_popleft_3i = document.createElement('i')
			                    if(obj&&obj.tag&&obj.tag == 'tx'){$(ands_misoAlert_content_popleft_3i).addClass("tx");}
								if(obj&&obj.tag&&obj.tag == 'zq'){$(ands_misoAlert_content_popleft_3i).addClass("zq");}
								if(obj&&obj.tag&&obj.tag == 'cw'){$(ands_misoAlert_content_popleft_3i).addClass("cw");}
								if(obj&&obj.tag&&obj.tag == 'yw'){$(ands_misoAlert_content_popleft_3i).addClass("yw");}
								if(obj&&obj.tag&&obj.tag == 'txsmall'){$(ands_misoAlert_content_popleft_3i).addClass("txsmall");}
								if(obj&&obj.tag&&obj.tag == 'zqsmall'){$(ands_misoAlert_content_popleft_3i).addClass("zqsmall");}
								if(obj&&obj.tag&&obj.tag == 'cwsmall'){$(ands_misoAlert_content_popleft_3i).addClass("cwsmall");}
								if(obj&&obj.tag&&obj.tag == 'ywsmall'){$(ands_misoAlert_content_popleft_3i).addClass("ywsmall");}
								
								
								
							    $(ands_misoAlert_content_popleft).append(ands_misoAlert_content_popleft_3i);
								
							var ands_misoAlert_content_popmain = document.createElement('div')
			                $(ands_misoAlert_content_popmain).addClass("ands-misoAlert-content-popmain");
							       var h2title = obj.title;
								   if(obj&&obj.title)
								   {$(ands_misoAlert_content_popmain).html(h2title+obj.text);}
								   else{$(ands_misoAlert_content_popmain).html(obj.text);}
								
								   if(obj&&obj.tag&& obj.tag == 'tx-ring'){
									$(ands_misoAlert_content_popleft_3i).addClass("tx-ring");
									$(ands_misoAlert_content_popleft).css({width:60,marginTop:10})
									$(ands_misoAlert_content_popmain).css({marginTop:0,width:360})
									}
								   if(obj&&obj.tag&& obj.tag == 'zq-ring'){
									$(ands_misoAlert_content_popleft_3i).addClass("zq-ring");
									$(ands_misoAlert_content_popleft).css({width:60,marginTop:10})
									$(ands_misoAlert_content_popmain).css({marginTop:0,width:360})
									}
								   if(obj&&obj.tag&& obj.tag == 'cw-ring'){
									$(ands_misoAlert_content_popleft_3i).addClass("cw-ring");
									$(ands_misoAlert_content_popleft).css({width:60,marginTop:10})
									$(ands_misoAlert_content_popmain).css({marginTop:0,width:360})
									}
									if(obj&&obj.tag&& obj.tag == 'yw-ring'){
									$(ands_misoAlert_content_popleft_3i).addClass("yw-ring");
									$(ands_misoAlert_content_popleft).css({width:60,marginTop:10})
									$(ands_misoAlert_content_popmain).css({marginTop:0,width:360})
									}
							$(ands_misoAlert_content_pop).append(ands_misoAlert_content_popleft); 
							$(ands_misoAlert_content_pop).append(ands_misoAlert_content_popmain); 
							
							
							    var ands_misoAlert_content_btncenter = document.createElement('div')
			                	$(ands_misoAlert_content_btncenter).addClass("ands-misoAlert-content-btncenter");
								
								var ands_misoAlert_content_btnright = document.createElement('div')
			                	$(ands_misoAlert_content_btnright).addClass("ands-misoAlert-content-btnright");
								
								
								var misoAlert_btnbg = document.createElement('span')
			                	$(misoAlert_btnbg).addClass("misoAlert-btnbg");
								$(misoAlert_btnbg).addClass("mgl-10");
								
								if(obj&&obj.btntext2){
									$(misoAlert_btnbg).css({'padding-left':'15px','padding-right':'15px'});
								    $(misoAlert_btnbg).html(obj.btntext2);
									}else{
										$(misoAlert_btnbg).html("取消");
										$(misoAlert_btnbg).css({'width':'88px'});
										};
								$(misoAlert_btnbg).live('click',function(){
									$(".ands-miso-cover").remove();
									$(objhallpop).hide();
								})
								if(obj&&obj.cancle){
									$(misoAlert_btnbg).live('click',obj.cancle)
								}
								var misoAlert_btnbr = document.createElement('span')
			                	$(misoAlert_btnbr).addClass("misoAlert-btnbr");
								if(obj&&obj.btntext1){
									$(misoAlert_btnbr).css({'padding-left':'15px','padding-right':'15px'});
								     $(misoAlert_btnbr).html(obj.btntext1);
									}else{
										$(misoAlert_btnbr).html("确定");
										};

								$(misoAlert_btnbr).live('click',function(){
									if(obj&&obj.ok1){return;}
									$(".ands-miso-cover").remove();
									$(objhallpop).hide();
								})
								if(obj&&obj.ok){
									$(misoAlert_btnbr).live('click',obj.ok)
								}
								if(obj&&obj.ok1){
									$(misoAlert_btnbr).live('click',obj.ok1)
								}
								
								var misoAlert_btnbr2 = document.createElement('span')
			                	$(misoAlert_btnbr2).addClass("misoAlert-btnbr");
								$(misoAlert_btnbr2).html("bekräfta");
								$(misoAlert_btnbr2).live('click',function(){
									$(".ands-miso-cover").remove();
									$(objhallpop).hide();
								})
								if(obj&&obj.ok){
									$(misoAlert_btnbr2).live('click',obj.ok)
								}
								
								var misoAlert_btnsb = document.createElement('span')
			                	$(misoAlert_btnsb).addClass("misoAlert-btnsb");
								$(misoAlert_btnsb).html("确定");
								$(misoAlert_btnsb).live('click',function(){
									$(".ands-miso-cover").remove();
									$(objhallpop).hide();
								})
								if(obj&&obj.ok){
									$(misoAlert_btnsb).live('click',obj.ok)
								}
								$(ands_misoAlert_content_btnright).append(misoAlert_btnbr); 
								$(ands_misoAlert_content_btnright).append(misoAlert_btnbg); 
								
								$(ands_misoAlert_content_btncenter).append(misoAlert_btnbr2); 
							    
								
							
			if(obj&&obj.type == 1){
				$(ands_miso_popAlert).append(ands_loadbar)
				$("body").append(ands_miso_popAlert);
				}else{
				
					if(obj&&obj.type == 2){
						if(obj&&obj.tag){
							$(ands_misoAlert_content).append(ands_misoAlert_content_pop);
							}else{								
							$(ands_misoAlert_content).append(ands_misoAlert_content_alert);
							}
						
						$(ands_misoAlert).append(ands_misoAlert_head);
						$(ands_misoAlert).append(ands_misoAlert_content);
						$(ands_misoAlert).append(ands_misoAlert_content_btncenter);
						$(ands_miso_popAlert).empty();
						$(ands_miso_popAlert).append(ands_misoAlert);
						}else if(obj&&obj.type == 3){
						
						$(ands_misoAlert_content).append(ands_misoAlert_content_pop)
						$(ands_misoAlert).append(ands_misoAlert_head);
						$(ands_misoAlert).append(ands_misoAlert_content);
						$(ands_misoAlert).append(ands_misoAlert_content_btnright);
						$(ands_miso_popAlert).empty();
						$(ands_miso_popAlert).append(ands_misoAlert);
						
							}else if(obj&&obj.type == 5){
						$(ands_misoAlert_content).html(obj.text);
						$(ands_misoAlert).append(ands_misoAlert_head);
						$(ands_misoAlert).append(ands_misoAlert_content);
						$(ands_misoAlert).append(ands_misoAlert_content_btnright);
						if(obj&&obj.mywidth){
							$(ands_misoAlert).css({"width":obj.mywidth});
							$(ands_miso_popAlert).css({"width":obj.mywidth})
							}else{
						$(ands_misoAlert).css({"width":"900px"});
						$(ands_misoAlert_content).css({"height":"400px","overflow":"auto"});
						$(ands_miso_popAlert).css({"width":"900px"})
								}
					
						$(ands_miso_popAlert).empty();
						$(ands_miso_popAlert).append(ands_misoAlert);
						
								
								}else if(obj&&obj.type == 6){
									$(ands_misoAlert_content).html(obj.text);
						$(ands_misoAlert).append(ands_misoAlert_head);
						$(ands_misoAlert).append(ands_misoAlert_content);
						$(ands_misoAlert_content).css({"padding":"0px","border":"0px"});
						$(ands_miso_popAlert).empty();
						$(ands_miso_popAlert).append(ands_misoAlert);
									}
					$("body").append(ands_miso_popAlert);
					}
			if(obj&&obj.skin){
				$(ands_misoAlert).css({border:"0px"})
				$(ands_misoAlert_head).css({background:obj.skin.bgcolor,color:obj.skin.color,height:obj.skin.height+"px",lineHeight:obj.skin.height+"px",borderTop:"0px"})
				$(ands_misoAlert_title).css({fontSize:obj.skin.size+"px"})
				$(ands_misoAlert_close).css({marginTop:obj.skin.height/2-30+"px"})
				$(ands_misoAlert_close).removeClass();
				$(ands_misoAlert_close).html("×");
				$(ands_misoAlert_close).addClass("close2");
				
				   if(obj.skin.btnwidth){
					   
					  $(misoAlert_btnbg).css({width:obj.skin.btnwidth,background:obj.skin.btncolorr,height:obj.skin.btnheight,color:"#fff",borderColor:obj.skin.btncolorr,lineHeight:obj.skin.btnheight+"px"});
					  $(misoAlert_btnbr).css({width:obj.skin.btnwidth,background:obj.skin.btncolorl,height:obj.skin.btnheight,color:"#fff",borderColor:obj.skin.btncolorl,lineHeight:obj.skin.btnheight+"px"})
					   }
				}
		   
		var regist_pageHeight = $(document).height(); 
		var regist_pageWidth = $(document).width(); 
		var _w = -$(objhallpop).width()/2;
		var _h = -$(objhallpop).height()/2;
		var wait=10;
		
		$(".ands-miso-cover").height(regist_pageHeight);
		$(".ands-miso-cover").width(regist_pageWidth);
		$(objhallpop).css("margin-left", _w + "px");
		$(objhallpop).css("margin-top", _h + "px");
		$(objShow).live('click',function(){
			
			
			$(".ands-miso-cover").show();
			$(objhallpop).show();
			/*	if(autoClose==0){
		           
					 function misotime(){
					  if(wait == 0){
						  $(".ands-miso-cover").hide();
						  $(objhallpop).hide();
						  wait = 10;
						  }else{
						   wait--;
							  setTimeout(function(){misotime()},100)
							  }
					  }
					      misotime();	
					}*/
			
			})
		 $(objHide).live('click',function(){
				$(".ands-miso-cover").remove();
				$(objhallpop).hide();
			})
			
		  
}	
