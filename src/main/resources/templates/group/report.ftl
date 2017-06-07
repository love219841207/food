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

<table class="g-list">
    <tr>
        <th width="30%">部门</th>
        <th width="30%">员工</th>
        <th width="25%">套餐类型</th>
        <th>份数</th>
    </tr>
    <tr>
    <#if ls?size<1>
        <td colspan="4">今天没有订餐记录</td>
    <#else>
        <#list ls as item>
            <#if item[2] gt 0>
                <tr>
                    <td>${item[0]}</td>
                    <td>${item[1]}</td>
                    <td>A</td>
                    <td>${item[2]}</td>
                </tr>
            </#if>
            <#if item[3] gt 0>
                <tr>
                    <td>${item[0]}</td>
                    <td>${item[1]}</td>
                    <td>B</td>
                    <td>${item[3]}</td>
                </tr>
            </#if>

        </#list>
    </#if>


    </tr>


</table>


<script language="JavaScript">
    $(function() {
        FastClick.attach(document.body);


        $('.j-sp').click(function(){
            var v = $(this).attr('hv');
            location.href="${springMacroRequestContext.contextPath}/group/report?chooseDay="+v;
        });

        //日历
        $('.j-calendar').mdater({
            //minDate: _startDay,
            callback:function(v){

                location.href="${springMacroRequestContext.contextPath}/group/report?chooseDay="+v;
            }
        });
    });
</script>













</body>
</html>