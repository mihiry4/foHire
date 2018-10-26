<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Objects.Const" %>
<%@ page import="Objects.comment" %>
<%@ page import="Objects.product" %>
<%@ page import="com.mysql.cj.jdbc.MysqlDataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.LocalDate" %>
<%! Connection connection;
    @Override
    public void jspInit() {
        try {
            MysqlDataSource dataSource = new MysqlDataSource();
            dataSource.setURL(Const.DBclass);
            dataSource.setUser(Const.user);
            dataSource.setPassword(Const.pass);
            connection = dataSource.getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void jspDestroy() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }%>
<% product p = (product) request.getAttribute("product");
    String[] user_details = p.getLender(connection);
    LocalDate[][] Dates = p.getBookedDates(connection);
    /*0-username
    1-firstname
    2-lastname
    3-profilepic*/
    int uid = (Integer) session.getAttribute("user");
    if(p==null) {
        request.getRequestDispatcher("404.jsp").forward(request, response);
    }
    else{
        request.setAttribute("des", p.description);
        session.setAttribute("product", p.product_id);
        comment[] comments = p.getCommentsNU(connection, uid);
        comment c = p.getCommentU(connection, uid);
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="<%=p.product_name%>"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/picker.js"></script>
<script src="assets/js/picker.date.js"></script>
<script src="assets/js/legacy.js"></script>
<script>
    var from_$input = $('#input_from').pickadate({
        disable: [
            <% int i=0;
            for(i = 0; i < Dates.length-1; i++) {%>
            {
                from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                to: [<%=(Dates[i][1].getYear())%>, <%=(Dates[i][1].getMonthValue()-1)%>, <%=(Dates[i][1].getDayOfMonth()-1)%>]
            },
            <%}%>
            {
                from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                to: [<%=Dates[i][1].getYear()%>, <%=Dates[i][1].getMonthValue()-1%>, <%=Dates[i][1].getDayOfMonth()-1%>]
            }
        ]
    });


    var to_$input = $('#input_to').pickadate({
        disable: [
            <% i=0;
            for(i = 0; i < Dates.length-1; i++) {%>
            {
                from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                to: [<%=(Dates[i][1].getYear())%>, <%=(Dates[i][1].getMonthValue()-1)%>, <%=(Dates[i][1].getDayOfMonth()-1)%>]
            },
            <%}%>
            {
                from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                to: [<%=Dates[i][1].getYear()%>, <%=Dates[i][1].getMonthValue()-1%>, <%=Dates[i][1].getDayOfMonth()-1%>]
            }
        ]
    });
</script>
<script>
    $(document).ready(function () {
        $("#Contact").click(function () {
            $.post("ChatWith",{
                rec: <%=user_details[0]%>
            });
        });
    });
    $(document).ready(function () {
        $("#bookbtn").click(function () {
            $.post("request", {
                product_id: <%=p.product_id%>,
                fromDate: $("#input_from").val(),
                tillDate: $("#input_to").val()
            }, function () {

            }).fail(function () {
                $("#fail").text("Booking failed.");
            });
        });
    });
    var price = parseInt(<%=p.price%>);
    var deposit = parseInt(<%=p.deposit%>);
</script>
<div class="modal fade" role="dialog" tabindex="-1" id="book">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Summary</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&#9587;</span></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Start date:</td>
                            <td id="frm"></td>
                        </tr>
                        <tr>
                            <td>End date:</td>
                            <td id="too"></td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i><i id="depo"></i>/-</td>
                        </tr>
                        <tr>
                            <td><%= p.price%>&#9587;<i id="day"></i> days<br></td>
                            <td><i class="fa fa-rupee"></i><i id="prce"></i>/-</td>
                        </tr>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td><i class="fa fa-rupee"></i><strong id="total"></strong>/-</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-dismiss="modal">Cancel</button>
                <button class="btn btn-primary qbtn" type="button" id="bookbtn" disabled>Book</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" role="dialog" tabindex="-1" id="slider">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="carousel slide" data-ride="carousel" id="carousel-1">
                    <div class="carousel-inner" role="listbox">
                        <% for (i = 0; i < 4; i++) {%>
                        <div class="carousel-item <%if(i==0){%>active<%}%>"><img class="w-100 d-block"
                                                                                 src="<%=Const.S3URL+"product/"+p.product_id+"_0"%>"
                                                                                 alt="Slide Image"></div>
                        <%}%>
                        <%--<div class="carousel-item active"><img class="w-100 d-block" src="assets/img/back1.jpg" alt="Slide Image"></div>
                        <div class="carousel-item"><img class="w-100 d-block" src="assets/img/d.jpg" alt="Slide Image"></div>
                        <div class="carousel-item"><img class="w-100 d-block" src="assets/img/th-11.jpg" alt="Slide Image"></div>--%>
                    </div>
                    <div><a class="carousel-control-prev" href="#carousel-1" role="button" data-slide="prev"><span class="carousel-control-prev-icon border-dark"></span><span class="sr-only">Previous</span></a><a class="carousel-control-next" href="#carousel-1" role="button" data-slide="next"><span class="carousel-control-next-icon border-dark"></span><span class="sr-only">Next</span></a></div>
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-1" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-1" data-slide-to="1"></li>
                        <li data-target="#carousel-1" data-slide-to="2"></li>
                    </ol>
                    <%--ToDo:to be written with rudra--%>
                </div>
            </div>
        </div>
    </div>
</div>
<section>
    <div style="height:500px;position:relative;"><img class="img-fluid"
                                                      src="<%=Const.S3URL+"product/"+p.product_id+"_0"%>"
                                                      style="width:100%;height:100%;border-radius:0;">
        <button style="position: absolute; bottom: 0;left: 0;" class="btn btn-primary prodbtn qbtn" type="button" data-toggle="modal" data-target="#slider">More images</button>
    </div>
</section>
<section>
    <div class="container">
        <div class="row" style="padding:25px 0px;">
            <div class="col-lg-3">
                <h2 class="d-inline-block">&#8377;<br></h2>
                <h2 class="d-inline-block"><%=p.price%><br></h2>
                <h6 class="d-inline-block">&nbsp;Per<br></h6>
                <h6 class="d-inline-block">day<br></h6>
                <h5><i class="fa fa-star" style="color:#f8b645;"></i>&nbsp;<%=p.rating%><br></h5>
                <hr>
                <h5>Dates<br></h5>
                <form>
                    <div>
                        <div>
                            <h5 style="color:#adadad;">Start Date:</h5><input class="form-control" type="text"
                                                                              id="input_from"/></div>
                    </div>
                        <div>
                            <h5 style="color:#adadad;">End Date:</h5><input class="form-control" type="text"
                                                                            id="input_to" disabled></div>
                    <button class="btn btn-primary" type="button"
                            style="background-color:#f8b645;width:100%;margin:5px 0px;" data-toggle="modal"
                            data-target="#book" id="showBook">Book
                    </button>
                    <button class="btn btn-primary" type="button" id="Contact" style="background-color:#f8b645;width:100%;margin:10px 0px;">Contact</button>
                </form>
            </div>
            <div class="col offset-lg-1">
                <div class="profile-header-container">
                    <div class="profile-header-img">
                        <img class="img-circle" src="<%=user_details[3]%>"/>
                        <div class="rank-label-container">
                            <span class="label label-default rank-label"><i class="fas fa-check"></i></span>
                        </div>
                    </div>
                </div>

                <h5 class="text-center" style="color:#adadad;"><%=user_details[1]%> <%=user_details[2]%>
                </h5>
                <h2><%=p.product_name%>
                </h2>
                <h6><%=p.category%>
                </h6>
                <h4 style="color:#adadad;"><%=p.region%>
                </h4>
                <div>
                    <h6><c:out value="${des}" escapeXml="true"/></h6> <%--for escaping html tags--%>
                    <hr>
                </div>
                <div>
                    <ul class="list-unstyled">
                        <li><strong>Deposit amount</strong>:<strong> &#8377;&nbsp;</strong><span><%=p.deposit%></span></li>
                        <%--<li><strong>Late charges</strong> (charged per day):<strong> &#8377;&nbsp;</strong><span><%=p.late%></span></li>--%>
                    </ul>
                </div>
                <div>
                    <h6></h6>
                    <hr>
                </div>
                <%--<div>
                    <h4>Cancellation Policy</h4>
                    <p style="color:#adadad;">Strict policy – Free cancellation within 48 hours<%=p.policy%><br></p>
                    <hr>
                </div>--%>
                <div>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29336.062459368477!2d72.61464429085115!3d23.206386086975506!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395c2a3c9618d2c5%3A0xc54de484f986b1fa!2sDhirubhai+Ambani+Institute+of+Information+and+Communication+Technology!5e0!3m2!1sen!2sin!4v1530942375698" width="100%" height="200" frameborder="0" style="border:0" allowfullscreen></iframe>
                    <div id="map" width="100%" style="border:0; height:200px"></div>
                </div>
                <hr>
                <div>
                    <div class="d-inline">
                        <h3 class="d-inline"><%=comments.length%> Reviews</h3>
                    </div>
                    <div class="d-inline float-right">
                        <p style="font-weight:600;font-size:24px;"><i class="fa fa-star" style="color:#f8b645;"></i>4.5</p>
                    </div>
                </div>
                <hr>
                <% if (c != null) {%>
                <div class="media" style="overflow:visible;">
                    <div><img src="<%=Const.S3URL+"user/"+c.user_name%>" class="mr-3"
                              style="width: 50px; height:50px;border-radius:50%;"></div>
                    <div class="media-body" style="overflow:visible;">
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p style="margin-bottom:0px;"><a href="Profile/<%=c.user_name%>"
                                                                 style="color:rgb(0,0,0);text-decoration:none;font-weight:600;"><%=c.user_firstName + " " + c.user_lastName%>
                                </a> <%=c.review%><br>
                                    <small class="text-muted"><%=c.time.toGMTString()%>&nbsp;</small>
                                </p>
                            </div>
                        </div>
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p class="d-inline"><i class="fa fa-star" style="color:#f8b645;"></i><%=c.rating%>
                                </p><a class="float-right" href="#"><i class="fa fa-trash-o" style="font-size:21px;color:black;"></i></a></div>
                        </div>
                    </div>
                </div>
                <%
                } else {%>
                <div>
                    <form method="post" action="comment">
                        <div class="form-row">
                            <div class="col">
                                <h5>Share your experience</h5>
                            </div>
                            <div class="col-lg-12"><textarea id="review" class="form-control" rows="5" placeholder="Write your review here...."></textarea></div>
                        </div>
                        <div class="form-row">

                            <div class="col-lg-5">
                                <fieldset class="rating">
                                    <input type="radio" id="star5" name="rating" value="5"/><label class="full" for="star5" title="Awesome - 5 stars"></label>
                                    <input type="radio" id="star4" name="rating" value="4"/><label class="full" for="star4" title="Pretty good - 4 stars"></label>
                                    <input type="radio" id="star3" name="rating" value="3"/><label class="full" for="star3" title="Meh - 3 stars"></label>
                                    <input type="radio" id="star2" name="rating" value="2"/><label class="full" for="star2" title="Kinda bad - 2 stars"></label>
                                    <input type="radio" id="star1" name="rating" value="1"/><label class="full" for="star1" title="Sucks big time - 1 star"></label>
                                </fieldset>
                            </div>

                            <div class="col">
                                <button class="btn btn-primary float-right qbtn" type="submit" style="margin-right:0;">Add review</button>
                            </div>
                        </div>
                    </form>
                </div>
                <hr>
                <%
                    }
                    for (comment C : comments) {
                %>
                <div class="media" style="overflow:visible;">
                    <div><img src="<%=Const.S3URL+"user/"+C.user_name%>" class="mr-3"
                              style="width: 50px; height:50px;border-radius:50%;"></div>
                    <div class="media-body" style="overflow:visible;">
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p style="margin-bottom:0px;"><a href="Profile/<%=C.user_name%>"
                                                                 style="color:rgb(0,0,0);text-decoration:none;font-weight:600;"><%=C.user_firstName + " " + C.user_lastName%>
                                </a> <%=C.review%><br>
                                    <small class="text-muted"><%=C.time.toGMTString()%>&nbsp;</small>
                                </p>
                            </div>
                        </div>
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p class="d-inline"><i class="fa fa-star" style="color:#f8b645;"></i><%=C.rating%>
                                </p></div>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</section>
<script>
    var geocoder;
    var map;
    var address = "gnfc township, bharuch";

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 8,
            center: {lat: -34.397, lng: 150.644}
        });
        geocoder = new google.maps.Geocoder();
        codeAddress(geocoder, map);
    }

    function codeAddress(geocoder, map) {
        geocoder.geocode({'address': address}, function (results, status) {
            if (status === 'OK') {
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
            } else {
                alert('Geocode was not successful for the following reason: ' + status);
            }
        });
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=<%=Const.Maps_APIKey%>&callback=initMap">
</script>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>
<%}%>