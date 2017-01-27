<html>
<head>
    <script type="text/javascript" src="http://cdn.uedsc.com/zepto/1.1.6/zepto.min.js"/></script>
</head>
<body>
<form action="">
    <h1>需要绑定</h1>
    11111<input type="text" id="phone" name="phone"/>
    2222<input type="text" id="code" name="code"/>
    <input class="f-code" type="button" id="codebtn" value="验证码"/>
</form>
        <script type="text/javascript">
    $(function(){
        $('.f-code').click(function(){
            var _phone=$('#phone').val();
            $.ajax({
                type: 'GET',
                url: '/common/regeditCode/'+_phone,
                timeout: 3000,

                success: function(data){
                   console.log(data);
                },
                error: function(xhr, type){
                    alert('系统繁忙，请稍后再试!')
                }
            })
        });
    })
</script>
</body>
</html>