<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>订单确认</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <script src="${springMacroRequestContext.contextPath}/js/zepto.min.js"></script>
</head>
<body class="g-ptom">

<div class="g-qhd">
<#-- <a href="#"><img src="${springMacroRequestContext.contextPath}/img/icon3.png" alt="">请选择收货地址</a>-->
    <div class="u-bd fcb">
        <img src="${springMacroRequestContext.contextPath}/img/img_ic.jpg" alt="" class="flt">
        <h2 class="flt">午餐 极致瘦身：极致纤体餐X30 餐次</h2>
        <span class="frt">￥30.00 <b>x30</b></span>
    </div>
</div>

<div class="g-qcon">
<#--<p class="fcb">送餐时间 <a href="#" class="frt">11:30-12:30</a></p>-->
    <p class="fcb">抵用券 <span class="frt j-selt"></span></p>
    <p class="fcb">备注 <input type="text" placeholder="其它需求" class="frt"> </p>
</div>

<div class="g-qcon">
    <p class="fcb">配送费 <em class="frt">30.00￥</em></p>
    <p class="fcb">抵用券 <em class="frt">30.00￥</em></p>
    <p class="fcb u-col">实际支付 <em class="frt">330.00￥</em></p>
</div>

<div class="g-bottom">
    <a href="#" class="j-wid">确认支付</a>
</div>

<script>

    $('.j-selt').tap(function(){
        $(this).toggleClass('on');
    })


</script>

</body>
</html>