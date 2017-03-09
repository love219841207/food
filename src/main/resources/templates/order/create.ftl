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
    <script src="${springMacroRequestContext.contextPath}/js/jquery.1.8.3.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
</head>
<body class="g-ptom">

<div class="g-qhd">
<#-- <a href="#"><img src="${springMacroRequestContext.contextPath}/img/icon3.png" alt="">请选择收货地址</a>-->
    <div class="u-bd fcb">
        <img src="${springMacroRequestContext.contextPath}/img/img_ic.jpg" alt="" class="flt">
        <h2 class="flt">${orderInfoVO.pkgMenu}</h2>
        <span class="frt">￥${orderInfoVO.pkgSalePrice} </span>
    </div>
</div>

<div class="g-qcon">
    <p class="fcb">送餐时间 <a href="#" class="frt"><#if orderInfoVO.timeMenu == '1'>11:30-12:30<#else>17:30-18:30</#if> </a></p>
    <#if couponVO??>
        <p class="fcb">抵用券 <span class="frt j-selt" v='${couponVO.price}' ></span></p>
    </#if>
<#--
    <p class="fcb">备注 <input type="text" placeholder="其它需求" class="frt"> </p>-->
</div>

<div class="g-qcon">
    <p class="fcb">配送费 <em class="frt">${orderInfoVO.logisticsPrice!'0.00'}￥</em></p>
    <#if couponVO??>
        <p class="fcb j-con">抵用券 <em class="frt" >0.00￥</em></p>
    </#if>
    <p class="fcb u-col">实际支付 <em class="frt" v="${orderInfoVO.lastPrice}">${orderInfoVO.lastPrice}￥</em></p>
</div>

<div class="g-bottom">
    <a href="#" class="j-wid">确认支付</a>
</div>

<script>
    $(function(){
        FastClick.attach(document.body);
    });
    $('.j-selt').click(function(){
        $(this).toggleClass('on');
        if($(this).hasClass('on')){
            $('.j-con .frt').text('-'+$(this).attr('v')+'￥');
            var _lastPrice = $('.u-col .frt').attr('v');
            var _couPrice = $(this).attr('v');
            (_lastPrice>_couPrice)?_lastPrice=_lastPrice-_couPrice : _lastPrice='0.00';
            console.log(Number(_lastPrice).toFixed(2)+'￥');
            $('.u-col .frt').text(Number(_lastPrice).toFixed(2) +'￥');
        }else{
            $('.j-con .frt').text('0.00￥');
            $('.u-col .frt').text($('.u-col .frt').attr('v')+'￥');
        }
    })


</script>

</body>
</html>