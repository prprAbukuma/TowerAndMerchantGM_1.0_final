<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Tool.SendEmail" %>
<%@ page import="Tool.ConnHelper" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="java.util.Random" %>
<%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-1
  Time: 下午8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>生成邮箱验证码并发送中</title>
</head>
<body>
<div class="center">
    <%
    //标志位
    String state="STANDBY";
    //获得邮箱地址
    String email=request.getParameter("email");
    //邮箱验证码
    String emailSecurityCode="";
    %>
    邮箱地址是<%=email%>
    <%
    //进行数据库连接
    Connection conn=ConnHelper.ConnectToMySql();
    //判断邮箱是否存在
    boolean emailIsExist= UserDAO.JudgeEmailExist(conn,email);
    //关闭数据库连接
    ConnHelper.CloseConnectionWithMySql(conn);
    if(!emailIsExist)
     {
       // 生成验证码6位，并发送邮件，告知用户
        emailSecurityCode= String.valueOf((new Random().nextInt(899999) + 100000));
        SendEmail.Instance().SendEmail(email,"你正在注册箭塔与商人","你的邮件验证码是："+emailSecurityCode);
        // 验证码存入cookie
         Cookie cookie=new Cookie("emailSecurityCode",emailSecurityCode);
         cookie.setMaxAge(600);
         //cookie存入客户端
         response.addCookie(cookie);
        state="SUCCESSFUL";

     }else {
        // 邮箱已经存在，告知用户
        state="FAILED";
     }

    %>


</div>
</body>
<script type="text/javascript">

    while (true)
    {
        var stateMent="<%=state%>";
        if(stateMent==="SUCCESSFUL")
        {
            window.alert("邮件已下发到："+"<%=email%>");
            //todo 测试阶段保留 url中的securityCode部分
            window.location.href="RegisterPage.jsp?email="+"<%=email%>";//+"&securityCode="+"<%=emailSecurityCode%>";
            break;
        }else if(stateMent==="FAILED")
        {
            window.alert("<%=email%>"+"邮箱已存在");
            window.location.href="RegisterPage.jsp?email="+"<%=email%>";
            break;
        }
    }
</script>
</html>
