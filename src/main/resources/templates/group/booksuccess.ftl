<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
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

<div class="g-det">

    <h2>亲爱的,${groupUserInfoVO.name}:</h2>
    <p class="m-fot">
        <span>您已成功预订</span>
        <span>A套餐 * ${groupOrderVO.av!'0'}</span>
        <span>B套餐 * ${groupOrderVO.bv!'0'}</span>
        <span> </span>
        <span>祝您用餐愉快!</span>

        <#if canedit><a href="${springMacroRequestContext.contextPath}/group/reserve/${cid}?edit=1">重新预定</a></#if>

    </p>


    <div class="m-code">
        关注挑食公众号
        <img src="${springMacroRequestContext.contextPath}/img/code.jpg" alt="">
        体验不一样的美食
    </div>


</div>

</body>
</html>