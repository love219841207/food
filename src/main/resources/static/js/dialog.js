var divButton;
var divTitle;
var divCon;
function getAlert(divTitle,divCon,divButton){
	if(divButton == 'yes'){
		var bottom = ($(window).height()-100)/2+50;
		$("body").append("<div class='dialog' style='z-index:9999999;bottom:"+bottom+"px'><div class='title'><span>X</span>"+divTitle+"</div><p>"+divCon+"</p><div class='d-bar'><button>取消</button><button>确定</button></div></div>");
		$(".dialog").fadeIn();
		$(".dialog button").bind("click", function(){
		  	$(".dialog").fadeOut(function(){
				$(".dialog").remove();
			})	  	
		});
		 setTimeout(function(){$(".dialog").fadeOut()}, 2500);
		 setTimeout(function(){$(".dialog").remove();}, 2700);
	}
	else{
		var bottom = ($(window).height()-100)/2+50;
		$("body").append("<div class='dialog' style='z-index:9999999;bottom:"+bottom+"px'><div class='title'><span>X</span>"+divTitle+"</div><p>"+divCon+"</p></div>");
		$(".dialog").fadeIn();
		
		 setTimeout(function(){$(".dialog").fadeOut()}, 2500);
		 setTimeout(function(){$(".dialog").remove();}, 2700);
	}
	$(".dialog .title span").bind("click", function(){
		$(".dialog").fadeOut(function(){
			$(".dialog").remove();
		})	  	
	});
}