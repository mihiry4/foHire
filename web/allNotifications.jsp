<%@ page import="Objects.Const" %><%--
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
        $(window).on('load',function(){
            if(jsArray.length==0)
            {
                $('#notification_list').append("<li class='nonot'><strong>No notifications</strong></li>");
            }
            else {
                jsArray.forEach(fn1);
            }
        });

    });
    function fn1(item, index) {
        var not_data = {
            id : index,
            from : item.from,
            till : item.till,
            price : item.price,
            deposit : item.deposit,
            amount : item.amount,
            first_name : item.first_name,
            last_name : item.last_name,
            user_name : item.user_name,
            time : item.time,
            product_name : item.product_name,
            pay : item.pay,
            Request_id : item.Request_id,
            Order_id : item.Order_id
        };
        if(not_data.pay==0){
            var template = $('#notifications').html();
            var templateScript = Handlebars.compile(template);
            $('#notification_list').append( templateScript(not_data) );

        }
        else{
            var template = $('#notifications1').html();
            var templateScript = Handlebars.compile(template);
            $('#notification_list').append( templateScript(not_data) );
        }


    }
    function fn(id) {
         var not_data = {
            from : jsArray[id].from,
            till : jsArray[id].till,
            price : jsArray[id].price,
            deposit : jsArray[id].deposit,
            amount : jsArray[id].amount,
            first_name : jsArray[id].first_name,
            last_name : jsArray[id].last_name,
            user_name : jsArray[id].user_name,
            time : jsArray[id].time,
            product_name : jsArray[id].product_name,
            pay : jsArray[id].pay,
            Request_id : jsArray[id].Request_id,
            Order_id : jsArray[id].Order_id
        };
         if(not_data.pay==0){
             var from = (not_data.from).split("-");
             var f=new Date(from[2], from[1], from[0]);

             var till = (not_data.till).split("-");
             var t=new Date(till[2], till[1], till[0]);
             var millisecondsPerDay = 1000 * 60 * 60 * 24;

             var millisBetween =  t.getTime() - f.getTime() ;
             var days = millisBetween / millisecondsPerDay;

             var total_rent=days*(parseInt(not_data.price));
             var total_payment=total_rent+(parseInt(not_data.deposit));



             $('#s_date1').html(not_data.from);
             $('#e_date1').html(not_data.till);
             $('#deposit').html(not_data.deposit);
             $('#rent1').html(not_data.price);
             $('#days1').html(Math.floor(days));
             $('#tot_rent1').html(total_rent);
             $('#total1').html(total_payment);

         }
         else{
             var from = (not_data.from).split("-");
             var f=new Date(from[2], from[1], from[0]);

             var till = (not_data.till).split("-");
             var t=new Date(till[2], till[1], till[0]);
             var millisecondsPerDay = 1000 * 60 * 60 * 24;

             var millisBetween =  t.getTime() - f.getTime() ;
             var days = millisBetween / millisecondsPerDay;

             var total_rent=days*(not_data.price);
             var total_payment=total_rent+(not_data.deposit);



             $('#s_date').html(not_data.from);
             $('#e_date').html(not_data.till);
             $('#deposit').html(not_data.deposit);
             $('#rent').html(not_data.price);
             $('#days').html(Math.floor(days));
             $('#tot_rent').html(total_rent);
             $('#total').html(total_payment);
         }

        var options = {
            "key": "<%=Const.Razorpay_key%>",
            "amount": not_data.amount, // 2000 paise = INR 20
            "name": "Fohire",
            "description": not_data.product_name,
            "handler": function (response){
                $.post("Order",{
                    payment_id : response.razorpay_payment_id,
                    signature : response.razorpay_signature,
                    order_id : response.razorpay_order_id
                }, function () {

                });
            },
            "prefill": {
                "name": "",
                "email": "test@test.com",
                "contact": "1234567890"
            },
            "order_id": not_data.Order_id
        };
        var rzp1 = new Razorpay(options);
    }


    document.getElementById('rzp-button1').onclick = function(e){
        rzp1.open();
        e.preventDefault();
    }
