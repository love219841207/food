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
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

</head>
<body class="g-ptom">
<form action="${springMacroRequestContext.contextPath}/order/charge" method="post" id="confirm_form">
    <input type="hidden" name="id" id = "id" value="">
    <input type="hidden" name="typeMenu"  value="${orderInfoVO.typeMenu}">
    <input type="hidden" name="timeMenu"  value="${orderInfoVO.timeMenu}">
    <input type="hidden" name="pkgDays"  value="${orderInfoVO.pkgDays}">
    <input type="hidden" name="userId"  value="${orderInfoVO.userId}">
    <input type="hidden" name="pkgMenu"  value="${orderInfoVO.pkgMenu}">
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
        <p class="fcb">抵用券 <span class="frt j-selt" v='${couponVO.price}' couponId='${couponVO.id}'></span></p>
        <input type="hidden" name="couponId" value="" id="couponId">
        <input type="hidden" name="couponPrice" value="" id="couponPrice">
    </#if>
        <p class="fcb">备注 <input type="text" placeholder="其它需求" class="frt" name="remark"> </p>
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
</form>
<script>

    $('.j-selt').tap(function(){
        $(this).toggleClass('on');
        if($(this).hasClass('on')){
            $('.j-con .frt').text('-'+$(this).attr('v')+'￥');
            var _lastPrice = $('.u-col .frt').attr('v');
            var _couPrice = $(this).attr('v');
            (_lastPrice>_couPrice)?_lastPrice=_lastPrice-_couPrice : _lastPrice='0.00';
            $('.u-col .frt').text(Number(_lastPrice).toFixed(2) +'￥');
            $('#couponId').val($(this).attr('couponId'));
            $('#couponPrice').val($(this).attr('v'));
        }else{
            $('.j-con .frt').text('0.00￥');
            $('.u-col .frt').text($('.u-col .frt').attr('v')+'￥');
            $('#couponId').val('');
            $('#couponPrice').val('');
        }
    });

    $('.j-wid').tap(function(){
       $.ajax({
            type: 'GET',
            url: '${springMacroRequestContext.contextPath}/order/charge',
            timeout: 3000,
            data:$('#confirm_form').serialize(),
            success: function(response){
                var config = response.config;
                var pconfig = response.pconfig;
                var orderInfoVO = response.orderInfoVO;
                $('#id').val(orderInfoVO.id);
                wx.config({
                    debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId : config.appId, // 必填，公众号的唯一标识
                    timestamp : config.timestamp, // 必填，生成签名的时间戳
                    nonceStr : config.nonce, // 必填，生成签名的随机串
                    signature :config.signature,// 必填，签名，见附录1
                    jsApiList : [ 'chooseWXPay' ]// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });

                wx.ready(function() {

                    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
                    wx.chooseWXPay({
                        timestamp : config.timestamp, //时间戳
                        nonceStr : config.nonce, //随机串
                        'package' : pconfig.prepayId, //扩展包
                        signType : 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                        paySign : pconfig.paySign, // 支付签名
                        success : function(res) {
                            if(res.errMsg=='chooseWXPay:ok'){
                                location.href = "${springMacroRequestContext.contextPath}/order/payment?id="+orderInfoVO.id;
                            }else if(res.errMsg=='chooseWXPay:cancel'){

                            }else if(res.errMsg=='chooseWXPay:fail'){

                            }
                        }
                    });
                });
            },
            error: function(xhr, type){
                alert('系统繁忙，请稍后再试!')
            }
        });
        /* $('#confirm_form').submit();*/
    })


</script>

</body>
</html>