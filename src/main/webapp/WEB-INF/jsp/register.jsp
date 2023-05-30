<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
<%--    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">--%>
    <link href="css/register.css" rel="stylesheet">
</head>
<body>

<div class="form-div">
    <div class="reg-content">
        <h1>欢迎注册</h1>
        <span>已有帐号？</span> <a href="${pageContext.request.contextPath}/">登录</a>
    </div>
    <form id="reg-form" action="${pageContext.request.contextPath}/registerCodecontroller" method="post">

        <table>

            <tr>
                <td>用户名</td>
                <td class="inputs">
                    <input name="name" type="text" id="name " required>
                    <br>
                    <span id="username_err" class="err_msg" >${register_msg}</span>
                </td>

            </tr>

            <tr>
                <td>密码</td>
                <td class="inputs">
                    <input name="password" type="password" id="password" required>
                    <br>
                    <span id="password_err" class="err_msg" style="display: none">${register_msg}</span>
                </td>
            </tr>

<%--            <tr>
                <td>验证码</td>
                <td class="inputs">

                    <input type="text" placeholder="输入四位验证码" name="captcha" id="captcha" />
                    <img src="checkCaptchaCode.do" id="createCheckCode"/>

                </td>
            </tr>--%>
            <tr>
                <td>性别</td>
                <td class="inputs">
                    <input name="sex" type="text" id="sex" required>
                    <br>
                </td>
            </tr>

            <tr>
                <td>生日</td>
                <td class="inputs">
                    <input name="birth" type="date" id="birth" required>
                    <br>
                </td>
            </tr>
            <tr>
                <td>地址</td>
                <td class="inputs">
                    <input name="address" type="text" id="address" required>
                    <br>
                </td>
            </tr>
            <tr>
                <td>电话</td>
                <td class="inputs">
                    <input name="phone" type="text" id="phone" required>
                    <br>
                </td>
            </tr>
            <tr>
                <td>验证码</td>
                <td class="inputs">
                    <input name="checkCode" type="text" id="checkCode" required>
                    <img id="checkcodeimg" src="${pageContext.request.contextPath}/Codecontroller">
                    <a href="#" id="changeImg">看不清？</a>
                </td>
            </tr>

        </table>

        <div class="buttons">
            <input value="注 册" type="submit" id="reg_btn">
        </div>
        <br class="clear">
    </form>

</div>

<script>
    document.getElementById("changeImg").onclick =function (){
        document.getElementById("checkcodeimg").src="Codecontroller?"+new Date().getMilliseconds();
    }

</script>
</body>
</html>