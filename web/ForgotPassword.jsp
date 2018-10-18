<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 5/10/18
  Time: 12:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (request.getSession().getAttribute("user") == null)
        request.getRequestDispatcher("index.jsp").forward(request, response);
%>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
