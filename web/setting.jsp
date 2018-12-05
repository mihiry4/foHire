<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Deactivate"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
    <section>
        <div>
            <div class="container">
                <div class="row" style="margin-top:50px;">
                    <div class="col editform">
                        <div class="verblock">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th colspan="2">Account settings</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Deactivate your account<br></td>
                                            <td><a class="btn btn-dark btn-block qbtn" role="button" href="Deactivate">Deactivate</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <ul class="list-unstyled lmenu">
                            <li><a href="editprofile.jsp" class="sidenav" style="padding:10px;">Edit Profile</a></li>
                            <li class="d-none"><a href="verification.html" class="sidenav" style="padding:10px;">Verification</a></li>
                            <%--<li><a href="adresses.html" class="sidenav" style="padding:10px;">My addresses</a></li>--%>
                            <li><a href="notification.jsp" class="sidenav" style="padding:10px;">Notifications</a></li>
                            <li><a href="payment_op.html" class="sidenav" style="padding:10px;">Payment options</a></li>
                            <li><a href="security.html" class="sidenav" style="padding:10px;">Security</a></li>
                            <%--<li class="d-none"><a href="reviews.html" class="sidenav" style="padding:10px;">Reviews</a></li>--%>
                            <li><a href="setting.jsp" class="sidenav" style="padding:10px;color:rgb(0,0,0);">Settings</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
<jsp:include page="footer.jsp"/>