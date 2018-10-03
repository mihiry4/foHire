<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
<% String type = request.getParameter("type"); %>
<% response.setHeader("Access-Control-Allow-Origin", "https://accounts.google.com");%>
<%@page import="java.net.URLEncoder" %>
<%@ page import="Objects.Const" %>
<%
    String fbURL = "http://www.facebook.com/dialog/oauth?client_id=647356462331818&redirect_uri=" + URLEncoder.encode("http://localhost:8080/foHire/signup") + "&scope=email";
%>
<body <% if(type.equals("index")){%>style="background-size:cover;width:100%;background: #465765 url('assets/img/back1.jpg') no-repeat fixed center;" <%}%>>
<nav class="navbar navbar-light navbar-expand-md sticky-top" data-aos="fade-up" data-aos-duration="550" data-aos-once="true" style="<% if(type.equals("index"))	{out.print("color:#212529;background-color:rgba(0,0,0,0.5);");}	else{ out.print("color:#212529;background-color:#ffffff;border-bottom:1px gray solid;");} %>">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="color:rgb(248,182,69);">
            <div style="margin-top:5px;"><img src="assets/img/fohireTransparent1.png" style="width:80px;"></div>
        </a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2">
            <span class="sr-only">Toggle navigation</span>
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse menu" id="navcol-2">
            <form class="form-inline d-inline-block mr-auto searchbar" target="_self" style="box-shadow:2px 2px 5px rgb(58,58,58);width:50%;">
                <div class="form-group" style="margin-bottom:0px;padding:5px;"><label for="search-field">
                    <i class="fa fa-search" style="color:rgb(200,159,12);font-size:18px;"></i></label><input class="form-control form-control-sm search-field" type="search" name="search" placeholder="Search" autocomplete="on" id="search-field"></div>
            </form>
            <ul class="nav navbar-nav ml-auto">
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="#" style="color:rgb(248,182,69);">Borrow</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="#" style="color:rgb(248,182,69);">Lend</a>
                </li>
                <%--if not logged in--%>
                <% if (session == null || session.getAttribute("user") == null) {%>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="padding: 0;">
                    <button class="btn btn-light log" type="button" data-toggle="modal" data-target="#signup" style="background-color:rgba(0,123,255,0);color:rgb(248,182,69);">Sign up</button>
                </a>
                </li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="padding: 0;">
                    <button class="btn btn-light log" type="button" data-toggle="modal" data-target="#login"
                            style="background-color:rgba(0,123,255,0);color:rgb(248,182,69);">
                        Login
                    </button>
                </a></li>
                <%} else { %>   <%--if  logged in--%>
                <li class="dropdown"><a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown"
                                        aria-expanded="false" href="#" style="color:#f8b645;">Profile</a>
                    <div class="dropdown-menu dropdown-menu-right" role="menu"
                         style="background-color:rgba(0,0,0,0.5);"><a class="dropdown-item" role="presentation"
                                                                      href="editprofile.html" style="color:#f8b645;">Edit
                        Profile</a><a class="dropdown-item" role="presentation" href="setting.jsp"
                                      style="color:#f8b645;">Account Setting</a><a class="dropdown-item"
                                                                                   role="presentation" href="#"
                                                                                   style="color:#f8b645;">Logout</a>
                    </div>
                </li>
                <%} %>  <%--upto this--%>
                <li
                        class="dropdown"><a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown"
                                            aria-expanded="false" href="#" style="color:#f8b645;">Help</a>
                    <div class="dropdown-menu dropdown-menu-right" role="menu"
                         style="background-color:rgba(0,0,0,0.5);"><a class="dropdown-item" role="presentation" href="#"
                                                                      style="color:#f8b645;">How it works?</a><a
                            class="dropdown-item" role="presentation" href="#" style="color:#f8b645;">FAQs</a></div>
                </li>
            </ul>
        </div>
    </div>
