
function appWebReturn(){
	try{yota_AppWebReturn();}catch(e){};
	try{yota.AppWebReturn();}catch(e){};
}

function logout(){
	(new WebJs.Logout()).sentRequest();
}

function AppImageBrowsing(pics){
	try{ yota_AppImageBrowsing(pics);}catch(e){};
	try{ yota.AppImageBrowsing(pics+'');}catch(e){};
}


/** button 防止重复提交**/
$(document).ready(function(){
	$(".button-click").click(function(){
		var __this = this;
		$(__this).attr("disabled",true);
		setTimeout(function(){ $(__this).attr("disabled",false); }, 2000) 
	}); 
});


time = function(){
	if(seconds_code>0){
		$("#seconds_code").attr("disabled",true);
		$("#seconds_code").html(seconds_code+"秒");
		$("#seconds_code").addClass('on');
		$("#seconds_code").addClass('gray');
		seconds_code--;
		setTimeout("  $('#seconds_code').html('"+seconds_code+"秒'); time();",1000);
	}else{
		$("#seconds_code").attr("disabled",false);
		$("#seconds_code").html("重发验证码");
		$("#seconds_code").removeClass('on');
		$("#seconds_code").removeClass('gray');
		seconds_code=60;
	}
}

var seconds_code = 60;
/** Code **/
LoginCodeSend = function(){
	
	if(seconds_code!=60) return ;
	
	if($("#phone").val()=='' || $("#phone").val().length!=11 ){
		getAlert('温馨提示','请输入正确手机号码');
		return ;
	}
	
	time();
	
	if($("#phone").val()!=''){
		$.post("/code_login/",{"phone":$("#phone").val()},function(result){
		  });
	}

}

/** 注册 Code **/
RegCodeSend = function(){
	
	if($("#phone").val()==''){
		getAlert('温馨提示','请输入手机号码');
		return ;
	}
	
	time();
	
	if($("#phone").val()!=''){
		$.post("/code_reg/",{"phone":$("#phone").val()},function(result){
		  });
	}

}

/** 修改手机号 Code **/
UpdatePhoneCodeSend = function(){
	
	if($("#phone").val()==''){
		getAlert('温馨提示','请输入手机号码');
		return ;
	}
	
	time();
	
	if($("#phone").val()!=''){
		$.post("/code_phonechange/",{"phone":$("#phone").val()},function(result){
		  });
	}

}



if (typeof WebJs == "undefined") {
	var WebJs ={};
}

function  evalJSON (strJson){
	return eval( "(" + strJson + ")");
}

























