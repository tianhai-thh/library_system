<%@ page contentType="text/html;charset=UTF-8"  language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆首页</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/js.cookie.js"></script>
    <style>
        #login{
           height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
</head>
<body background="img/u2.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<c:if test="${!empty error}">
    <script>
            alert("${error}");
            window.location.href="login.html";
</script>
</c:if>
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>

<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="text" class="form-control" id="email" placeholder="请输入邮箱">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div>
<%--            <label for="checkCode">密码</label>
            <input type="password" class="form-control" id="checkCode" placeholder="请输入密码">
            <td>验证码</td>--%>
            <div class="inputs">
                <input name="checkCode" type="text" id="checkCode" placeholder="请输入验证码" required>
                <img id="checkcodeimg" src="${pageContext.request.contextPath}/Codecontroller">
                <a href="#" id="changeImg">看不清？</a>
            </div>
        </div>
        <span id="username_err" class="err_msg" >${register_msg}</span>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>
        </div>
        <div id="subDiv">
            <a href="${pageContext.request.contextPath}/toregister">没有账号？-> 注册</a>
        </div>
        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">登陆
        </button>
    </div>
</div>
    <script>
        document.getElementById("changeImg").onclick =function (){
            document.getElementById("checkcodeimg").src="Codecontroller?"+new Date().getMilliseconds();
        }

    </script>
    <script>
/*        $("#id").keyup(
            function () {
                if(isNaN($("#id").val())){
                    $("#info").text("提示:账号只能为数字");
                }
                else {
                    $("#info").text("");
                }
            }
        )*/
        // 记住登录信息
        function rememberLogin(username, password, checked) {
            Cookies.set('loginStatus', {
                email: email,
                password: password,
                remember: checked
            }, {expires: 30, path: ''})
        }
        // 若选择记住登录信息，则进入页面时设置登录信息
        function setLoginStatus() {
            var loginStatusText = Cookies.get('loginStatus')
            if (loginStatusText) {
                var loginStatus
                try {
                    loginStatus = JSON.parse(loginStatusText);
                    $('#email').val(loginStatus.email);
                    $('#passwd').val(loginStatus.password);
                    $("#remember").prop('checked',true);
                } catch (__) {}
            }
        }

        // 设置登录信息
        setLoginStatus();
        $("#loginButton").click(function () {
            var email =$("#email").val();
            var passwd=$("#passwd").val();
            var checkCode=$("#checkCode").val();
            var remember=$("#remember").prop('checked');
            if (email == '') {
                $("#info").text("提示:邮箱不能为空");
            }
            else if( passwd ==''){
                $("#info").text("提示:密码不能为空");
            }
/*            else if(isNaN( id )){
                $("#info").text("提示:账号必须为数字");
            }*/
            else {
                $.ajax({
                    type: "POST",
                    url: "/api/loginCheck",
                    data: {
                        email:email ,
                        passwd: passwd,
                        checkCode:checkCode
                    },
                    dataType: "json",
                    success: function(data) {
                        if (data.stateCode.trim() === "0") {
                            $("#info").text("提示:邮箱或密码错误！");
                        } else if (data.stateCode.trim() === "1") {
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href="/admin_main.html";
                        } else if (data.stateCode.trim() === "2") {
                            if(remember){
                                rememberLogin(email,passwd,remember);
                            }else {
                                Cookies.remove('loginStatus');
                            }
                            $("#info").text("提示:登陆成功，跳转中...");
                            window.location.href="/reader_main.html";
                        }else if(data.stateCode.trim() == 3)
                        {
                            $("#info").text("提示:验证码错误");
                        }
                    }
                });
            }
        })

    </script>
</div>

</body>
</html>
