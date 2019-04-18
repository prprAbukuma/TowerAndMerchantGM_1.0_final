<%@ page import="Tool.ConnHelper" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Model.User" %>
<%@ page import="org.w3c.dom.UserDataHandler" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="Model.UserSave" %>
<%@ page import="DAO.UserSaveDAO" %><%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-3
  Time: 下午9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在执行登录</title>
</head>
<body>
<%
    //获得传来的邮箱和密码
    String email=request.getParameter("email");
    String password=request.getParameter("password");
    //标志位
    String state="STANDBY";
    //todo 数据库操作-开启数据库连接
    Connection conn= ConnHelper.ConnectToMySql();
    User loginedUser= UserDAO.UserLogin(conn,email,password);
    if(loginedUser==null)
    {
        // 登录失败,提示用户,密码错误
        state="FAILED";
    }else{
        //todo 登录成功，查询该玩家的游戏数据，玩家数据存入session
        UserSave userSave= UserSaveDAO.GetUserSaveByUserid(conn,loginedUser.getId());
        session.setAttribute("user",loginedUser);//该User类需要序列化
        if(userSave!=null)
        {
            session.setAttribute("userSave",userSave);
        }

        state="SUCCESSFUL";

    }

%>
邮箱账号<%=email%>
密码<%=password%>
</body>
<script type="text/javascript">

    while (true)
    {

        if("<%=state%>"==="FAILED")
        {
            window.alert("密码错误");
            window.location.href="LoginPage.jsp";
            break;
        }else if("<%=state%>"==="SUCCESSFUL")
        {
            //todo 定向到个人信息界面
            window.location.href="PersonalData.jsp";
            break;
        }
    }
</script>
</html>
