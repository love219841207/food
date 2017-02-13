<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>团体预订</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="http://cdn.bootcss.com/weui/1.1.0/style/weui.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/jquery-weui/1.0.0/css/jquery-weui.min.css">
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery-weui/1.0.0/js/jquery-weui.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
</head>
<body>
<div  class="container" id="container">
    <div class="page input js_show">
        <form action="${springMacroRequestContext.contextPath}/book/groupsub" method="post" id="confirm_form">
        <div class="page__bd">

            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" maxlength="50" placeholder="公司名称" name="groupName" id="groupName">
                    </div>
                </div>
            </div>

            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text"  maxlength="50" placeholder="联系人姓名" name="name" id="name">
                    </div>
                </div>
            </div>

            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" pattern="[0-9]*"  placeholder="手机号码" name="phone" id="phone">
                    </div>
                </div>
            </div>

            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="用餐需求"  maxlength="200" rows="3" name="remark"></textarea>
                    </div>
                </div>
            </div>




        </div>

    </div>
    </form>


    <div class="page button js_show">
        <div class="page__hd">
            <div class="page__bd page__bd_spacing">
                <a href="javascript:;" class="weui-btn g-gap j-sub">提交</a>
            </div>
        </div>
    </div>

</div>
<script>
    $(function() {
        FastClick.attach(document.body);
    });
</script>
<script language="JavaScript">
$(function(){
    $('.j-sub').click(function(){
        var groupName = $('#groupName').val();
        var name = $('#name').val();
        var phone = $('#phone').val();
        if(groupName==''){
            $.toptip('请输入公司名称');
            return false;
        }
        if(name==''){
            $.toptip('请输入联系人姓名');
            return false;
        }
        if(phone==''){
            $.toptip('请输入手机号码');
            return false;
        }else{
            var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
            if (!reg.test(phone)) {
                $.toptip('请输入正确的手机号码');
                return false;
            }
        }
        $('#confirm_form').submit();
    })
})
</script>
</body>
</html>