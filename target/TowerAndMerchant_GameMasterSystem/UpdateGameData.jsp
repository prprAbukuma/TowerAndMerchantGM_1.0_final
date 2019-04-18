<%@ page import="Model.UserSave" %>
<%@ page import="Model.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Tool.ConnHelper" %>
<%@ page import="DAO.UserSaveDAO" %><%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-17
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更改游戏数据中</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");//设置request的编码格式，防止中文乱码
    byte newbaseLevel=Byte.parseByte(request.getParameter("baseLevel"));
    int newCoins=Integer.parseInt(request.getParameter("coins"));
    int newDiamonds=Integer.parseInt(request.getParameter("diamonds"));

    UserSave userSave=(UserSave) session.getAttribute("userSave");
    int userid=userSave.getUserid();
%>
用户id<%=userid%>
更改后的基地等级<%=newbaseLevel%>
更改后的银币数量<%=newCoins%>
更改后的钻石数量<%=newDiamonds%>
<%
    Connection conn= ConnHelper.ConnectToMySql();
    boolean isSuccessful= UserSaveDAO.UpdatePlayerResourcesByuid(conn,userid,newbaseLevel,newCoins,newDiamonds);
    if(isSuccessful)
    {
        //若更改成功，重新设置session中的玩家资源
        session.removeAttribute("userSave");//清空原有的session
        UserSave newUserSave=new UserSave(userSave.getId(),userSave.getUserid(),userSave.getNickname(),newbaseLevel,newCoins,newDiamonds);
        session.setAttribute("userSave",newUserSave);
    }
%>
</body>
<script type="text/javascript">
    if(<%=isSuccessful%>)
    {
        window.alert("更改已生效");
        window.location.href="GameData.jsp";
    }else {
        window.alert("更改未生效");
        window.location.href="GameData.jsp";
    }
</script>
</html>
