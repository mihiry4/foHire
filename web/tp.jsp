<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 10:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! String user; %>
<% if((session!=null) && (session.getAttribute("user")!=null)) {user = (String)session.getAttribute("user");} %>
<html>
<head>
    <title><%= user %></title>
</head>
<body>
    welcome <%= user %>
</body>
</html>
