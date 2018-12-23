<%@ page import="Objects.Const" %>
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
                    <div class="verblock d-none" id="settings">
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
                                    <td><a class="btn btn-dark btn-block qbtn" role="button"
                                           href="<%=Const.root%>Deactivate">Deactivate</a></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="editpro" >
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
                                                <td>Upload profile picture</td>
                                                <td><input type="file" accept="image/*" /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <button class="btn btn-primary qbtn btn-block" type="submit">Save</button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="d-none" id="payment_op">
                        <div>
                            <h5>How would you like to recieve payment on your products?</h5>
                        </div>
                        <div class="address p-3">
                            <div class="float-left"></div>
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>Account number: 123456789000000000</h6>
                                <h6>IFSC code: 12345</h6>
                            </div>
                        </div>
                        <div class="address p-3">
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>Unified Payment Interface(UPI) ID: 1234567890</h6>
                            </div>
                        </div>
                        <div class="address p-3">
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>Wallet: Paytm</h6>
                                <h6>Number: 1234567890&nbsp;</h6>
                            </div>
                        </div>
                        <div class="address p-3">
                            <div><select id="selectMe" class="form-control"><option value="bank" selected="">Bank Account</option><option value="upi">Unified Payment Interface (UPI)</option><option value="mw">Mobile wallet</option></select></div>
                            <div id="bank"
                                 class="mt-4 p-2 group">
                                <form>
                                    <h6>Account number</h6><input class="form-control form-control-sm" type="text">
                                    <h6>IFSC code</h6><input class="form-control form-control-sm" type="text"></form><button class="btn btn-primary float-right qbtn" type="button">Submit</button></div>
                            <div id="upi" class="mt-4 p-2 group">
                                <form>
                                    <h6>UPI ID</h6><input class="form-control form-control-sm" type="text"></form><button class="btn btn-primary float-right qbtn" type="button">Submit</button></div>
                            <div id="mw" class="mt-4 p-2 group">
                                <form>
                                    <h6>Wallet</h6><select class="form-control"><option value="paytm">Paytm</option><option value="freecharge">Freecharge</option></select>
                                    <h6>Number</h6><input class="form-control" type="text"><button class="btn btn-primary float-right qbtn" type="button">Submit</button></form>
                            </div>
                        </div>
                    </div>
                    <div class="d-none" id="security">
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
                                                <td><input class="form-control" type="password" /></td>
                                            </tr>
                                            <tr>
                                                <td><label>New password:</label></td>
                                                <td><input class="form-control" type="password" /></td>
                                            </tr>
                                            <tr>
                                                <td><label>Confirm password:</label></td>
                                                <td><input class="form-control" type="password" /></td>
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
                    <div id="addresses" class="d-none">
                        <div class="address p-3">
                            <div class="float-left"><input type="radio" name="a"></div>
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>AAAA</h6>
                                <h6>Address</h6>
                                <h6>Address</h6>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-trash-o fohireclr"></i></div>
                            <div class="float-right" style="margin-left: 10px;">
                                <p class="text-black-50">|</p>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-pencil fohireclr"></i></div>
                        </div>
                        <div class="address p-3">
                            <div class="float-left"><input type="radio" name="a"></div>
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>AAAA</h6>
                                <h6>Address</h6>
                                <h6>Address</h6>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-trash-o fohireclr"></i></div>
                            <div class="float-right" style="margin-left: 10px;">
                                <p class="text-black-50">|</p>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-pencil fohireclr"></i></div>
                        </div>
                        <div class="address p-3">
                            <div class="float-left"><input type="radio" name="a"></div>
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>AAAA</h6>
                                <h6>Address</h6>
                                <h6>Address</h6>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-trash-o fohireclr"></i></div>
                            <div class="float-right" style="margin-left: 10px;">
                                <p class="text-black-50">|</p>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-pencil fohireclr"></i></div>
                        </div>
                        <div class="address p-3">
                            <div class="float-left"><input type="radio" name="a"></div>
                            <div class="float-left" style="margin-left: 10px;">
                                <h6>AAAA</h6>
                                <h6>Address</h6>
                                <h6>Address</h6>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-trash-o fohireclr"></i></div>
                            <div class="float-right" style="margin-left: 10px;">
                                <p class="text-black-50">|</p>
                            </div>
                            <div class="float-right" style="margin-left: 10px;"><i class="fa fa-pencil fohireclr"></i></div>
                        </div>
                        <div><button class="btn btn-primary float-right qbtn" type="button">+ Add a new address</button></div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <ul class="list-unstyled lmenu">
                        <li><a href="#" class="sidenav" style="padding:10px;" id="show_editpro">Edit Profile</a></li>
                        <%--<li class="d-none"><a href="verification.html" class="sidenav" style="padding:10px;">Verification</a></li>--%>
                        <%--<li><a href="adresses.html" class="sidenav" style="padding:10px;">My addresses</a></li>--%>
                        <%--<li><a href="notification.jsp" class="sidenav" style="padding:10px;">Notifications</a></li>--%>
                        <li><a href="#" class="sidenav" style="padding:10px;" id="show_payment_op">Payment options</a></li>
                        <li><a href="#" class="sidenav" style="padding:10px;" id="show_addresses">Addresses</a></li>
                        <li><a href="#" class="sidenav" style="padding:10px;" id="show_security">Security</a></li>
                        <%--<li class="d-none"><a href="reviews.html" class="sidenav" style="padding:10px;">Reviews</a></li>--%>
                        <li><a href="#" class="sidenav" style="padding:10px;" id="show_settings">Settings</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</section>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>
<script>
    $(document).ready(function(){
        $("#show_editpro").click(function(){
            $("#editpro").removeClass("d-none");
            $("#payment_op").addClass("d-none");
            $("#addresses").addClass("d-none");
            $("#security").addClass("d-none");
            $("#settings").addClass("d-none");

        });
        $("#show_payment_op").click(function(){
            $("#editpro").addClass("d-none");
            $("#payment_op").removeClass("d-none");
            $("#addresses").addClass("d-none");
            $("#security").addClass("d-none");
            $("#settings").addClass("d-none");

        });
        $("#show_addresses").click(function(){
            $("#editpro").addClass("d-none");
            $("#payment_op").addClass("d-none");
            $("#addresses").removeClass("d-none");
            $("#security").addClass("d-none");
            $("#settings").addClass("d-none");

        });
        $("#show_security").click(function(){
            $("#editpro").addClass("d-none");
            $("#payment_op").addClass("d-none");
            $("#addresses").addClass("d-none");
            $("#security").removeClass("d-none");
            $("#settings").addClass("d-none");

        });
        $("#show_settings").click(function(){
            $("#editpro").addClass("d-none");
            $("#payment_op").addClass("d-none");
            $("#addresses").addClass("d-none");
            $("#security").addClass("d-none");
            $("#settings").removeClass("d-none");

        });
    });
</script>