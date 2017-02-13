<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
</head>
<body>

<div class="g-center">
    <div class="hd fcb">
        <img src="${userVO.wechatInfo.headImg}" alt="" class="flt">
        <p class="flt">${userVO.wechatInfo.nickName} <br>${userVO.userInfo.phone}</p>
    </div>

    <div class="center">
        <h2>我的钱包</h2>
        <p><b>1</b>张 <em>抵用券</em></p>
    </div>

    <div class="con">
        <a href="#"> <img src="${springMacroRequestContext.contextPath}/img/icon2.png" alt="">全部订单1</a>

       <#-- <a href="#"> <img src="/food/img/icon3.png" alt="">配送地址</a>-->
        <a href="#"> <img src="${springMacroRequestContext.contextPath}/img/icon4.png" alt="">团体预定</a>
        <a href="#"> <img src="${springMacroRequestContext.contextPath}/img/icon5.png" alt="">剩余套餐</a>
    </div>
</div>




</body>
</html>