<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>全部订单</title>
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
<body>


<div class="g-case">
    <#if (orders?size <1)>
        <div class="con">
            <div class="no-case">
                <img src="${springMacroRequestContext.contextPath}/img/no_case.png" alt=""> <br>您目前还没有相关订单哦 ~
            </div>
        </div>

    </#if>

    <div class="con">

        <#list orders as order>
            <div class="case">
                <span class="up fcb">订单号：${order.id}
                    <em class="frt">
                        <#if order.status==3>
                            交易成功
                            <#elseif order.status==4>
                            付款失败
                            <#elseif order.status==5>
                            交易成功
                            <#elseif order.status==9>
                            交易作废
                        <#else>
                        </#if>
                  </em></span>
                <div class="dn fcb">
                    <img src="${springMacroRequestContext.contextPath}/drift/typemenu${order.typeMenu}.jpg" alt="" class="flt">
                    <p class="frt">
                        <span>${order.pkgMenu}</span>
                        <i>下单时间：${(order.createTime?string("yyyy-MM-dd HH:mm:ss"))!''}  </i>
                    </p>
                </div>
            </div>
        </#list>

    </div>


<div class="g-bottom ">
    <a href="#" class="j-fix">排餐</a>
</div>

    <script type="text/javascript">
        $(function(){
            FastClick.attach(document.body);
            $('.j-fix').click(function(){
                location.href='${springMacroRequestContext.contextPath}/fixed/index';
            })
        })
    </script>

</body>
</html>