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
      <link href="${springMacroRequestContext.contextPath}/css/food.css" rel="stylesheet" type="text/css">
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

        <#if choose=='1'>
            <a href="${springMacroRequestContext.contextPath}/fixed/index?deliveryId=${deliver.id}">
        </#if>
            <#if choose=='2'>
            <a href="${springMacroRequestContext.contextPath}/order/create?deliveryId=${deliver.id}">
            </#if>
            <div class="body j-sel">
                ${deliver.name}<span>${deliver.phone}</span>
                <p>${deliver.addressName} -> ${deliver.addressExtend}</p>
            </div>
            <#if choose??>
            </a>
            </#if>
            <div class="control j-edit" v="${deliver.id}"></div>
        </div>
        </#list>
        <#if (list?size <1)>
        <div class="g-case">
            <div class="con">
                <div class="no-case">
                    <img src="${springMacroRequestContext.contextPath}/img/no-adr.png" alt=""> <br>您还没有配送地址
                </div>
            </div>

        </#if>



                <!--a href="javascript:void(0)" ><button class="btm-w80 j-btn">添加配送地址</button> </a>-->
    
    <div class="g-bottom">
 		<a href="#" class="j-btn">添加配送地址</a>
	</div>
    
</div>


<script language="JavaScript">
    $(function() {
        FastClick.attach(document.body);
    });
    $(function(){
        $('.j-btn').tap(function(){
            location.href="${springMacroRequestContext.contextPath}/delivery/edit?choose=${choose}";
        });
        $('.j-edit').tap(function(){
            location.href="${springMacroRequestContext.contextPath}/delivery/edit?id="+$(this).attr('v')+"&choose=${choose}";
        })
    })
</script>
</body>


