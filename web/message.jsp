<%@ page import="Objects.Const" %>
<%@ page import="com.mysql.cj.jdbc.MysqlDataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 11-09-2018
  Time: 08:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%int room_open = (Integer) request.getAttribute("room_open");%> --%>   <%--Todo: add room_open to Front end--%>
<%! Connection connection;

    @Override
    public void jspInit() {
        try {
            MysqlDataSource dataSource = new MysqlDataSource();
            dataSource.setURL(Const.DBclass);
            dataSource.setUser(Const.user);
            dataSource.setPassword(Const.pass);
            connection = dataSource.getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void jspDestroy() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }%>
<%
    if (session.getAttribute("user") == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        tokenProvider: new Chatkit.TokenProvider({url: "Auth_pusher"})
    });


    <%--chatManager
        .connect()
        .then(currentUser => {
            currentUser.subscribeToRoom({
                roomId: currentUser.rooms[0].id,
                hooks: {
                    onNewMessage: message => {

                        const ul = document.getElementById("message-list");
                        const li = document.createElement("li");
                        var senid = message.senderId;
                        var msg = message.text;
                        li.appendChild(
                            document.createTextNode(senid + ':' + msg)
                        );
                        ul.appendChild(li);
                    }
                }
            });

            const form = document.getElementById("message-form");
            form.addEventListener("submit", e => {
                e.preventDefault();
                const input = document.getElementById("message-text");
                currentUser.sendMessage({
                    text: input.value,
                    roomId: currentUser.rooms[0].id
                });
                input.value = "";
            });
        })
        .catch(error => {
            console.error("error:", error);
        });--%>
</script>
<section style="margin-top:25px;">
    <div class="container1">
        <div class="chat">
            <div class="chat-header clearfix">
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/195612/chat_avatar_01_green.jpg" alt="avatar"/>

                <div class="chat-about">
                    <div class="chat-with">Chat with Vincent Porter</div>

                </div>
            </div> <!-- end chat-header -->

            <div class="chat-history" id="chat">
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
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>