</nav>
    <% if (session == null || session.getAttribute("user") == null) {%>
<script>
    $(document).ready(function () {
        $("#log").click(function () {
            $.post("login", {
                login: $("#login_user").val(),
                password: $("#login_pass").val()
            }, function () {
                location.reload(true);
            }).fail(function () {
                $("#incorrect").text("Invalid username or password");
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
            $.post("signup", {
                mobileNumber: $("#Mobilenumber").val(),
                type: "o"
            });
        });
    });

    function onSignIn(googleUser) {
        $.post("signup", {
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
            <div class="modal-header" style="background-color:#f8b645;">
                <h4 class="text-monospace modal-title">Login</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&#9587;</span></button>
            </div>
            <div class="modal-body">
                <div>
                    <label for="login_user">E-mail or Phone no:</label><input id="login_user" class="form-control"
                                                                              type="text" required=""><label
                        for="login_pass">Password:</label><input
                        id="login_pass" class="form-control" type="password" required=""><a class="d-table" href="#"
                                                                                            style="font-size:10px;">Forgot
                    your
                    password?</a>
                    <button
                            id="log" class="btn btn-primary"
                            style="background-color:#f8b645;margin-top:10px;">
                        Login
                    </button>
                    <span id="incorrect"></span>
                </div>
            </div>
            <div class="modal-footer d-block">
                <div class="row">
                    <div class="col">
                        <button class="btn btn-primary" type="button" style="width:100%;background-color:rgb(48,51,137);">
                            <a href="<%=fbURL%>" style="color:rgb(255,255,255);font-size:20px;">
                                <i class="fab fa-facebook-square" style="font-size:30px;"></i>&nbsp; Login with Facebook</a></button>
                        <div class="g-signin2" data-onsuccess="onSignIn"></div>
                    </div>

                    <div
                            class="col">
                        <button class="btn btn-primary" type="button"
                                style="width:100%;background-color:rgb(189,29,29);margin-top:10px;"><a href="#"
                                                                                                       style="color:rgb(255,255,255);font-size:20px;"><i
                                class="fab fa-google-plus-square" style="font-size:30px;"></i>&nbsp; Login with Google</a></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade visible" role="dialog" tabindex="-1" id="signup"><%--for signup--%>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#f8b645;">
                <h4 class="modal-title">Sign up</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&#9587;</span></button>
            </div>
            <div class="modal-body">
                <div>
                    <form method="post" action="signup">
                        <div id="fstpg">
                            <label for="username">Username:</label>
                            <input id="username" class="form-control" type="text" required="">
                            <label for="Firstname">Firstname:</label>
                            <input id="Firstname" class="form-control" type="text" required="">
                            <label for="Lastname">Lastname:</label>
                            <input id="Lastname" class="form-control" type="text" required="">
                            <label for="Companyname">Company name:</label>
                            <input id="Companyname" class="form-control" type="text" required="">
                            <label for="Mobilenumber">Mobile number:</label>
                            <input id="Mobilenumber" class="form-control" type="number" required="" maxlength="10" minlength="10">
                            <label for="E-mail">E-mail:</label>
                            <input id="E-mail" class="form-control" type="email">
                            <label for="Password">Password:</label>
                            <input id="Password" class="form-control" type="password" required="">
                            <label for="Confirm password">Confirm password:</label>
                            <input id="Confirm password" class="form-control" type="password" required="">
                            <div class="g-recaptcha" data-sitekey="<%=Const.reCAPTCHA_sitekey%>"></div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" required="" id="formCheck-2">
                                <label class="form-check-label" for="formCheck-2">
                                    By clicking sign up you agree to our<a href="terms.html"> terms&nbsp;of service</a>&nbsp;and that you have read our <a href="terms.html">Privacy&nbsp;Policy</a>.</label>
                            </div>
                            <button class="btn btn-primary" type="button" id="nextbtn" style="background-color:#f8b645;margin-top:10px;">Send OTP</button>
                        </div>
                        <div class="d-none" id="secpg">
                            <label>OTP:</label>
                            <input id="otp" class="form-control" type="number" required="" maxlength="4" minlength="4">
                            <button id="resend" class="btn btn-link btn-sm float-right fohireclr align-middle" type="button" style="clear:both;">Resend OTP</button>
                            <button id="sup" class="btn btn-primary" type="submit" style="background-color:#f8b645;margin-top:10px;">Sign up</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row">
                    <div class="col">
                        <button class="btn btn-primary" type="button"
                                style="width:100%;background-color:rgb(48,51,137);"><a href="#"
                                                                                       style="color:rgb(255,255,255);font-size:20px;"><i
                                class="fab fa-facebook-square" style="font-size:30px;"></i>&nbsp; Login with
                            Facebook</a></button>
                    </div>
                    <div
                            class="col">
                        <button class="btn btn-primary" type="button"
                                style="width:100%;background-color:rgb(189,29,29);margin-top:10px;"><a href="#"
                                                                                                       style="color:rgb(255,255,255);font-size:20px;"><i
                                class="fab fa-google-plus-square" style="font-size:30px;"></i>&nbsp; Login with
                            Google</a></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<% }%>