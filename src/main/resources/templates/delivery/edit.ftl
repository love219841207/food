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
    <link href="${springMacroRequestContext.contextPath}/css/food.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery-weui/1.0.0/js/jquery-weui.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
</head>
<body>

<div class="adr-box">
    <form action="${springMacroRequestContext.contextPath}/delivery/save" method="post" id="confirm_form">
        <input type="hidden" name="id" id="id" value="${deliveryAddressVO.id!''}">
        <input type="hidden" name="dft" id="dft" value="${deliveryAddressVO.dft!''}">
    <input type="hidden" name="userId" value="${deliveryAddressVO.userId!''}">
    <input type="hidden" name="addressId" id="addressId" value="${deliveryAddressVO.addressId!''}">
        <input type="hidden" name="choose" id="choose" value="${isChoose!''}">

    <div class="form-list">
        <input type="text" id='picker' name="picker" placeholder="选择地址" value="${deliveryAddressVO.addressName!''}" data-values="${deliveryAddressVO.addressId!''}"/>
    </div>
    <div class="form-list">
        <input type="text" name="addressExtend" id="addressExtend" placeholder="详情地址" maxlength="20" value="${deliveryAddressVO.addressExtend!''}"/>
    </div>
    <div class="form-list">
        <input type="text"  name="name" id="name" placeholder="联系人" maxlength="10" value="${deliveryAddressVO.name!''}"    />
    </div>
    <div class="form-list">
        <input type="tel" name="phone" id="phone" placeholder="联系电话" value="${deliveryAddressVO.phone!''}"/>
    </div>
    </form>
    
    <a href="#" class="j-dft u-adr on">设置默认地址</a>
    <!--<button class="btm-w80 j-save">保存修改</button>
   <button class="btm-w80 j-dft">设置默认地址</button>
    <button class="btm-w80 gray j-del">删除</button> -->
    
    <div class="g-bottom">

        <a href="#" class="j-del u-del"></a>

 		<a href="#" class="u-mor j-save">保存修改</a>
	</div>

</div>

</div>
<script language="JavaScript">
    $(function() {
        FastClick.attach(document.body);
    });
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
        var _id = $('#id').val();
        location.href="${springMacroRequestContext.contextPath}/delivery/del?id="+_id;
    });

    $('.j-save').click(function(){
        dosave();
    });

    $('.j-dft').click(function(){
        $(this).toggleClass('on')
    });

    function dosave(){
        if($('.j-dft').hasClass('on')){
            $('#dft').val('1');
        }else{
            $('#dft').val('');
        }
        $('#addressId').val($('#picker').attr('data-values'));
        if($('#picker').attr('data-values')==''){
            $.alert("请选择地址!");
            return false;
        }
        if($('#addressExtend').val()==''){
            $.alert("请输入详细地址!");
            return false;
        }
        if($('#name').val()==''){
            $.alert("请输入联系人!");
            return false;
        }
        if($('#phone').val().length!=11){
            $.alert("请输入11位联系电话!");
            return false;
        }
        $('#confirm_form').submit();
    }
</script>
</body>


