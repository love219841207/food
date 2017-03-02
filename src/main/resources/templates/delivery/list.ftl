<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, minimal-ui" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"content="telephone=no, email=no" />
    <title>配送地址</title>
    <meta name="description" id="description" content="YOTA 美食" />
    <link href="${springMacroRequestContext.contextPath}/css/user.css" rel="stylesheet" type="text/css">
    <script src="${springMacroRequestContext.contextPath}/js/zepto.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
</head>
<body>
<div class="adr-box">

        <#list list as deliver>
        <div class="adr" >
            <#if (deliver.dft)??>
                <div class="select"></div>
            </#if>

            <div class="body j-sel">
                ${deliver.name}<span>${deliver.phone}</span>
                <p>${deliver.addressName} -> ${deliver.addressExtend}</p>
            </div>
            <div class="control j-edit" v="${deliver.id}"></div>
        </div>
        </#list>


    <a href="javascript:void(0)" ><button class="btm-w80 j-btn">添加配送地址</button> </a>
</div>
<script language="JavaScript">
    $(function() {
        FastClick.attach(document.body);
    });
    $(function(){
        $('.j-btn').tap(function(){
            location.href="${springMacroRequestContext.contextPath}/delivery/edit";
        });
        $('.j-edit').tap(function(){
            location.href="${springMacroRequestContext.contextPath}/delivery/edit?id="+$(this).attr('v');
        })
    })
</script>
</body>


