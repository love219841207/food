<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>套餐详情页</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/calendar.css" />
    <script src="${springMacroRequestContext.contextPath}/js/zepto.min.js"></script>

    <script src="${springMacroRequestContext.contextPath}/js/calendar.js"></script>
</head>
<body class="g-padtom">


<div class="g-cald1 fcb">
    请选择日期  <input type="text" class="j-calendar frt" value="${.now?string("yyyy-MM-dd")}" readonly>
</div>

<div class="g-tab">
    <div class="u-hd fcb j-tab">
    <#list menus as menu>
        <a href="#" class="
        <#if menu_index ==0>
        flt on
        <#else>
        frt
        </#if>
        ">${menu.timeMenu} <img src="${springMacroRequestContext.contextPath}/img/ar_cdn.png"></a>
    </#list>
    </div>


<#list menus as menu>
    <div class="g-con
     <#if menu_index ==0>
        u-block
     </#if>
   ">
        <div class="g-tcon">
            <p> <span class="fhd">主菜</span> <em>${menu.mainInfo}</em></p>
            <p> <span>配菜</span> <em>${menu.minor}</em></p>
            <p> <span>粗粮</span> <em>${menu.coarseGrain}</em></p>
            <p> <span>主食</span> <em>${menu.stapleFood}</em></p>
            <p> <span>饮品</span> <em>${menu.drink}</em></p>
            <p> <span>其他</span> <em>${menu.other}</em></p>

            <div class="u-kcal">${menu.kcal} <b>kcal</b></div>
        </div>
    </div>
</#list>

    <#--<div class="g-con u-block">

        <div class="g-tcon">
            <p> <span class="fhd">主菜</span> <em>酸菜鱼</em></p>
            <p> <span>配菜</span> <em>素炒菜心</em><em>香煎杏鲍菇</em><em>手撕包菜</em><em>手撕包菜</em><em>手撕包菜</em><em>手撕包菜</em><em>手撕包菜</em></p>
            <p> <span>粗粮</span> <em>南瓜</em><em>玉米</em></p>
            <p> <span>主食</span> <em>杂粮饭</em></p>
            <p> <span>饮品</span> <em>乌龙玛奇朵</em></p>
            <p> <span>其他</span> <em>粗粮餐包</em></p>

            <div class="u-kcal">238 <b>kcal</b></div>
        </div>
    </div>

    <div class="g-con">
        <div class="g-tcon">
            <p> <span class="fhd">主菜</span> <em>酸菜鱼</em></p>
            <p> <span>配菜</span> <em>素炒菜心</em><em>香煎杏鲍菇</em></p>
            <p> <span>粗粮</span> <em>南瓜</em><em>玉米</em></p>
            <p> <span>主食</span> <em>杂粮饭</em></p>
            <p> <span>饮品</span> <em>乌龙玛奇朵</em></p>
            <p> <span>其他</span> <em>粗粮餐包</em></p>

            <div class="u-kcal">2438 <b>kcal</b></div>
        </div>
    </div>-->
</div>

<div class="g-detal">
    <img src="${springMacroRequestContext.contextPath}/img/img2.jpg" alt="">
    <img src="${springMacroRequestContext.contextPath}/img/img2.jpg" alt="">
    <img src="${springMacroRequestContext.contextPath}/img/img2.jpg" alt="">
</div>

<div class="g-bottom">
    <a href="#" class="j-wid">预定套餐</a>
</div>

<div class="mask"></div>
<div class="g-wid">
    <img src="${springMacroRequestContext.contextPath}/img/z-del.png" class="j-del">
    <h2>预约套餐</h2>
    <span>选择方案</span>
    <div class="u-det j-sel">
        <a href="#">午餐：纤体1日</a>
        <a href="#">午餐：纤体1日</a>
        <a href="#">午餐：纤体1日</a>
        <a href="#">午餐：纤体1日</a>
        <a href="#">午餐：纤体1日</a>
        <a href="#">午餐：纤体1日</a>
    </div>

    <div class="u-btn">
        <a href="#">下单</a>
    </div>
</div>

<script>
    var _startDay = new Date('${.now?string("yyyy-MM-dd")}');
    _startDay.setDate(_startDay.getDate()+1);
    //日历
    $('.j-calendar').mdater({
        minDate: _startDay,
        callback:function(v){
            location.href="${springMacroRequestContext.contextPath}/book/typemenu/1?timeType=2&chooseDay=2017-2-21";
        }
    });

    //页面tab切换
    $('.j-tab a').tap(function(){
        var _this = $(this),_num = _this.index();
        _this.addClass('on').siblings().removeClass('on');
        $('.g-con').eq(_num).show().siblings('.g-con').hide();
    });

    //点击预定套餐出现弹窗
    var _mask = $('.mask'),_wid = $('.g-wid');
    $('.j-wid').tap(function(){
        _mask.show();
        _wid.show();
    });

    $('.j-del').tap(function(){
        _mask.hide();
        _wid.hide();
    });

    // 弹窗里的单选
    $('.j-sel a').tap(function(){
        $(this).addClass('on').siblings().removeClass('on');
    });





</script>

</body>
</html>