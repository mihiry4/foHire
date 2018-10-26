<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 24/10/18
  Time: 11:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Notifications"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<script>
    var jsArray;
    $.post("getRequest", function (data) {
        jsArray = JSON.parse(data);
    });

    function fn(id) {
        console.log(jsArray[id]);
        var start = jsArray[id].from;
        var end = jsArray[id].till;
        var amount = jsArray[id].amount;
        var price = jsArray[id].price;
        var deposit = jsArray[id].deposit;

        $('#s_date').html(start);
        console.log(start);

    }
</script>
<section style="margin-top: 15px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                <div style="background: #f8b645;">
                    <ul class="list-unstyled">
                        <li style="color: white;font-size: 24px;padding: 10px;"><strong>Notifications</strong></li>
                        <li style="background-color: white;">
                            <a onclick="fn(0)" data-toggle="modal" data-target="#requests">
                                <div class="p-2 chatpeople">
                                    <div class="float-left chatimgdiv"><img src="assets/img/th-06.jpg"
                                                                            class="rounded-circle"></div>
                                    <div class="d-inline-block p-2">
                                        <h5 class="fohireclr">Manan</h5>
                                        <div>
                                            <p class="fohireclr">A new booking request.</p>
                                        </div>
                                    </div>
                                    <div class="float-right" style="clear:both;">
                                        <p class="black" style="font-size:13px;">Time</p>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li style="background-color: white;">
                            <a href="#" data-toggle="modal" data-target="#book">
                                <div class="p-2 chatpeople">
                                    <div class="float-left chatimgdiv"><img src="assets/img/th-06.jpg"
                                                                            class="rounded-circle"></div>
                                    <div class="d-inline-block p-2">
                                        <h5 class="fohireclr">Manan</h5>
                                        <div>
                                            <p class="fohireclr">Your request has been accepted.</p>
                                        </div>
                                    </div>
                                    <div class="float-right" style="clear:both;">
                                        <p class="black" style="font-size:13px;">Time</p>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="nonot"><strong>No notifications</strong></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" role="dialog" tabindex="-1" id="book">
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
                            <td>Start date:</td>
                            <td>25/3/18</td>
                        </tr>
                        <tr>
                            <td>End date:</td>
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
                <button class="btn btn-primary qbtn" type="button">Confirm booking</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" role="dialog" tabindex="-1" id="requests">
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
                            <td id="s_date"></td>
                        </tr>
                        <tr>
                            <td>Check out date:</td>
                            <td id="e_date">30/3/19</td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i><i id="deposit">1200/-</i></td>
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
                <button class="btn btn-primary qbtn" type="button">Accept booking</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>
