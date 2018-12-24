<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
<% String type = request.getParameter("type"); %>
<% response.setHeader("Access-Control-Allow-Origin", "https://accounts.google.com");%>
<%@page import="Objects.Const" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String fbURL = "https://www.facebook.com/dialog/oauth?client_id=" + Const.Fb_clientID + "&redirect_uri=" + URLEncoder.encode(Const.Redirect_URL) + "&scope=email";
%>
<style>


    .body1:before {
        overscroll-behavior-y: none;
        content: "";
        display: block;
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: -10;
        background: url('assets/img/aprt.jpg') no-repeat center center;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
    }
</style>
<body <% if(type.equals("index")){%> class="body1" style="background-size:cover;width:100%;background-image: url('assets/img/aprt.jpg'); background-attachment: fixed; background-position:center; background-repeat: no-repeat;" <%}%>>


<nav class="navbar navbar-light navbar-expand-md" data-aos="fade-up" data-aos-duration="550" data-aos-once="true" style="<% if(type.equals("index"))	{out.print("color:#212529;background-color:rgba(0,0,0,0.5); z-index:1000;");}	else{ out.print("color:#212529;background-color:#ffffff;border-bottom:1px gray solid;z-index:1000;");} %>">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=Const.root%>" style="color:rgb(248,182,69);">
            <div style="margin-top:5px;"><img src="assets/img/fohireTransparent.png" style="width:80px;"></div>
        </a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2">
            <span><i class="fa fa-navicon hamb"></i></span>
        </button>
        <div class="collapse navbar-collapse menu" id="navcol-2">
            <form class="form-inline <% if(type.equals("index")){%>d-none<%}else{%>d-inline-block<%}%> mr-auto searchbar" method="post" target="_self" style="box-shadow:2px 2px 5px rgb(58,58,58);width:50%;" action="borrow.jsp">       <%--ToDo:Borrow page for top search bar--%>
                <div class="form-group" style="margin-bottom:0px;padding:5px;"><label for="search-field">
                    <i class="fa fa-search" style="color:rgb(200,159,12);font-size:18px;"></i></label><input class="form-control form-control-sm search-field" type="search" name="item" placeholder="Search" autocomplete="on" id="search-field">
                    <input type="hidden" name="type" value="item"></div>
            </form>
            <ul class="nav navbar-nav ml-auto">
                <li class="nav-item" role="presentation">
                    <a class="nav-link" <% if (session == null || session.getAttribute("user") == null) {%>
                       data-toggle="modal" data-target="#login" href="#"<%} else { %> href="<%=Const.root%>Lend" <% } %>
                       style="color:rgb(248,182,69);">Lend</a>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#" style="color:#f8b645;">Help</a>
                    <div class="dropdown-menu dropdown-menu-right" role="menu" style="background-color:white;">
                        <a class="dropdown-item" href="<%=Const.root%>HowItWorks" style="color:#f8b645;">How it
                            works?</a>
                        <a class="dropdown-item" href="<%=Const.root%>FAQs" style="color:#f8b645;">FAQs</a>
                    </div>
                </li>
                <%--if not logged in--%>
                <% if (session == null || session.getAttribute("user") == null) {%>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:rgb(248,182,69);" data-toggle="modal" data-target="#signup">
                    Sign up
                </a>
                </li>

                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:rgb(248,182,69);" data-toggle="modal" data-target="#login">
                    Login
                </a></li>

                <%} else { %>   <%--if  logged in--%>

                <li class="dropdown">
                    <a class="dropdown-toggle nav-link dropdown-toggle msg" data-toggle="dropdown" aria-expanded="false" href="#" style="color:#f8b645;">Notifications
                        <div style="height:10px;width:10px;position:absolute;border-radius:50%;top:0px;right:0px;">
                            <p style="color:#ee1212;font-size:20px;">*</p>
                        </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right not" role="menu">
                        <a class="notmsgtop" role="presentation">
                            <div class="p-2">
                                <div class="float-left">
                                    <h6 style="font-size:13px;">Requests</h6>
                                </div>
                                <div class="float-right">
                                    <h6 style="font-size:13px;">(0)</h6>
                                </div>
                            </div>
                            <div style="clear:both;">
                                <hr>
                            </div>
                        </a>

                        <h4 align="center">No notifications</h4>
                        <%--<a class="dropdown-item d-inline-block notmsg" role="presentation" href="#" data-toggle="modal"--%>
                           <%--data-target="#requests">--%>
                            <%--<div>--%>
                                <%--<div class="float-left">--%>
                                    <%--<h6>Product name</h6>--%>
                                <%--</div>--%>
                                <%--<div class="float-right">--%>
                                    <%--<h6 style="font-size:13px;">19:20</h6>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                            <%--<div style="clear:both;">--%>
                                <%--<div class="float-left">--%>
                                    <%--<h5 style="font-size: 13px;">A new booking request from manan<br></h5>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</a>--%>
                        <%--<a class="dropdown-item d-inline-block notmsg" role="presentation" href="#">--%>
                            <%--<div>--%>
                                <%--<div class="float-left">--%>
                                    <%--<h6>Product name</h6>--%>
                                <%--</div>--%>
                                <%--<div class="float-right">--%>
                                    <%--<h6 style="font-size:13px;">19:20</h6>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                            <%--<div style="clear:both;">--%>
                                <%--<div class="float-left">--%>
                                    <%--<h5 style="font-size: 13px;">Your request has been accepted by name</h5>--%>
                                    <%--<h5 style="font-size: 10px;color: rgb(96,96,177);">Click here for Payment</h5>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</a>--%>
                        <a class="dropdown-item notmsgtop seeall" role="presentation" href="allNotifications.jsp">See all</a>
                    </div>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#" style="color:#f8b645;">Profile</a>
                    <div class="dropdown-menu dropdown-menu-right" role="menu" style="background-color:#ffffff;">
                        <a role="presentation" class="dropdown-item disabled credit" style="color:rgba(89,89,89,0.75);">
                            <div>
                                <div class="d-inline-block">
                                    <h6 style="font-size:14px;">Credits</h6>
                                </div>
                                <div class="d-inline-block float-right">
                                    <h6 style="font-size:14px;">25</h6>
                                </div>
                                <hr style="margin:2px;" />
                            </div>
                        </a>
                        <a class="dropdown-item" href="<%=Const.root%>profile" style="color:#f8b645;">Edit Profile</a>
                        <a class="dropdown-item" href="<%=Const.root%>conversations"
                           style="color:#f8b645;position: relative;">Messages</a>
                        <a class="dropdown-item" href="<%=Const.root%>favourites" style="color:#f8b645;">Favourites</a>
                        <%--<a class="dropdown-item" href="<%=Const.root%>myorders.jsp" style="color:#f8b645;">My orders</a>--%>
                        <a class="dropdown-item" href="<%=Const.root%>Settings" style="color:#f8b645;">Account
                            Settings</a>
                        <a class="dropdown-item" href="<%=Const.root%>logout" style="color:#f8b645;">Logout</a>
                    </div>
                </li>
                <%} %>  <%--upto this--%>

            </ul>
        </div>
    </div>
