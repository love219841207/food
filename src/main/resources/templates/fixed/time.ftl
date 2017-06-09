<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>预约</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <script src="${springMacroRequestContext.contextPath}/js/jquery.1.8.3.min.js"></script>
</head>
<body>
<form action="${springMacroRequestContext.contextPath}/fixed/time/seltime" method="post" id="confirm_form">
<input type="hidden" id="timemenu" name="timemenu" value="${timemenu}">
    <input type="hidden" id="id" name="id" value="${userDeliveryTimeVO.id!''}">
    <input type="hidden" id="slev" name="slev" value="${slev!''}">
    <input type="hidden" id="userId" name="userId" value="${userDeliveryTimeVO.userId!''}">
    <div class="g-time j-time">
    <#if timemenu=='1'>
        <a href="#">10:30-11:15</a>
        <a href="#">11:15-12:00</a>
        <a href="#">12:00-12:45</a>
        <a href="#">12:45-13:30</a>
        <#else>
            <a href="#">17:00-18:00</a>
            <a href="#">18:00-19:00</a>
            <a href="#">19:00-20:00</a>
    </#if>


    </div>

</form>

<script>

    $('.j-time a').click(function(){
        $(this).addClass("on").siblings().removeClass('on');
        $('#slev').val($(this).text());
        $('#confirm_form').submit();
    });
    var _a = "${slev!''}";
    $('.j-time a').each(function(i){
        if($(this).text()==_a){
            $(this).addClass("on").siblings().removeClass('on');
        }
    })

</script>

</body>
</html>