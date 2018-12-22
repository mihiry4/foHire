<%@ page import="Objects.Const" %>
<%@ page import="com.mysql.cj.jdbc.MysqlDataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
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
<% String chatkit = request.getParameter("chatkit");
    int userid = 0;
    String user_id = null;

    if (session.getAttribute("user") != null) {
        userid = (Integer) session.getAttribute("user");
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
            preparedStatement.setInt(1, userid);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            user_id = rs.getString(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<section style="background-color:#fefefe;">
    <footer id="myFooter" style="background-color:#ffffff;">
        <div class="container-fluid">
            <hr>
            <div class="row text-center footcolor">
                <div class="col-12 col-sm-6 col-md-2 col-lg-3">
                    <h5>Get started</h5>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="lend.jsp">Lend</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#signup">Sign Up</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#login">Login</a></li>
                    </ul>
                </div>
                <div class="col-12 col-sm-6 col-md-2 col-lg-3">
                    <h5>Fohire</h5>
                    <ul>

                        <li><a href="terms.jsp">Terms of Service</a></li>
                        <li><a href="privacy_policy.jsp">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="col-sm-6 col-md-2 col-lg-3">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="<%=Const.root%>FAQs">FAQs</a></li>
                        <li><a href="contact_us.jsp">Contact us</a></li>
                        <li><a href="<%=Const.root%>HowItWorks">How it works</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col-lg-3 social-networks"><a href="#" class="facebook"><i
                        class="fa fa-facebook"></i></a><a href="#" class="twitter"><i class="fa fa-twitter"></i></a><a
                        href="#" class="google"><i class="fa fa-google-plus"></i></a><a href="#" class="linkedin"><i
                        class="fa fa-linkedin"></i></a>
                    <div>
                        <p style="color: #030303;margin-bottom: 0;margin-top: 16px;">Coming soon on</p><a href="#"
                                                                                                          class="gplay"><i
                            class="fab fa-google-play"></i></a><a href="#" class="linkedin"><i
                            class="fab fa-app-store"></i></a></div>
                </div>
            </div>
            <div class="row footer-copyright" style="background-color:rgb(255,255,255);">
                <div class="col" style="background-color:#ffffff;">
                    <p>Copyright Fohire.com &copy;2018.All Rights Reserved<br></p>
                </div>
            </div>
        </div>
    </footer>
</section>
<div class="share">
    <button class="btn btn-primary" type="button" data-target="#sharemodal" data-toggle="modal">Share Fohire</button>
</div>
<div class="modal fade" role="dialog" tabindex="-1" id="sharemodal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">Share Fohire</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true"><i class="fa fa-close"></i></span></button>
            </div>
            <div class="share-on">
                <a href="http://www.facebook.com/sharer.php?u=[post-url]" class="facebook">
                    <i class="fa fa-facebook"></i></a>
                <a href="https://twitter.com/share?url=[post-url]&amp;text=[post-title]&amp;via=[via]&amp;hashtags=[hashtags]"
                   class="twitter">
                    <i class="fa fa-twitter"></i></a>
                <a href=" https://plus.google.com/share?url=[post-url]" class="google">
                    <i class="fa fa-google-plus"></i></a>
                <a href=" http://www.linkedin.com/shareArticle?url=[post-url]&amp;title=[post-title]" class="linkedin">
                    <i class="fa fa-linkedin"></i></a>
                <a href="https://api.whatsapp.com/send?text=http://alpha.fohire.com" class="whatsapp">
                    <i class="fa fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
</div>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<%if (chatkit.equals("yes") && userid!=0) {%>
<%--<script src="https://unpkg.com/@pusher/chatkit/dist/web/chatkit.js"></script>
<script type="text/javascript">
    const chatManager = new Chatkit.ChatManager({
        instanceLocator: "<%=Const.Pusher_instanceLocator%>",
        userId: "<%=user_id%>",
        tokenProvider: new Chatkit.TokenProvider({url: "Auth_pusher"})
    });
</script>--%>
<script src="assets/js/chatlist.js"></script>
<script src="assets/js/chat.js"></script>
<script src="assets/js/notification.js"></script>
<%}%>
<script src="assets/js/fav.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<%--<script src="https://unpkg.com/@bootstrapstudio/bootstrap-better-nav/dist/bootstrap-better-nav.min.js"></script>--%>
<script src="assets/js/Review-rating-Star-Review-Button.js"></script>
<script src="assets/js/step.js"></script>
<script>startApp();</script>
<script src="assets/js/bs-animation.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.js"></script>
</body>

</html>