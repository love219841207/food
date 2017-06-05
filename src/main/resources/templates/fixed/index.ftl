<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>排餐计划</title>
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
<body class="g-padtom">
<div class="g-qhd">
    <a href="${springMacroRequestContext.contextPath}/delivery/list?choose=1"><img src="${springMacroRequestContext.contextPath}/img/icon3.png" alt="">
        <#if deliveryAddressVO??>
            姓名:${deliveryAddressVO.name} 手机号码:${deliveryAddressVO.phone}
            <input type="hidden" id="deliveryId" value = "${deliveryAddressVO.id}"/>
        <#else>
            <input type="hidden" id="deliveryId" value = ""/>
        </#if>

      </a>
</div>
<div class="g-rhd">
<#assign sumSurplus=0>
<#list surplusList as AccountSurplusVO>
    <#if AccountSurplusVO.surplus??>
        <#assign sumSurplus=sumSurplus +AccountSurplusVO.surplus>
    </#if>
</#list>
    <span class="j-sur" data-sur='${sumSurplus}'>未排餐:${sumSurplus}</span>
<#assign sumUse=0>
<#list fixedList as accountFixedVO>
    <#if accountFixedVO.nn?? >
        <#assign sumUse=sumUse +1>
    </#if>
    <#if accountFixedVO.nt?? >
        <#assign sumUse=sumUse +1>
    </#if>
</#list>
    <span class="j-use" data-use='${sumUse}'>已排餐:${sumUse}</span>
</div>

<div class="g-plan">
    <h2><img src="${springMacroRequestContext.contextPath}/img/ar_dn.png">点击红色排餐和空白处可以修改<img src="${springMacroRequestContext.contextPath}/img/ar_dn.png"></h2>

    <table>
        <tr>
            <th width="25%" class="u-tab1"></th>
            <th width="40%" class="u-tab2">午餐</th>
            <th class="u-tab3">晚餐</th>
        </tr>

        <#list fixedList as accountFixedVO>
            <tr data-date="${accountFixedVO.fixDate?date}">
                <td class="u-tab1">${accountFixedVO.fixDate?date} <em>${accountFixedVO.weekDay}</em></td>
                <td class="u-tab2 j-swid" data-time='1' data-type="${accountFixedVO.nn!}" >
                    <#if accountFixedVO.nn??>
                        <#if accountFixedVO.nn=='1'>
                            元气健身
                        <#else>
                            均衡纤体
                        </#if>
                    </#if>
                </td>
                <td class="u-tab3 j-swid" data-time='2' data-type="${accountFixedVO.nt!}" >
                        <#if accountFixedVO.nt??>
                            <#if accountFixedVO.nn=='1'>
                                元气健身
                            <#else>
                                均衡纤体
                            </#if>
                        </#if>
                </td>
            </tr>
        </#list>
    </table>
</div>

<div class="g-bottom">
    <a href="#" class="j-wid">确认排餐</a>
</div>



<div class="mask"></div>
<div class="g-wid">
    <img src="${springMacroRequestContext.contextPath}/img/z-del.png" class="j-del">
    <h2></h2>
    <span>选择套餐</span>
    <div class="u-det j-sel">
    <#assign time1Type1=0>
    <#assign time1Type2=0>
    <#assign time2Type1=0>
    <#assign time2Type2=0>
    <#list surplusList as accountSurplusVO>
        <#if accountSurplusVO.timeMenu=='1'>
            <#if accountSurplusVO.typeMenu=='1'>
                <#assign time1Type1=time1Type1 +accountSurplusVO.surplus>
            <#else>
                <#assign time1Type2=time1Type2 +accountSurplusVO.surplus>
            </#if>
        <#else>
            <#if accountSurplusVO.typeMenu=='1'>
                <#assign time2Type1=time2Type1 +accountSurplusVO.surplus>
            <#else>
                <#assign time2Type2=time2Type2 +accountSurplusVO.surplus>
            </#if>
        </#if>

    </#list>

        <a href="javascript:void(0);"  data-surplus="1,1,${time1Type1}" class="hide">元气健身</a>
        <a href="javascript:void(0);"  data-surplus="1,2,${time1Type2}" class="hide">均衡纤体</a>
        <a href="javascript:void(0);" data-surplus="2,1,${time2Type1}" class="hide">元气健身</a>
        <a href="javascript:void(0);"  data-surplus="2,2,${time2Type2}" class="hide">均衡纤体</a>
        <a href="javascript:void(0);" class="j-cancle hide">取消套餐</a>
    </div>
    <p class="red j-non hide">您没有可用的套餐!</p>

