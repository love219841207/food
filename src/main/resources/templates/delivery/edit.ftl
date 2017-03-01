<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, minimal-ui" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <title>配送地址</title>
    <link href="${springMacroRequestContext.contextPath}/css/user.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/weui/1.1.0/style/weui.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/jquery-weui/1.0.0/css/jquery-weui.min.css">
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery-weui/1.0.0/js/jquery-weui.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
</head>
<body>

<div class="adr-box">
    <form action="${springMacroRequestContext.contextPath}/delivery/save" method="post" id="confirm_form">
        <input type="hidden" name="id" value="${deliveryAddressVO.id!''}">
        <input type="hidden" name="userId" value="${deliveryAddressVO.userId!''}">
        <input type="hidden" name="addressId" value="${deliveryAddressVO.addressId!''}">
        <div class="form-list">
                <input type="text" id='picker' name="picker" placeholder="选择地址" value="${deliveryAddressVO.addressName!''}" data-values="${deliveryAddressVO.addressId!''}"/>
        </div>
        <div class="form-list">
            <input type="text" name="addressExtend" id="addressExtend" placeholder="详情地址" value="${deliveryAddressVO.addressExtend!''}"/>
        </div>
        <div class="form-list">
            <input type="text"  name="name" id="name" placeholder="联系人" value="${deliveryAddressVO.name!''}"    />
        </div>
        <div class="form-list">
            <input type="number" name="phone" id="phone" placeholder="联系电话" value="${deliveryAddressVO.phone!''}"/>
        </div>
        <button class="btm-w80 button-click j-save">保存修改</button>
        <button class="btm-w80 button-click j-dft">设置默认地址</button>
        <button class="btm-w80 gray button-click j-del">删除</button>
    </form>
</div>
<script language="JavaScript">
    $.ajax({
        type: 'GET',
        url: '${springMacroRequestContext.contextPath}/delivery/listAddress/',
        timeout: 3000,

        success: function(data){
            $("#picker").select({
                title: "请选择送餐地址",
                items: data
            });
        },
        error: function(xhr, type){
            alert('系统繁忙，请稍后再试!')
        }
    });


    $('.j-del').click(function(){

    });

    $('.j-save').click(function(){
        $('#addressId').val($('#picker').attr('data-values'));
        $('#confirm_form').submit();
    });

    $('.j-dft').click(function(){

    })

</script>
</body>


