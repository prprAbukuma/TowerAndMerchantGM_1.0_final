<%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-3-29
  Time: 下午2:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
</head>
<link rel="stylesheet" type="text/css" href="Resources/LoginPage/styles.css">
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>欢迎登录GM系统</h1>

            <form action="ExecuteLoginPage.jsp" name="loginForm" class="form" method="post">
                <input name="email" id="emailInput" type="text" placeholder="邮箱">
                <input name="password" id="passwordInput" type="password" placeholder="密码">
                <button type="button" id="login-button" onclick="login()">登录</button>
                <p>&nbsp;</p>
                <a href="ForgetPasswordPage.jsp" style="text-decoration: none;color: white;" id="forget-password">忘记密码</a>
            </form>
        </div>

        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>





</body>
<script type="text/javascript">
    var emailInput=document.getElementById("emailInput");
    var passwordInput=document.getElementById("passwordInput");
    function checkUserInput() {
        var emaliRegex=/[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]+/;
        if(emaliRegex.test(emailInput.value))
        {
            // 邮箱格式正常,检查密码是否为空
            if(passwordInput.value!==null&&passwordInput.value!=="")
            {
               return true

            }else{
                window.alert("密码不能为空");
                return false;
            }
        }else{
            window.alert("邮箱格式不正确");
            return false;
        }
        
    }
    
    function login() {
        var isOk=checkUserInput();
        if(isOk)
        {
            //window.alert("请求已提交");
            loginForm.submit();
        }
    }
</script>
</html>
