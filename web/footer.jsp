<%@ page import="Objects.Const" %>
<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
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
                        <% if(session.getAttribute("user")==null){ %>
                        <li><a href="#" data-toggle="modal" data-target="#signup">Sign Up</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#login">Login</a></li>
                        <%}%>
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
                <div class="col-md-3 col-lg-3 social-networks">
                    <%--<a href="#" class="facebook"><i--%>
                        <%--class="fa fa-facebook"></i></a>--%>
                    <%--<a href="#" class="twitter"><i class="fa fa-twitter"></i></a>--%>
                    <%--<a href="#" class="google"><i class="fa fa-google-plus"></i></a>--%>
                    <%--<a href="#" class="linkedin"><i--%>
                        <%--class="fa fa-linkedin"></i></a>--%>
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
                <a href="https://api.whatsapp.com/send?text=www.fohire.com .Fohire helps you find out things you want to rent. Share this link and win upto ₹150 Fohire credits." class="whatsapp">
                    <i class="fa fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
</div>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/fav.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<script src="assets/js/Review-rating-Star-Review-Button.js"></script>
<script src="assets/js/step.js"></script>
<script>startApp();</script>
<script src="assets/js/bs-animation.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.1.1/aos.js"></script>
</body>

</html>