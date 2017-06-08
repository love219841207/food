<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>企业订餐</title>
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
<body class="g-ptom">

<form action="${springMacroRequestContext.contextPath}/group/empsave" method="post" id="confirm_form">
<div class="g-subm">

    <div class="u-con2">
        <input type="hidden" id="orderId" name="orderId" value="${groupOrderVO.id!''}">
        <input type="hidden" id="id" name="id" value="${groupUserInfoVO.id!''}">
        <input type="hidden" id="cid" name="cid" value="${groupUserInfoVO.cid!''}">
        <input type="hidden" id="bookDay" name="bookDay" value="${groupOrderVO.bookDay!''}">
        <input type="hidden" id="wechatId" name="wechatId" value="${groupUserInfoVO.wechatId!''}">
        <input type="text" placeholder="输入姓名" id="name" name="name" value="${groupUserInfoVO.name!''}">
        <input type="text" placeholder="输入部门" id="dep" name="dep" value="${groupUserInfoVO.dep!''}">
    </div>
    <div class="u-con3">
        <div class="fcb">
            <span class="fot">A套餐</span>
            <ul class="fcb g-sel frt j-all">
                <li class="j-sub"> - </li>
                <input type="text" value="${groupOrderVO.av!'0'}" class="j-num" id="av" name="av">
                <li class="j-add"> + </li>
            </ul>
        </div>
        <div class="fcb">
            <span class="fot">B套餐</span>
            <ul class="fcb g-sel frt j-all">
                <li class="j-sub"> - </li>
                <input type="text" value="${groupOrderVO.bv!'0'}" class="j-num" id="bv" name="bv">
                <li class="j-add"> + </li>
            </ul>
        </div>
    </div>

    <div class="u-con1">
        <h2> <b></b><span>${weekDay}</span></h2>
        <img src="${springMacroRequestContext.contextPath}/drift/week.jpg" alt="">
    </div>

</div>

</form>
<div class="g-bottom">
    <a href="#" class="j-reserve">预定套餐</a>
</div>



<script>

    $('.j-reserve').click(function(){
        var _name = $('#name');
        var _dep = $('#dep');
        if(_name.val()==''){
            alert("请输入姓名!");
            return false;
        }
        if(_dep.val()==''){
            alert("请输入部门!");
            return false;
        }
        $('#confirm_form').submit();
    });
    // 添加份数

    $('.j-all').each(function(){

        var _tagNum = $(this).find('.j-num'),_add = $(this).find('.j-add'),_sub = $(this).find('.j-sub');

        _add.click(function(){
            var _num = parseInt(_tagNum.val());
            if(_num <= 100) _tagNum.val( parseInt(_num+1));
        });

        _sub.click(function(){
            var _num = parseInt(_tagNum.val());
            if(_num > 0) _tagNum.val( parseInt(_num-1));
        });
    })

</script>

</body>
</html>