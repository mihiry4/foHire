<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Preferences"/>
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
                        <form>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th colspan="2">Notification</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Receive notifications from borrowers and lenders.<br></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-1"><label class="form-check-label" for="formCheck-1"><strong>E-mail</strong></label></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-2"><label class="form-check-label" for="formCheck-2"><strong>Text messages</strong><br></label></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-3"><label class="form-check-label" for="formCheck-3"><strong>Push notification</strong><br></label></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><button class="btn btn-outline-secondary btn-block" type="submit">Save</button></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
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