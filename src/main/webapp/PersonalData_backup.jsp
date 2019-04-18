<%@ page import="Model.User" %>
<%@ page import="Model.UserSave" %><%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-8
  Time: 下午5:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息</title>
</head>
<body>
<%
    User user=(User) session.getAttribute("user");
    UserSave userSave=(UserSave) session.getAttribute("userSave");
%>
信息:
id<%=user.getId()%>
密码<%=user.getPassword()%>>
昵称<%=userSave.getNickname()%>
邮箱<%=user.getEmail()%>
基地等级<%=userSave.getBaselevel()%>
金币<%=userSave.getCoin()%>
钻石<%=userSave.getDiamond()%>

</body>
</html>
