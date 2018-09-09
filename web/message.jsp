<%@ page import="Objects.user" %>
<%@ page import="Objects.message" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="Objects.DB" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 29-08-2018
  Time: 05:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%! Connection connection;

    @Override
    public void jspInit() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (Exception e) {
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="messages"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<%
    if (session == null || session.getAttribute("user") == null) {
        request.getRequestDispatcher("404.jsp").forward(request, response);
    } else {
        int user_id = (int) session.getAttribute("user");
        user u = new user();
        u.userid = user_id;
        message[] m = u.getMessages(connection);

%>
<script>
    $(document.ready(function () {
        $(".conversation").click(function (e) {
            var btn = $(e.target);
            var i = btn.id;
            $.post("DeliverMessages", {
                EMail: i
            }, function (data) {
                $("#mesgs").html(data);
            }).fail(function () {
                $("#mesgs").text("Could not load the messages");
            });
        });
    }));
</script>
<section style="margin-top:25px;">
    <div class="container">

        <div class="messaging">
            <div class="inbox_msg">
                <div class="inbox_people">

                    <div class="inbox_chat">
                        <div class="chat_list active_chat">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>


                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                        <div class="chat_list">
                            <div class="chat_people">
                                <div class="chat_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                                <div class="chat_ib">
                                    <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5>
                                    <p>Test, which is a new approach to have all solutions
                                        astrology under one roof.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mesgs">
                    <div class="msg_history">
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>Test which is a new approach to have all
                                        solutions</p>
                                    <span class="time_date"> 11:01 AM    |    June 9</span></div>
                            </div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Test which is a new approach to have all
                                    solutions</p>
                                <span class="time_date"> 11:01 AM    |    June 9</span></div>
                        </div>
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>Test, which is a new approach to have</p>
                                    <span class="time_date"> 11:01 AM    |    Yesterday</span></div>
                            </div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Apollo University, Delhi, India Test</p>
                                <span class="time_date"> 11:01 AM    |    Today</span></div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Apollo University, Delhi, India Test</p>
                                <span class="time_date"> 11:01 AM    |    Today</span></div>
                        </div>
                        <div class="outgoing_msg">
                            <div class="sent_msg">
                                <p>Apollo University, Delhi, India Testpollo University, Delhi, India Testpollo University, Delhi, India Testpollo University, Delhi, India Testpollo University, Delhi, India Test</p>
                                <span class="time_date"> 11:01 AM    |    Today</span></div>
                        </div>
                        <div class="incoming_msg">
                            <div class="incoming_msg_img"><img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
                            <div class="received_msg">
                                <div class="received_withd_msg">
                                    <p>We work directly with our designers and suppliers,
                                        and sell direct to you, which means quality, exclusive
                                        products, at a price anyone can afford.</p>
                                    <span class="time_date"> 11:01 AM    |    Today</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="type_msg">
                        <div class="input_msg_write">
                            <input type="text" class="write_msg" placeholder="Type a message"/>
                            <button class="msg_send_btn" type="button"><i class="fa fa-space-shuttle" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%}%>
<jsp:include page="footer.jsp"/>