<%
    if (request.getSession().getAttribute("user") == null)
        request.getRequestDispatcher("index.jsp").forward(request, response);
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Edit your profile"/>
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
                            <h3 class="text-center">Edit Profile</h3>
                            <div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr></tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td><label>First name:</label></td>
                                            <td><input class="form-control" type="text"></td>
                                        </tr>
                                        <tr>
                                            <td><label>Last name:</label></td>
                                            <td><input class="form-control" type="text"></td>
                                        </tr>
                                        <tr>
                                            <td><label>Gender</label></td>
                                            <td><select class="form-control" required="">
                                                <option value="" selected="">Select</option>
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                                <option value="other">Other</option>
                                            </select></td>
                                        </tr>
                                        <tr>
                                            <td>E-mail</td>
                                            <td><input class="form-control" type="text">
                                                <button class="btn btn-primary qbtn" type="button">Send verification link</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <button class="btn btn-outline-secondary btn-block" type="submit">Save</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-lg-3">
                    <ul class="list-unstyled lmenu">
                        <li><a href="editprofile.jsp" class="sidenav" style="padding:10px;color:rgb(0,0,0);">Edit Profile</a></li>
                        <li class="d-none"><a href="verification.html" class="sidenav" style="padding:10px;">Verification</a></li>
                        <%--<li><a href="adresses.html" class="sidenav" style="padding:10px;">My addresses</a></li>--%>
                        <li><a href="notification.jsp" class="sidenav" style="padding:10px;">Notifications</a></li>
                        <li><a href="payment_op.html" class="sidenav" style="padding:10px;">Payment options</a></li>
                        <li><a href="security.html" class="sidenav" style="padding:10px;">Security</a></li>
                        <%--<li class="d-none"><a href="reviews.html" class="sidenav" style="padding:10px;">Reviews</a></li>--%>
                        <li><a href="setting.jsp" class="sidenav" style="padding:10px;">Settings</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>