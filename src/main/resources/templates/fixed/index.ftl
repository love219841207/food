<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>排餐计划</title>
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
<body class="g-padtom">
<div class="g-qhd">
    <a href="${springMacroRequestContext.contextPath}/delivery/list?choose=1"><img src="${springMacroRequestContext.contextPath}/img/icon3.png" alt="">
        <#if deliveryAddressVO??>
            姓名:${deliveryAddressVO.name} 手机号码:${deliveryAddressVO.phone}
        </#if>
      </a>
</div>
<div class="g-rhd">
    <span>未排餐：午餐0餐</span>
    <span>已排餐：午餐30餐</span>
</div>

<div class="g-plan">
    <h2><img src="${springMacroRequestContext.contextPath}/img/ar_dn.png">点击红色排餐和空白处可以修改<img src="${springMacroRequestContext.contextPath}/img/ar_dn.png"></h2>

    <table>
        <tr>
            <th width="25%" class="u-tab1"></th>
            <th width="40%" class="u-tab2">午餐</th>
            <th class="u-tab3">晚餐</th>
        </tr>

        <tr>
            <td class="u-tab1">1月18日 <em>周三</em></td>
            <td class="u-tab2">已约满</td>
            <td class="u-tab3"></td>
        </tr>

        <tr>
            <td class="u-tab1">1月19日 <em>周四</em></td>
            <td class="u-tab2 u-red j-red">极致纤体</td>
            <td class="u-tab3"></td>
        </tr>

        <tr>
            <td class="u-tab1">1月20日 <em>周五</em></td>
            <td class="u-tab2 u-red j-red">极致纤体</td>
            <td class="u-tab3"></td>
        </tr>

        <tr>
            <td class="u-tab1">1月21日 <em class="u-red">周六</em></td>
            <td class="u-tab2 u-red j-red">极致纤体</td>
            <td class="u-tab3"></td>
        </tr>

        <tr>
            <td class="u-tab1">1月22日 <em class="u-red">周日</em></td>
            <td class="u-tab2 u-red j-red">极致纤体</td>
            <td class="u-tab3"></td>
        </tr>

        <tr>
            <td class="u-tab1">1月23日 <em>周一</em></td>
            <td class="u-tab2 u-noedit"></td>
            <td class="u-tab3"></td>
        </tr>
    </table>
</div>

<div class="g-bottom">
    <a href="#" class="j-wid">确认排餐</a>
</div>
<script>

    $('.j-red').tap(function(){
        if($(this).text() == ''){
            $(this).text('极致纤体');
        }else{
            $(this).text('');
        }

    })

</script>

</body>
</html>