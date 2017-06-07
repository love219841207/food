<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>列表</title>
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



<div class="g-code">
    <img src="${springMacroRequestContext.contextPath}/drift/zx${groupInfoVO.id}.png" alt="">
    <p>扫描二维码点餐</p>
</div>

<div class="g-det">

    <p class="m-fot">
        <a href="${springMacroRequestContext.contextPath}/group/report">报表查看</a>
    </p>
</div>
</body>
</html>