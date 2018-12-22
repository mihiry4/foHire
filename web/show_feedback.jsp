<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 22-12-2018
  Time: 22:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Objects.Const" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Deactivate"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<section>
    <div class="container mt-4">
        <h2>Feedback summary</h2>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>E-mail</th>
                    <th>Feedback</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Abc</td>
                    <td>askdj@kaskld</td>
                    <td>asjdbasdbabaskjdajsd</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>
