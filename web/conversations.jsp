<%@ page import="Objects.Const" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 20/9/18
  Time: 11:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! Connection connection;

    @Override
    public void jspInit() {
        connection = Const.openConnection();
    }

    @Override
    public void jspDestroy() {
        Const.closeConnection(connection);
    }%>
<%
    if (session.getAttribute("user") == null) {
        request.getRequestDispatcher(Const.root).forward(request, response);
    }
    int userid = (Integer) session.getAttribute("user");
    String user_id = null;
    try {
        PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
        preparedStatement.setInt(1, userid);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        user_id = rs.getString(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Conversions"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<script src="https://unpkg.com/@pusher/chatkit/dist/web/chatkit.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<script type="text/javascript">
    const chatManager = new Chatkit.ChatManager({
        instanceLocator: "<%=Const.Pusher_instanceLocator%>",
        userId: "<%=user_id%>",
        tokenProvider: new Chatkit.TokenProvider({url: "<%=Const.root%>Auth_pusher"})
    });
</script>
<script src="assets/js/chatlist.js"></script>
<%--<section>--%>
    <%--<div class="container">--%>
        <%--<div class="row no-gutters" id="">--%>

        <%--</div>--%>
    <%--</div>--%>
<%--</section>--%>
<script id="chatlist" type="text/x-handlebars-template">
    <%--<div class="col-12 col-lg-8 offset-lg-2">--%>
        <%--<a href="message.jsp?{{userid}}">--%>
            <%--<div class="p-3">--%>
                <%--<div class="float-left chatimgdiv"><img src="<%=Const.S3URL+"user/"%>{{userid}}" class="rounded-circle">--%>
                <%--</div>--%>
                <%--<div class="d-inline-block p-2">--%>
                    <%--<h5 class="fohireclr">{{username}}</h5>--%>
                    <%--<div>--%>
                        <%--<p class="msg">{{message}}</p>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="float-right" style="margin:5px;"><i class="typcn typcn-media-record fohireclr"></i></div>--%>
                <%--<div class="float-right" style="clear:both;">--%>
                    <%--<p style="font-size:13px;">{{time}}</p>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</div>--%>
    <li style="background-color: white;">
        <a href="message.jsp?{{userid}}" >
            <div class="p-2 chatpeople">
                <div class="float-left chatimgdiv"><img src="<%=Const.S3URL+"user/"%>{{userid}}" class="rounded-circle" /></div>
                <div class="d-inline-block p-2">
                    <h5 class="fohireclr">{{username}}</h5>
                    <div>
                        <p class="fohireclr">{{message}}</p>
                    </div>
                </div>
                <div class="float-right" style="clear:both;">
                    <p class="black" style="font-size:13px;">{{time}}</p>
                </div>
            </div>
        </a>
    </li>
</script>
<section style="margin-top: 15px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                <div style="background: #f8b645;">
                    <ul class="list-unstyled" id="chatlistmain">
                        <li style="color: white;font-size: 24px;padding: 10px;"><strong>Messages</strong></li>

                        <%--<li class="nonot"><strong>No notifications</strong></li>--%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
