<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索</title>
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
<body class="g-ptom">

<div class="g-serch">
    <p class="j-ser"><input type="text"><img src="${springMacroRequestContext.contextPath}/img/del.png" alt="" class="j-del-val"></p>
    <a href="#" class="j-btn btn">取消</a>

    <!-- 搜索提示弹框 -->
    <div class="mask g-mask"></div>
    <div class="g-ser-con g-ser-wid j-wid">
        <#list list as item>
            <a href="${springMacroRequestContext.contextPath}/delivery/edit?sid=${item.id}&id=${id!''}&choose=${choose}">${item.address} <em>${item.addressExt}</em></a>
        </#list>

    </div>
</div>


<div class="g-ser-con">
<#list list as item>
    <a href="${springMacroRequestContext.contextPath}/delivery/edit?sid=${item.id}&id=${id!''}&choose=${choose}">${item.address} <em>${item.addressExt}</em></a>
</#list>
</div>





<script>
    $(function() {
        FastClick.attach(document.body);
    });
    // 搜索
    var _btn = $('.j-btn'),_val = $('.j-del-val'),_inp = $('.j-ser input'),_wid = $('.j-wid'),_mask = $('.mask');
    _inp.focus(function(){
        $(this).parent().addClass('on');
        _btn.css({'display':'inline-block'});
        console.log(1);

    });

    _inp.on('input propertychange', function() {
        var _v = $(this).val();

        $('.j-wid a').each(function(){

            if($(this).text().indexOf(_v)>-1){

                //console.log('yes--');
                $(this).show();
            }else{
                $(this).hide();
            }
        });
        if($(this).val()){
            _val.show();
            _wid.show();
            _mask.show();
        }else{
            _val.hide();
            _wid.hide();
            _mask.hide();
        }
    });

    //取消搜索
    _btn.click(function(){
        $('.j-ser').removeClass('on');
        _inp.val('');
        $(this).hide();
        _val.hide();
    });

    //清空搜索值
    _val.click(function(){
        _inp.val('').focus();
        _val.hide();
        _wid.hide();
        _mask.hide();
    });

</script>
</body>
</html>