</script>
<section style="margin-top: 15px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                <div style="background: #f8b645;">
                    <ul class="list-unstyled" id="notification_list">
                        <li style="color: white;font-size: 24px;padding: 10px;"><strong>Notifications</strong></li>
                        <li style="background-color: white;">
                        <a onclick="fn(0)" data-toggle="modal" data-target="#requests">
                            <div class="p-2 chatpeople" style="overflow: auto;">
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
                                <div class="p-2 chatpeople" style="overflow: auto;">
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
                        aria-hidden="true">&#10005;</span></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Start date:</td>
                            <td id="s_date"></td>
                        </tr>
                        <tr>
                            <td>End date:</td>
                            <td id="e_date">30/3/19</td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i><i id="deposit">1200/-</i></td>
                        </tr>
                        <tr>
                            <td><i id="rent">1239</i>&#10005;<i id="days">2</i> days</td>
                            <td><i class="fa fa-rupee"></i><i id="tot_rent">1200/-</i></td>
                        </tr>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td><i class="fa fa-rupee"></i><strong id="total">2400/-</strong></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-dismiss="modal">Cancel</button>
                <button id="rzp-button1" class="btn btn-light">Confirm Booking</button>

                <%--<form action="purchase" method="POST">
                    <!-- Note that the amount is in paise = 50 INR -->
                    <script src="https://checkout.razorpay.com/v1/checkout.js"
                            data-key="rzp_test_NWQIuY0uK1cHQJ"
                            data-amount="5000"
                            data-buttontext="Confirm Booking"
                            data-name="Merchant Name"
                            data-description="Purchase Description"
                            data-image="https://your-awesome-site.com/your_logo.jpg"
                            data-prefill.name="Gaurav Kumar"
                            data-prefill.email="test@test.com"
                            data-theme.color="#F37254"
                    ></script>
                    <input type="hidden" value="Hidden Element" name="hidden">
                </form>--%>
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
                        aria-hidden="true">&#10005;</span></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Start date:</td>
                            <td id="s_date1"></td>
                        </tr>
                        <tr>
                            <td>End date:</td>
                            <td id="e_date1">30/3/19</td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i><i id="deposit1">1200/-</i></td>
                        </tr>
                        <tr>
                            <td><i id="rent1">1239</i>&#10005;<i id="days1">2</i> days<br></td>
                            <td><i class="fa fa-rupee"></i><i id="tot_rent1">1200/-</i></td>
                        </tr>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td><i class="fa fa-rupee"></i><strong id="total1">2400/-</strong></td>
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
<script id="notifications" type="text/x-handlebars-template" >
    <li style="background-color: white;">
        <a onclick="fn(0)" data-toggle="modal" data-target="#requests">
        <div class="p-2 chatpeople" style="overflow: auto;">
        <div class="float-left chatimgdiv"><img src="assets/img/th-06.jpg"
    class="rounded-circle"></div>
        <div class="d-inline-block p-2">
        <h5 class="fohireclr">{{name}}</h5>
        <div>
        <p class="fohireclr">{{notification}}.</p>
    </div>
    </div>
    <div class="float-right" style="clear:both;">
        <p class="black" style="font-size:13px;">Time</p>
        </div>
        </div>
        </a>
        </li>
</script>
<script id="notifications1" type="text/x-handlebars-template" >
    <li style="background-color: white;">
        <a onclick="fn(0)" data-toggle="modal" data-target="#book">
            <div class="p-2 chatpeople" style="overflow: auto;">
                <div class="float-left chatimgdiv"><img src="assets/img/th-06.jpg"
                                                        class="rounded-circle"></div>
                <div class="d-inline-block p-2">
                    <h5 class="fohireclr">{{name}}</h5>
                    <div>
                        <p class="fohireclr">{{notification}}.</p>
                    </div>
                </div>
                <div class="float-right" style="clear:both;">
                    <p class="black" style="font-size:13px;">Time</p>
                </div>
            </div>
        </a>
    </li>
</script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>
