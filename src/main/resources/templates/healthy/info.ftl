<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>健康问卷</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />
    <meta name="format-detection" content="telephone=no,address=no,email=no" />
    <meta name="mobileOptimized" content="width" />
    <meta name="handheldFriendly" content="true" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/food.css" />
    <link rel="stylesheet" href="${springMacroRequestContext.contextPath}/css/jquery-weui.css" />
    <script src="${springMacroRequestContext.contextPath}/js/jquery.1.8.3.min.js"></script>
    <script src="${springMacroRequestContext.contextPath}/js/jquery-weui.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>


</head>
<body>

<div class="g-inquire">
    <h2>问卷</h2>
    <form action="${springMacroRequestContext.contextPath}/healthy/save" method="post" id="confirm_form">
        <input type="hidden" name="id" value="${healthyInfoVO.id!''}">
        <input type="hidden" name="userId" value="${healthyInfoVO.userId}">
    <dl>
        <dt>性别</dt>
        <dd class="u-sex">
            <span><input type="radio" name="sex" value="0" <#if healthyInfoVO.sex==0>checked="true"</#if>>男</span>
            <span><input type="radio" name="sex" value="1" <#if healthyInfoVO.sex==1>checked="true"</#if>>女</span>
        </dd>

        <dt>出生年月</dt>
        <dd class="u-year"><input class="weui_input" id="time" type="date" value="${healthyInfoVO.birthday?string("yyyy-MM-dd")}"><input type="text"  name="birthday" value="${healthyInfoVO.birthday?string("yyyy-MM-dd")}" class="dispaly_value"/></dd>

        <dt>身高</dt>
        <dd class="u-heg"><input type="number" name="height" id="height" step="0.1" value="${healthyInfoVO.height!''}" placeholder="请输入您的身高"> 厘米</dd>

        <dt>体重</dt>
        <dd class="u-heg"><input type="number" name="weight" id="weight" step="0.1" value="${healthyInfoVO.weight!''}" placeholder="请输入您的体重"> 公斤</dd>

        <dt>运动量</dt>
        <dd class="u-sel">
            <span><input type="radio" name="activity" value="0" <#if healthyInfoVO.activity==0>checked="true"</#if>>卧床静养</span>
            <span><input type="radio" name="activity" value="1" <#if healthyInfoVO.activity==1>checked="true"</#if>>极少运动 </span>
            <span><input type="radio" name="activity" value="2" <#if healthyInfoVO.activity==2>checked="true"</#if>>稍微运动（每周1-3次） </span>
            <span><input type="radio" name="activity" value="3" <#if healthyInfoVO.activity==3>checked="true"</#if>>中度运动（每周3-5次） </span>
            <span><input type="radio" name="activity" value="4" <#if healthyInfoVO.activity==4>checked="true"</#if>>积极运动（每周6-7次） </span>
            <span><input type="radio" name="activity" value="5" <#if healthyInfoVO.activity==5>checked="true"</#if>>专业运动  </span>

        </dd>

        <dt>您托管饮食的主要目的是</dt>
        <dd class="u-sig">
            <span><input type="radio" name="target" value="0" <#if healthyInfoVO.target==0>checked="true"</#if>>纤体减重</span>
            <span><input type="radio" name="target" value="1" <#if healthyInfoVO.target==1>checked="true"</#if>>增肌健身</span>
        </dd>
    </dl>
    </form>

</div>

<div class="g-bottom ">
    <a href="#" class="j-sub">提交问卷</a>
</div>
<script>
    $(function() {
        FastClick.attach(document.body);
    });
</script>
<script>
    //日历
    $("#time").datetimePicker({
        min: "1950-01-01"
    });

    $(".j-sub").click(function(){
       /* var regex = /^([1-9]\d{0,15}|0)(\.\d{1,2})?$/;
        var _height = $('#height').val();
        var _weight = $('#weight').val();
        if(_height==''){
            $.alert("请填写身高,最多保留两位小数!");
            return false;
        }else{
            if(!regex.test(_height)){
                $.alert("请填写身高,最多保留两位小数!");
                return false;
            }
        }
        if(_weight==''){
            $.alert("请填写体重!");
            return false;
        }else{
            if(!regex.test(_weight)){
                $.alert("请填写体重,最多保留两位小数!");
                return false;
            }
        }*/
        $('#confirm_form').submit();
    })



</script>

</body>
</html>