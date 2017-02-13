<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, minimal-ui" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"content="telephone=no, email=no" />
    <title>登录</title>
    <meta name="description" id="description" content="短信快捷登录" />
    <link href="${springMacroRequestContext.contextPath}/css/user.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${springMacroRequestContext.contextPath}/js/zepto.min.js"></script>
    <script type="text/javascript" src="${springMacroRequestContext.contextPath}/js/Mobile.js"></script>
    <script type="text/javascript" src="${springMacroRequestContext.contextPath}/js/dialog.js"></script>
</head>
<body>
<div class="top">
    <a href="javascript:void(0)" >短信快捷登录</a>
</div>

<div class="main" id="quick" >
    <div class="form-box">
        <input type="tel"  name="phone"  id="phone" placeholder="手机号码"  />
    </div>
    <div class="form">
        <input type="number" class="yzm" name="code" placeholder="验证码"  id="code"/>
        <button class="btm-pink j-code"  id="seconds_code">获取验证码</button>
    </div>
    <button class="btm-block j-login" id="login_btn">登录</button>


    <!--
	<div class="notice-box">
        <p class="f-red">如果您已有网站帐号，请使用以下方式登录。</p>
    </div>
    <a href="/olduserlogin/"><button class="btm-block">网站用户：用户名或邮箱登录 >></button></a>
     &ndash;&gt;
    <div class="notice-box">
        <p>有任何问题可以请联系客服：<a href="tel:4008889417" class="f-red">400 888 9417</a></p>
    </div>

</div>-->

<script type="text/javascript">
    $(function(){
        $('.j-code').tap(function(){
            var _phone=$('#phone').val();
            time();
            $.ajax({
                type: 'GET',
                url: '${springMacroRequestContext.contextPath}/common/regeditCode/'+_phone,
                timeout: 3000,

                success: function(data){

                },
                error: function(xhr, type){
                    alert('系统繁忙，请稍后再试!')
                }
            })
        });

        $('.j-login').tap(function(){
            var _code=$('#code').val();
            var _phone=$('#phone').val();
            $("#login_btn").attr("disabled",true);
            $.ajax({
                type: 'GET',
                url: '${springMacroRequestContext.contextPath}/common/verify/'+_phone+'/'+_code,
                timeout: 3000,

                success: function(data){
                    if(data){
                        location.href="${springMacroRequestContext.contextPath}/wechat/binding/"+_phone+"/"+${routeid};
                    }else{
                        alert("验证码错误");
                        $("#login_btn").attr("disabled",false);
                    }
                },
                error: function(xhr, type){
                    alert('系统繁忙，请稍后再试!')
                }
            })
        });

    })
</script>
</body>
</html>
