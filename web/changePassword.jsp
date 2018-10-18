<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (request.getSession().getAttribute("user") == null)
        request.getRequestDispatcher("index.jsp").forward(request, response);
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Change the password"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
    <section>
        <div>
            <div class="container">
                <div class="row" style="margin-top:50px;">
                    <div class="col editform" style="border:1px rgba(203,183,183,0.56) solid;border-radius:5px;">
                        <form>
                            <div>
                                <h3 class="text-center">Change your password</h3>
                                <div>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr></tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><label>Old password:</label></td>
                                                    <td><input class="form-control" type="password"></td>
                                                </tr>
                                                <tr>
                                                    <td><label>New password:</label></td>
                                                    <td><input class="form-control" type="password"></td>
                                                </tr>
                                                <tr>
                                                    <td><label>Confirm password:</label></td>
                                                    <td><input class="form-control" type="password"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><button class="btn btn-secondary btn-block qbtn" type="submit">Update password</button></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-3" data-aos="slide-up">
                        <ul class="list-unstyled lmenu">
                            <li><a href="#" class="sidenav" style="padding:10px;color:rgb(0,0,0);">Edit Profile</a></li>
                            <li><a href="#" class="sidenav" style="padding:10px;">Verification</a></li>
                            <li><a href="#" class="sidenav" style="padding:10px;">Notifications</a></li>
                            <li><a href="#" class="sidenav" style="padding:10px;">Security</a></li>
                            <li><a href="#" class="sidenav" style="padding:10px;">Settings</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
<jsp:include page="footer.jsp"/>