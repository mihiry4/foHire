<%@ page import="Objects.Const" %>
<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 11-09-2018
  Time: 08:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String user_id = (String) request.getAttribute("u");
    String oUserName = (String) request.getAttribute("otheru");
    String oFirstName = (String) request.getAttribute("otherf");
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="messages"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<script src="https://unpkg.com/@pusher/chatkit/dist/web/chatkit.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<script>
    var chatManager = new Chatkit.ChatManager({
        instanceLocator: "<%=Const.Pusher_instanceLocator%>",
        userId: "<%=user_id%>",
        tokenProvider: new Chatkit.TokenProvider({url: "<%=Const.root%>Auth_pusher"})
    });
    var ouid = "<%=oUserName%>";
</script>
<script src="assets/js/chat.js"></script>
<section style="margin-top:25px;">
    <div class="container1">
        <div class="chat">
            <div class="chat-header clearfix">
                <div class="chat-about">
                    <div class="chat-with">Chat with <%=oFirstName%>
                    </div>

                </div>
            </div> <!-- end chat-header -->

            <div class="chat-history" id="chat">
                <div class="loader spin" id="spinner"></div>
                <ul type="none" id="chathistory">

                </ul>

            </div> <!-- end chat-history -->

            <div class="chat-message clearfix">
                <form id="message-form">
                    <div class="form-group d-flex">
                        <input type='text' id='message-text' class="form-control" autocomplete="off"
                               placeholder="Type your message...">

                        <button type="submit" class="btn qbtn d-inline"><i class="fa fa-arrow-up"
                                                                           style="color:white"></i></button>
                    </div>
                </form>

            </div> <!-- end chat-message -->
        </div> <!-- end container -->

        <script id="messaget" type="text/x-handlebars-template">
            <li class="clearfix">
                <div class="message-data align-right">
                    <span class="message-data-time">{{time}}, {{msgdate}} , {{msgday}}</span> &nbsp; &nbsp;
                    <span class="message-data-name">{{user}}</span> <i class="fa fa-circle me"></i>
                </div>
                <div class="message other-message float-right">
                    {{message}}
                </div>
            </li>
        </script>


        <script id="messager" type="text/x-handlebars-template">
            <li>
                <div class="message-data">
                    <span class="message-data-name"><i class="fa fa-circle online"></i> {{user}}</span>
                    <span class="message-data-time">{{time}}, {{msgdate}}</span>
                </div>
                <div class="message my-message">
                    {{message}}
                </div>
            </li>
        </script>
    </div>

</section>
<%--<%}%>--%>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>