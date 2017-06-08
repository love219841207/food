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
        <img src="${userVO.wechatInfo.headImg!'${springMacroRequestContext.contextPath}/img/head.jpg'}" alt="" class="flt">
        <p class="flt">${userVO.wechatInfo.nickName!'客官'} <br>${userVO.userInfo.phone}</p>
    </div>

    <div class="center">
        <h2>我的钱包</h2>
        <p><b>${couponCount}</b>张 <em>抵用券</em></p>
    </div>

    <div class="con">
        <a href="${springMacroRequestContext.contextPath}/order/list"> <img src="${springMacroRequestContext.contextPath}/img/icon2.png" alt="">全部订单</a>
        <a href="${springMacroRequestContext.contextPath}/delivery/list"> <img src="${springMacroRequestContext.contextPath}/img/icon3.png" alt="">配送地址</a>
        <a href="${springMacroRequestContext.contextPath}/book/single"> <img src="${springMacroRequestContext.contextPath}/img/icon4.png" alt="">套餐购买</a>
        <a href="${springMacroRequestContext.contextPath}/group/group"> <img src="${springMacroRequestContext.contextPath}/img/icon4.png" alt="">团体预定</a>
        <a href="${springMacroRequestContext.contextPath}/fixed/index"> <img src="${springMacroRequestContext.contextPath}/img/icon5.png" alt="">排餐</a>
    </div>

    <div class="con">
        <span> 客服电话：021-62960659（09:00---20:00）</span>
    </div>
</div>




</body>
</html>