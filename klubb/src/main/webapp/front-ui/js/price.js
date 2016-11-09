function fomatPrice(price){
	price = parseInt(price);
	if(price <= 99){
		return price;
	}else{
		return ((price / 10000).toFixed(2) * 100 / 100) + "万"; //避免出现1.00的情况
	}
}

//初始化金额显示
function initPrice(eleChoise){
	$(eleChoise).each(function(){
		$(this).html(fomatPrice($(this).html()));
	});
}