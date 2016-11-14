$(function(){
	 amLunBo();// 轮转图代码
	 $(".menu-body li.jsli").click(function(){
		     var index = $(this).index();
			 var widthno = $(this).attr("width");
			 $(this).parents(".menu-body").find(".line").animate({marginLeft:widthno+"px"},500);
		  
		 
		 })
	

	   //回复
   var huifu_text = $("#js_huifucon").html();
   
   $(".js_huifu").live("click",function(){
	     $(this).parents(".ct-dt-pl").find(".context").after(huifu_text);
	      
	   })
	   

})

function amLunBo(){
    var lis=$("#J_amLbNav > li"),
        lbLock=false,
        lbOldIndex=0,
        lbLen=len=lis.length;
        for(var i=0;i<len;i++){
            lis[i]._i=i;
            lis[i].onmouseover=function(){
                lunBoAction(this._i);
            }
        }

        $("#J_amLbPrev").on("click",function(){
            if(lbOldIndex==0){
                lunBoAction(lbLen-1);
            }else{
                lunBoAction(lbOldIndex-1);
            }
        });
        $("#J_amLbNext").on("click",function(){
            if(lbOldIndex==(lbLen-1)){
                lunBoAction(0);
            }else{
                lunBoAction(lbOldIndex+1);
            }
        });
        $("#J_amLbBox").hover(function() {
            lbLock=true;
        }, function() {
            lbLock=false;
        });
        function lunBoAction(index){
            var index=index % lbLen;
            $("#J_amLbNav > li").eq(lbOldIndex).removeClass('curr');
            $("#J_amLbNav > li").eq(index).addClass('curr');
            $("#J_amLbBody > li").eq(lbOldIndex).stop(true,true).fadeOut(300, function() {
                $(this).css("zIndex",0);
            });
            $("#J_amLbBody > li").eq(index).stop(true,true).fadeIn(300, function() {
                $(this).css("zIndex",20);
            });
            $("#J_amLbInfo > li").eq(lbOldIndex).addClass('none');
            $("#J_amLbInfo > li").eq(index).removeClass('none');
            lbOldIndex=index;
        }
        setInterval(function(){
            if(!lbLock){
                var currLbIndex=lbOldIndex+1;
                lunBoAction(currLbIndex);
            }
        },5000);
}

