<%@ page import="Objects.Const" %>
<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 20/9/18
  Time: 11:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String user_id = (String) request.getAttribute("u");%>
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
<script id="chatlist" type="text/x-handlebars-template">
    <li style="background-color: white;">
        <a href="<%=Const.root%>message/{{userid}}">
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
                <div class="loader spin" id="spinner"></div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
