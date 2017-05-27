<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><#if type=='1'>极致瘦身<#else>均衡纤体</#if></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/calendar.css" />
    <script src="${springMacroRequestContext.contextPath}/js/jquery.1.8.3.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
    <script src="${springMacroRequestContext.contextPath}/js/calendar.js"></script>
    <script src="${springMacroRequestContext.contextPath}/js/touch.slide.js"></script>
</head>
<body class="g-padtom">

<div class="g-cald">
    <img src="${springMacroRequestContext.contextPath}/img/ar_lt.png" alt="">
    <input type="text" value="${chooseDayVO.ychooseDayAlias}" readonly class="j-sp" hv="${chooseDayVO.ychooseDay}">
    <input type="text" value="${chooseDayVO.chooseDayAlias}" readonly class="on j-calendar" hv="${chooseDayVO.chooseDay}" >
    <input type="text" value="${chooseDayVO.tchooseDayAlias}" readonly class="j-sp" hv="${chooseDayVO.tchooseDay}">
    <img src="${springMacroRequestContext.contextPath}/img/ar_rt.png" alt="">
</div>
<#--<div class="g-cald1 fcb">
    请选择日期  <input type="text" class="j-calendar frt" value="${chooseDay}" readonly>
</div>-->

<div class="g-tab">
    <div class="u-hd fcb j-tab">
    <#list menus as menu>
        <a href="#" class="
            <#if menu_index ==0>
            flt on
            <#else>
            frt
            </#if>
        " v="${menu.timeMenuVal}">${menu.timeMenu} <img src="${springMacroRequestContext.contextPath}/img/ar_cdn.png"></a>
    </#list>
    </div>


<#list menus as menu>
    <div class="g-con
          <#if menu_index ==0>
             u-block
           </#if>
       ">

    <#if menu_index ==0>
        <div id="j-slideBox" class="slideBox">
    <#else>
         <div id="j-slideBox1" class="slideBox">
    </#if>

            <div class="m-bd j-bd">
                <ul>
                <#list menu.mainImgs as is>
                    <li><a class="pic" href="javascript:void(0);"><img src="${springMacroRequestContext.contextPath}/drift/${is}"/></a></li>
                </#list>

                </ul>
            </div>

            <div class="m-hd j-hd">
                <ul>
                    <#list menu.mainImgs as is>
                        <li></li>
                    </#list>
                </ul>
            </div>
        </div>

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
</div>

<#list menus as menu>
    <div class="g-detal
        <#if menu_index gt 0>
             u-hide
        </#if>
    ">
         <div>
            <#list menu.imgs as img>
                <img src="${springMacroRequestContext.contextPath}/drift/${img}" alt="">
            </#list>
        </div>
    </div>
</#list>

<div class="g-bottom">
    <a href="#" class="j-wid">预定套餐</a>
</div>

<div class="mask"></div>
<div class="g-wid">
    <img src="${springMacroRequestContext.contextPath}/img/z-del.png" class="j-del">
    <h2>预约套餐</h2>
    <span>选择方案</span>
    <#list menus as menu>
        <div class="u-det j-sel <#if menu_index gt 0>u-hide</#if>">
            <#list menu.pkgMenuVOs as pkgMenuVO>
                 <a href="#" v="${pkgMenuVO.pkgDays}" lp="${pkgMenuVO.logisticsPrice?string.number}" class="<#if pkgMenuVO_index == 0>on</#if>" orip="${pkgMenuVO.originalPrice}" salep="${pkgMenuVO.salePrice}">${pkgMenuVO.pkgMenu}</a>
            </#list>

        </div>
    </#list>

    <div class="u-btn">
        <span>¥ <em class="u-now j-now"></em>¥ <em class="u-org j-org"></em> </span>
        <a href="#" id="j-book">下单</a>
    </div>
</div>

<script>
    $(function() {
        FastClick.attach(document.body);
        timeType = '${timeType}';
        if(timeType=='2'){
            $('.frt').trigger('click');
        }
    });

    TouchSlide({
        slideCell:"#j-slideBox",
        titCell:".j-hd ul",
        mainCell:".j-bd ul",
        effect:"leftLoop",
        autoPage:true,
        autoPlay:true
    });

    var _startDay = new Date('${.now?string("yyyy-MM-dd")}');
    _startDay.setDate(_startDay.getDate()+1);
    //日历
    $('.j-calendar').mdater({
        //minDate: _startDay,
        callback:function(v){
            var timeType = $('.j-tab a').filter('.on').attr('v');
            //如果没有排餐、那么就获取本次请求的timeType
            if(timeType==undefined){
                timeType = '${timeType}';
            }
            location.href="${springMacroRequestContext.contextPath}/book/typemenu/${type}?timeType="+timeType+"&chooseDay="+v;
        }
    });

    $('.j-sp').click(function(){
        var v = $(this).attr('hv');
        var timeType = $('.j-tab a').filter('.on').attr('v');
        if(timeType==undefined){
            timeType = '${timeType}';
        }
        location.href="${springMacroRequestContext.contextPath}/book/typemenu/${type}?timeType="+timeType+"&chooseDay="+v;
    });

    var sig;
    //页面tab切换
    $('.j-tab a').click(function(){
        var _this = $(this),_num = _this.index();
        _this.addClass('on').siblings().removeClass('on');
        $('.g-con').eq(_num).show().siblings('.g-con').hide();
        $('.g-detal').eq(_num).show().siblings('.g-detal').hide();
        $('.u-det').eq(_num).show().siblings('.u-det').hide();

        if(!sig){
            sig = new TouchSlide({
                slideCell:"#j-slideBox1",
                titCell:".j-hd ul",
                mainCell:".j-bd ul",
                effect:"leftLoop",
                autoPage:true,
                autoPlay:true
            });
        }
    });

    //点击预定套餐出现弹窗
    var _mask = $('.mask'),_wid = $('.g-wid');
    $('.j-wid').click(function(){
        _mask.show();
        _wid.show();
        initPkgMenu();
    });

    $('.j-del').click(function(){
        _mask.hide();
        _wid.hide();
    });

    // 弹窗里的单选
    $('.j-sel a').click(function(){
        $(this).addClass('on').siblings().removeClass('on');
        $('.j-org').text($(this).attr('orip'));
        $('.j-now').text($(this).attr('salep'));
    });

    //初始化选择pkg_menu
    var initPkgMenu = function(){
        var _o = $('.j-sel a:visible').filter('.on');
        if(_o.length==0){
            $('.j-sel a:visible').first().trigger('click');
        }else{
            _o.first().trigger('click');
        }
    };

    $('#j-book').click(function(){
        var _typeMenu = '${type}';
        var d = $('.j-tab a').filter(".on");
        var _timeMenu = d.attr('v');
        var _o = $('.j-sel a:visible').filter('.on');
        var pkg = _o.attr('v');
        var lp = _o.attr('lp');
       // location.href="${springMacroRequestContext.contextPath}/order/create/"+_typeMenu+"/"+_timeMenu+"/"+pkg;
        location.href="${springMacroRequestContext.contextPath}/order/create?type="+_typeMenu+"&timeMenu="+_timeMenu+"&pkgDays="+pkg+"&lp="+lp;
    })


</script>

</body>
</html>