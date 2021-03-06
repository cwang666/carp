<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${carpConfig.projectName} | ${carpConfig.loginText}</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="icon" type="image/x-icon" href="${rc.contextPath}/favicon.ico">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${rc.contextPath}/webjars/AdminLTE/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${rc.contextPath}/webjars/AdminLTE/dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="${rc.contextPath}/webjars/AdminLTE/plugins/iCheck/square/blue.css">
    <!-- costom css-->
    <link rel="stylesheet" href="${rc.contextPath}/css/common.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>${carpConfig.projectName}</b>${carpConfig.loginText}</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">请登录</p>
    <#if RequestParameters.msg??>
        <span class="error">${RequestParameters.msg}</span>
    </#if>

    <#if RequestParameters.logout??>
        注销成功！
    </#if>
        <form action="${rc.contextPath}/login" method="post">
            <div class="form-group has-feedback">
                <input name="username" type="text" class="form-control" placeholder="用户名" value="${carpConfig.loginUserName}">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input name="password" type="password" class="form-control" placeholder="密码，至少6位字母、数字组合" value="${carpConfig.loginUserPassword}">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <#if needCaptcha>
                <div class="form-group has-feedback captcha">
                    <input id="captchaCode" name="captchaCode" type="text" class="form-control" placeholder="验证码">
                    <img alt="点击更换" src="${rc.contextPath}/login/captcha/image" id="captchaImage"/>
                    <a href="javascript:void(0)" id="captchaTag">看不清，换一个？</a>
                </div>
            </#if>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox"> 两周内记住我
                        </label>
                    </div>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <!--    <div class="social-auth-links text-center">
                <p>- OR -</p>
                <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign in using
                    Facebook</a>
                <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i> Sign in using
                    Google+</a>
            </div>-->
        <!-- /.social-auth-links -->

        <!--<a href="#">I forgot my password</a><br>
        <a href="register.html" class="text-center">Register a new membership</a>-->

    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="${rc.contextPath}/webjars/AdminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${rc.contextPath}/webjars/AdminLTE/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="${rc.contextPath}/webjars/AdminLTE/plugins/iCheck/icheck.min.js"></script>
<script>
    $(function () {
        $("#captchaTag").on('click',function(){refreshCaptchaImage()});
        $("#captchaImage").on('click',function(){refreshCaptchaImage()});
        function refreshCaptchaImage() {
            $("#captchaImage").attr(
                    'src',
                    '${rc.contextPath}/login/captcha/image?'
                    + Math.floor(Math.random() * 100))
                    .fadeIn();
            $('#captchaCode').val('');
        }
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>
</body>
</html>
