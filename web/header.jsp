<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
<% String type = request.getParameter("type"); %>

<body <% if(type.equals("index")){out.print("style=\"background-image:url(&quot;assets/img/back1.jpg&quot;);background-repeat:no-repeat;background-size:cover;background-position:center;background-attachment:fixed;width:100%;background-color:#465765;\"");} %>>
<nav class="navbar navbar-light navbar-expand-md sticky-top" data-aos="fade-up" data-aos-duration="550"
     data-aos-once="true"
     style="<% if(type.equals("index"))	{out.print("color:#212529;background-color:rgba(0,0,0,0.5);");}	else{ out.print("color:#212529;background-color:#ffffff;border-bottom:1px gray solid;");} %>">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="color:rgb(248,182,69);">
            <div style="margin-top:5px;"><img src="assets/img/fohireTransparent1.png" style="width:80px;"></div>
        </a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-2"><span class="sr-only">Toggle navigation</span><span
                class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse menu" id="navcol-2">
            <form class="form-inline d-inline-block mr-auto searchbar" target="_self"
                  style="box-shadow:2px 2px 5px rgb(58,58,58);width:50%;">
                <div class="form-group" style="margin-bottom:0px;padding:5px;"><label for="search-field"><i
                        class="fa fa-search" style="color:rgb(200,159,12);font-size:18px;"></i></label><input
                        class="form-control form-control-sm search-field" type="search" name="search"
                        placeholder="Search" autocomplete="on"
                        id="search-field"></div>
            </form>
            <ul class="nav navbar-nav ml-auto">
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:rgb(248,182,69);">Borrow</a>
                </li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:rgb(248,182,69);">Lend</a>
                    <%--if not logged in--%>
                        <% if(session==null || session.getAttribute("user")==null) out.print("</li>\n" +
"                <li class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"#\">\n" +
"                    <button class=\"btn btn-light log\" type=\"button\" data-toggle=\"modal\" data-target=\"#signup\"\n" +
"                            style=\"background-color:rgba(0,123,255,0);padding-top:0;padding-right:0;padding-bottom:0;padding-left:0;color:rgb(248,182,69);\">\n" +
"                        Sign up\n" +
"                    </button>\n" +
"                </a></li>\n" +
"                <li\n" +
"                        class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"#\">\n" +
"                    <button class=\"btn btn-light log\" type=\"button\" data-toggle=\"modal\" data-target=\"#login\"\n" +
"                            style=\"background-color:rgba(0,123,255,0);padding-top:0;padding-right:0;padding-bottom:0;padding-left:0;color:rgb(248,182,69);\">\n" +
"                        Login\n" +
"                    </button>\n" +
"                </a></li>");%>
                    <%--upto this--%>
                <li
                        class="dropdown"><a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown"
                                            aria-expanded="false" href="#" style="color:#f8b645;">Help</a>
                    <div class="dropdown-menu dropdown-menu-right" role="menu"
                         style="background-color:rgba(0,0,0,0.5);"><a class="dropdown-item" role="presentation" href="#"
                                                                      style="color:#f8b645;">How it works?</a><a
                            class="dropdown-item" role="presentation" href="#" style="color:#f8b645;">FAQs</a></div>
                </li>
                <%--if logged in--%>
                <% if (session != null && session.getAttribute("user") != null)
                    out.print("<li class=\"dropdown\"><a class=\"dropdown-toggle nav-link dropdown-toggle\" data-toggle=\"dropdown\"\n" +
                            "                                        aria-expanded=\"false\" href=\"#\" style=\"color:#f8b645;\">Profile</a>\n" +
                            "                    <div class=\"dropdown-menu dropdown-menu-right\" role=\"menu\"\n" +
                            "                         style=\"background-color:rgba(0,0,0,0.5);\"><a class=\"dropdown-item\" role=\"presentation\" href=\"#\"\n" +
                            "                                                                      style=\"color:#f8b645;\">Edit Profile</a><a\n" +
                            "                            class=\"dropdown-item\" role=\"presentation\" href=\"#\" style=\"color:#f8b645;\">Account\n" +
                            "                        Setting</a><a class=\"dropdown-item\" role=\"presentation\"\n" +
                            "                                      href=\"#\" style=\"color:#f8b645;\">Logout</a></div>\n" +
                            "                </li>"); %>
                <%--upto this--%>
            </ul>
        </div>
    </div>
</nav>