</div>
<script>
    $(function() {
        FastClick.attach(document.body);
    });
    $(function(){
        $('.j-wid').click(function(){
            var _devid =  $('#deliveryId');
            if(_devid.val()==''){
                alert("请配置送货地址!");
                return false;
            }
            var _arr = $('.g-plan table tr:gt(0)');
            var _data = [];
            _arr.each(function(index, el) {
                var _fixDate = $(this).attr('data-date');
                var _nn_type = $(this).children(':eq(1)').attr('data-type');
                var _nt_type = $(this).children(':eq(2)').attr('data-type');
                if(_nn_type!=undefined&&_nn_type!=null&&_nn_type!=''){
                    var _o = {};
                    _o._fixDate = _fixDate;
                    _o._nn = _nn_type;
                    _o._devId = _devid.val();
                    _data.push(_o);
                }
                if(_nt_type!=undefined&&_nt_type!=null&&_nt_type!=''){
                    var _o = {};
                    _o._fixDate = _fixDate;
                    _o._nt = _nt_type;
                    _o._devId = _devid.val();
                    _data.push(_o);
                }
            });
            $.ajax({
                type: "POST",
                url: "${springMacroRequestContext.contextPath}/fixed/save",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(_data),
                //dataType: "json",
                success: function (message) {
                    alert('提交成功!');
                    location.reload();
                },
                error: function (message) {

                }
            });
        });

//点击排餐
        var _globe_st;
        var _mask = $('.mask'),_wid = $('.g-wid');
        $('.j-swid').click(function(event) {
            _globe_st = $(this);
            var _date = $(this).addClass("j-on").parent().attr('data-date');
            var _type = $(this).attr('data-type');
            var _time = $(this).attr('data-time');
            if( _globe_st.attr('data-type')==''){
                var _h2 = '排餐：';
                _h2+=_date;
                _h2+=' ';
                _h2+=(_type=='1'?"午餐":"晚餐");
                $('.g-wid h2').text(_h2);
                var _arr = $('.j-sel a:lt(4)');
                var _noneSel = false;
                _arr.each(function(index, el) {
                    var _datas = $(this).attr('data-surplus');
                    if(_datas.split(',')[0]==_time
                            &&_datas.split(',')[2]>0){
                        $(this).removeClass('hide');
                        _noneSel = true;
                    }else{
                        $(this).addClass('hide');
                    }
                });
                if(!_noneSel){
                    $('.j-non').show();
                }else{
                    $('.j-non').hide();
                }
                $('.j-cancle').addClass('hide');
                _wid.show();
                _mask.show();
            }else{

                var _sel_opt = _globe_st.attr('data-time');
                _sel_opt +=',';
                _sel_opt +=_globe_st.attr('data-type');
                var _surplus = $("[data-surplus^='"+_sel_opt+"']").attr('data-surplus').split(',');
                console.log('返回库存前：'+_surplus);
                _surplus[2] = parseInt(_surplus[2])+1 ;
                $("[data-surplus^='"+_sel_opt+"']").attr('data-surplus',_surplus.join(','));
                console.log('返回库存后：'+_surplus);


                //处理页头
                var _sur = $('.j-sur').attr('data-sur');
                var _use = $('.j-use').attr('data-use');
                $('.j-sur').attr('data-sur',parseInt(_sur)+1);
                $('.j-use').attr('data-use',parseInt(_use)-1);
                $('.j-sur').text('未排餐:'+$('.j-sur').attr('data-sur'));
                $('.j-use').text('已排餐:'+$('.j-use').attr('data-use'));
                _globe_st.text('');
                _globe_st.attr('data-type','');
            }

        });

//点击关闭弹窗
        $('.j-del').click(function(){
            _mask.hide();
            _wid.hide();

        });

// 弹窗里的单选
        $('.j-sel a').click(function(){

            //处理页头
            var _sur = $('.j-sur').attr('data-sur');
            var _use = $('.j-use').attr('data-use');


            $('.j-sur').attr('data-sur',parseInt(_sur)-1);
            $('.j-use').attr('data-use',parseInt(_use)+1);
            $('.j-sur').text('未排餐:'+$('.j-sur').attr('data-sur'));
            $('.j-use').text('已排餐:'+$('.j-use').attr('data-use'));



            //处理扣减
            var _datas = $(this).attr('data-surplus').split(',');
            console.log('处理扣减前：'+$(this).attr('data-surplus'));
            _datas[2] = parseInt(_datas[2]) - 1;
            $(this).attr('data-surplus',_datas);
            console.log('处理扣减前：'+$(this).attr('data-surplus'));
            //处理返回
            var _txt = $(this).text();
            _globe_st.text(_txt);
            _globe_st.attr('data-type',_datas[1]);


            _mask.hide();
            _wid.hide();
        });
    })
</script>

</body>
</html>