</nav>
    <% if (session == null || session.getAttribute("user") == null) {%>
<script>
    $(document).ready(function () {
        $("#log").click(function () {
            $.post("<%=Const.root%>login", {
                login: $("#login_user").val(),
                password: $("#login_pass").val()
            }, function () {
                location.reload(true);
            }).fail(function (xhr, status, error) {
                $("#incorrect").text(error)
            });
        });
        <%--$("#sup").click(function () {
            $.post("signup", {
                username: $("#username").val(),
                firstName: $("#firstname").val(),
                lastName: $("#lastname").val(),
                companyName: $("#companyName").val(),
                mobileNumber: $("#mobileNumber").val(),
                email: $("#email").val(),
                password: $("#password").val(),
                otp: $("#otp").val(),
                type: "d"
            });
        });--%>
        $("#nextbtn").click(function () {
            $.post("<%=Const.root%>signup", {
                mobileNumber: $("#Mobilenumber").val(),
                type: "o"
            });
        });
    });

    function onSignIn(googleUser) {
        $.post("<%=Const.root%>signup", {
            id_token: googleUser.getAuthResponse().id_token
        }, function () {
            if (flag) {
                location.reload(true);
                flag = false;
            }
        }).fail(function () {
            $("#incorrect").text("Something went wrong");
        });
    }
</script>
<div class="modal fade visible" role="dialog" tabindex="-1" id="login"><%--For login--%>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <div class="modal-body">
                <div style="font-weight: bold">
                    <label for="login_user">E-mail or Phone no:</label>
                    <input id="login_user" class="form-control" type="text" required="">
                    <label for="login_pass">Password:</label>
                    <input id="login_pass" class="form-control" type="password" required="">
                    <%--<a class="d-table" href="ForgotPassword.jsp" style="font-size:10px;">Forgot your password?</a>--%>
                    <button id="log" class="btn btn-primary" style="background-color:#f8b645;margin-top:10px;">Login</button>
                    <span id="incorrect"></span>
                </div>
            </div>
            <%--<div class="modal-footer d-block">--%>
                <%--<div class="row">--%>
                    <%--<div class="col">--%>
                        <%--<button class="btn btn-primary" type="button" style="width:100%;background-color:rgb(48,51,137);">--%>
                            <%--<a href="<%=fbURL%>" style="color:rgb(255,255,255);font-size:20px;">--%>
                                <%--<i class="fab fa-facebook-square" style="font-size:30px;"></i>&nbsp;Login with Facebook</a></button>--%>
                        <%--<div id="gSignInWrapper">--%>

                             <%--<div id="customBtn" class="customGPlusSignIn">--%>

                             <%--<h6 class="buttonText text-center"><i class="fab fa-google-plus-square" style="font-size: 30px"></i>&nbsp;Sign up with Google</h6>--%>
                             <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<div class="modal fade visible" role="dialog" tabindex="-1" id="signup"><%--for signup--%>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <div class="modal-body">
                <div>
                    <form method="post" action="<%=Const.root%>signup">
                        <div id="fstpg" style="font-weight: bold;">
                            <label for="username">Username:</label>
                            <input id="username" class="form-control" type="text" required="">
                            <label for="Firstname">Firstname:</label>
                            <input id="Firstname" class="form-control" type="text" required="">
                            <label for="Lastname">Lastname:</label>
                            <input id="Lastname" class="form-control" type="text" required="">

                            <label for="phone_number">Mobile number:</label>
                            <input id="phone_number" class="form-control" type="text" required="" maxlength="10" minlength="10">
                            <div class="text-danger  d-none" id="mob_warn">Please enter valid number!</div>
                            <label for="E-mail">E-mail:</label>
                            <input id="E-mail" class="form-control" type="email">
                            <label for="Password">Password:</label>
                            <input id="Password" class="form-control" type="password" required="">

                            <%--<div class="g-recaptcha" style="margin-top: 5px;"
                                 data-sitekey="<%=Const.reCAPTCHA_sitekey%>"></div>--%>
                            <div class="">
                                <input type="checkbox"  name="" required/>
                                By proceeding you agree to our<a href="terms.html"> terms&nbsp;of service</a>&nbsp;and
                                that you have read our <a href="terms.html">Privacy&nbsp;Policy</a>.
                            </div>
                            <button id="signup_btn" class="btn btn-primary" type="submit"
                                    style="background-color:#f8b645;margin-top:10px;">Sign up
                            <%--</button>--%>
                                <%--<label for="phone_number">Mobile number:</label>--%>
                                <%--<input id="phone_number" class="form-control" type="text" required="" maxlength="10" minlength="10">--%>
                                <%--<span class="text-danger d-none" id="non_phone">Please enter valid Mobile number!</span><br/>--%>
                            <%--<button class="btn btn-primary" type="button" id="nextbtn" style="background-color:#f8b645;margin-top:10px;">Send OTP</button>--%>
                        </div>
                        <%--<div class="d-none" id="secpg">--%>
                            <%--<label for="otp">OTP:</label>--%>
                            <%--<input id="otp" class="form-control" type="number" required="" maxlength="4" minlength="4">--%>
                            <%--<button id="resend" class="btn btn-link btn-sm float-right fohireclr align-middle" type="button" style="clear:both;">Resend OTP</button>--%>
                            <%--<button id="sup" class="btn btn-primary" type="submit" style="background-color:#f8b645;margin-top:10px;">Sign up</button>--%>
                        <%--</div>--%>
                    </form>
                </div>
            </div>
            <%--<div class="modal-footer d-block">--%>
                <%--<div class="row">--%>
                    <%--<div class="col">--%>
                        <%--<button class="btn btn-primary" type="button" style="width:100%;background-color:rgb(48,51,137);">--%>
                            <%--<a href="<%=fbURL%>" style="color:rgb(255,255,255);font-size:20px;">--%>
                                <%--<i class="fab fa-facebook-square" style="font-size:30px;"></i>SignUp with Facebook</a></button>--%>
                        <%--&lt;%&ndash;<div id="gSignInWrapper">--%>

                            <%--<div id="customBtn" class="customGPlusSignIn">--%>
                                <%--<span class="icon"><img src="assets/img/google.png" height="100%" width="100%"></span>--%>
                                <%--<span class="buttonText">Sign up with Google</span>--%>
                            <%--</div>--%>
                        <%--</div>&ndash;%&gt;--%>
                        <%--<div id="name"></div>--%>

                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<div class="modal fade" role="dialog" tabindex="-1" id="noti_requests">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Summary</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Check in date:</td>
                            <td>25/3/18</td>
                        </tr>
                        <tr>
                            <td>Check out date:</td>
                            <td>30/3/19</td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i>1200/-</td>
                        </tr>
                        <tr>
                            <td>1239×2 days<br></td>
                            <td><i class="fa fa-rupee"></i>1200/-</td>
                        </tr>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td><i class="fa fa-rupee"></i><strong>2400/-</strong></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-dismiss="modal">Cancel</button>
                <button class="btn btn-primary qbtn" type="button">Book</button>
            </div>
        </div>
    </div>
</div>
<% }%>