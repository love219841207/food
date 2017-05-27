<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
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
    <script src="${springMacroRequestContext.contextPath}/js/touch.slide.js"></script>


</head>
<body>
<div class="g-rept">
    <h2 class="fcb">健康报告 <a href="${springMacroRequestContext.contextPath}/healthy/info">生成报告</a></h2>
    <div class="fcb u-con">
        <div class="lt flt">
            <span class="up">热量需求</span>
            <div class="g-circle j-circle">
                <div class="pie_left"><div class="left"></div></div>
                <div class="pie_right"><div class="right"></div></div>
                <div class="cir_mask"><span>${bodyIndexVO.caloricReq!''}</span></div>
            </div>
        </div>

        <div class="rt frt">
            <span> <em>BMI:</em>${bodyIndexVO.bmi!'0'} （${bodyIndexVO.bmiLevel!'-'}）</span>
            <span> <em>基础代谢:</em> ${bodyIndexVO.metabolize!'0'} kcal</span>
            <span> <em>每日消耗</em> <i>${bodyIndexVO.consume!''}kcal</i></span>
        </div>
    </div>
</div>


<div id="j-slideBox" class="slideBox">
    <div class="m-bd j-bd">
        <ul>
            <li><a class="pic" href="javascript:void(0);"><img src="${springMacroRequestContext.contextPath}/drift/ba1.jpg"/></a></li>
            <li><a class="pic" href="javascript:void(0);"><img src="${springMacroRequestContext.contextPath}/drift/ba2.jpg"/></a></li>
            <li><a class="pic" href="javascript:void(0);"><img src="${springMacroRequestContext.contextPath}/drift/ba3.jpg"/></a></li>
        </ul>
    </div>

    <div class="m-hd j-hd">
        <ul>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>


<div class="g-detail">
        <a href="${springMacroRequestContext.contextPath}/book/typemenu/1">
             <img src="${springMacroRequestContext.contextPath}/drift/typemenu1.jpg" alt="">
        </a>
        <a href="${springMacroRequestContext.contextPath}/book/typemenu/2">
            <img src="${springMacroRequestContext.contextPath}/drift/typemenu2.jpg" alt="">
        </a>
</div>





<script>
    $(function() {
        FastClick.attach(document.body);
    });

    // 轮播图计算图片高度
    //$('#j-slideBox img').css('height', ($(window).width() * 0.307));

    //轮播图部分
    TouchSlide({
        slideCell:"#j-slideBox",
        titCell:".j-hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
        mainCell:".j-bd ul",
        effect:"leftLoop",
        autoPage:true,//自动分页
        autoPlay:true//自动播放
    });

    //圆环进度条
    $('.j-circle').each(function(index, el) {
        var num = $(this).find('span').text() * 3.6;
        if (num<=180) {
            $(this).find('.right').css('transform', "rotate(" + num + "deg)");
        } else {
            $(this).find('.right').css('transform', "rotate(180deg)");
            $(this).find('.left').css('transform', "rotate(" + (num - 180) + "deg)");
        }
    });




</script>

</body>
</html>