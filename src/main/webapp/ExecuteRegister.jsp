<%@ page import="DAO.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Tool.ConnHelper" %><%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-2
  Time: 下午9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在执行注册</title>
</head>
<body>
    <%
        //获得来自注册界面的表单数据
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        String adminCode=request.getParameter("adminCode");
        String idCard=request.getParameter("idCard");
    %>
    邮箱<%=email%>
    密码<%=password%>
    管理员码<%=adminCode%>
    身份证<%=idCard%>
    <%
        //标志位
        String state="STANDBY";//js用
        boolean isOK=false;
        //建立数据库连接
        Connection conn= ConnHelper.ConnectToMySql();
        //判断注册者的身份
        if(adminCode.equals("cdut"))
        {
            //管理员方式
            isOK= UserDAO.InsertUser(conn,email,password,idCard,true);

        }else{
            //一般玩家注册
            isOK= UserDAO.InsertUser(conn,email,password,idCard,false);
        }
        if(isOK)
        {
            state="SUCCESSFUL";
        }else {
            state="FAILED";
        }
        //关闭数据库连接
        ConnHelper.CloseConnectionWithMySql(conn);
    %>
</body>
<script type="text/javascript">
    while(true)
    {
        if("<%=state%>"==="SUCCESSFUL")
        {
            //注册成功-告知用户-并回到主页
            window.alert("注册成功");
            window.location.href="index.jsp";
            window.close();
            break;

        }else if("<%=state%>"==="FAILED")
        {
            //注册失败-告知用户-并回到注册页面
            window.alert("注册失败");
            window.location.href="RegisterPage.jsp";
            window.close();
            break;
        }
    }
</script>
</html>
