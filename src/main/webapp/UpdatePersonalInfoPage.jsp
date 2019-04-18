<%@ page import="java.sql.Connection" %>
<%@ page import="Tool.ConnHelper" %>
<%@ page import="Model.UserSave" %>
<%@ page import="DAO.UserSaveDAO" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: zuikaku
  Date: 19-4-16
  Time: 下午5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在更新你的个人信息</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");//设置request的编码格式，防止中文乱码
        int uid=Integer.parseInt(request.getParameter("userid"));
        String newNickname=request.getParameter("nickname");//不设置全局编码格式则使用new String(request.getParameter("nickname").getBytes("iso-8859-1"),"utf-8") ;
        String newPassword=request.getParameter("password");
        User user=(User) session.getAttribute("user");
        UserSave userSave=(UserSave) session.getAttribute("userSave");
    %>
    当前用户id<%=uid%>
    新昵称<%=newNickname%>
    新密码<%=newPassword%>
    <%
        Connection conn= ConnHelper.ConnectToMySql();
        boolean isPasswordChanged= UserDAO.UpdatePasswordByid(conn,uid,newPassword);
        boolean isNickNameChanged= UserSaveDAO.UpdateNickNameByUserid(conn,uid,newNickname);
        ConnHelper.CloseConnectionWithMySql(conn);
        //修改成功后，session中存储的内容也要更新
        //重新生成新的对象放入session
        User newUser=new User(user.getId(),user.getEmail(),newPassword,user.getIdcard(),user.isAdmin(),user.isRoot());
        UserSave newUserSave=new UserSave(userSave.getId(),userSave.getUserid(),newNickname,userSave.getBaselevel(),userSave.getCoin(),userSave.getDiamond());
        session.removeAttribute("user");//清空session
        session.removeAttribute("userSave");
        session.setAttribute("user",newUser);
        session.setAttribute("userSave",newUserSave);
    %>

</body>
<script type="text/javascript">
    //console.log(<%=newNickname%>);
    var isPasswordChanged=<%=isPasswordChanged%>;
    var isNickNameChanged=<%=isNickNameChanged%>;
    if(isPasswordChanged&&isNickNameChanged)
    {
        window.alert("更改已生效");

    }else{
        window.alert("更改未生效");
    }
    //回到页面
    window.location.href="PersonalData.jsp";
</script>
</html>
