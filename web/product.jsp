<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Objects.Const" %>
<%@ page import="Objects.comment" %>
<%@ page import="Objects.product" %>
<%@ page import="java.time.LocalDate" %>
<%--<%! private GeoApiContext geoApi;

    @Override
    public void jspInit() {
        geoApi = (GeoApiContext) getServletConfig().getServletContext().getAttribute("geoApi");
        if (geoApi == null){
            GeoApiContext.Builder builder = new GeoApiContext.Builder();
            geoApi = builder.apiKey(Const.Maps_APIKey).build();
            getServletConfig().getServletContext().setAttribute("geoApi", geoApi);
        }
        connection = Objects.Const.openConnection();
    }
%>--%>

<% product p = (product) request.getAttribute("product");
    String[] user_details = p.user_details;
    LocalDate[][] Dates = p.Dates;
    /*0-username
    1-firstname
    2-lastname
    3-profilepic*/
    if(p==null) {
        request.getRequestDispatcher("/404.jsp").forward(request, response);
    }
    else{
        request.setAttribute("des", p.description);
        session.setAttribute("product", p.product_id);
        comment[] comments = p.NU;
        comment c = p.U;
        int i = 0;
        /*try {
            DistanceMatrix matrix = DistanceMatrixApi.newRequest(geoApi).origins(new LatLng(4,6)).destinations(new LatLng(5,6)).await();
            DistanceMatrixRow row = matrix.rows[0];
            DistanceMatrixElement element = row.elements[0];
            if (element.status == DistanceMatrixElementStatus.OK){
                if (element.distance.inMeters <= 5000) {
                    inRange = true;
                }
            }
        } catch (ApiException e) {
            e.printStackTrace();
        }catch (InterruptedException e){
            e.printStackTrace();
        }*/

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


</script>


<script>
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
    var price = parseInt("<%=p.price%>");
    var deposit = parseInt("<%=p.deposit%>");
</script>
<div class="modal fade" role="dialog" tabindex="-1" id="book">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Summary</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
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
                            <td><%= p.price%>&times;<i id="day"></i> days<br></td>
                            <td><i class="fa fa-rupee"></i><i id="prce"></i>/-</td>
                        </tr>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td><i class="fa fa-rupee"></i><strong id="total"></strong>/-</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <h4>Arriving Shortly!!</h4>
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
                        <% for (i = 0; i < p.img; i++) {%>
                        <div class="carousel-item <%if(i==0){%>active<%}%>"><img class="w-100 d-block"
                                                                                 src="<%=Const.S3URL+"product/"+p.product_id+"_"+i%>"
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
                <h2 class="d-inline-block" id="price"><%=p.price%><br></h2>
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
                    <%--<button class="btn btn-primary" type="button" id="Contact" style="background-color:#f8b645;width:100%;margin:10px 0px;">Contact</button>--%>
                </form>
                <%if (session.getAttribute("user") != null) {%>
                <form method="post" action="<%=Const.root%>Chat">
                    <input type="hidden" name="rec" value="<%=user_details[0]%>"/>
                    <input type="submit" class="btn btn-primary"
                           style="background-color:#f8b645;width:100%;margin:10px 0;" value="Contact"/>
                </form>
                <%} else {%>
                <button class="btn btn-primary" type="button"
                        style="background-color:#f8b645;width:100%;margin:5px 0px;" data-toggle="modal"
                        data-target="#login">Contact
                </button>
                <%}%>
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
                <h2 class="pt-2"><%=p.product_name%>
                </h2>
                <h6 class="pt-2"><%=p.category%>
                </h6>
                <h4 class="pt-2" style="color:#adadad;"><%=p.region%>
                </h4>
                <div class="pt-2">
                    <h6><c:out value="${des}" escapeXml="true"/></h6> <%--for escaping html tags--%>
                    <hr>
                </div>
                <div class="pt-2">
                    <ul class="list-unstyled">
                        <li><strong>Deposit amount</strong>:<strong> &#8377;&nbsp;</strong><span><%=p.deposit%></span></li>
                        <%--<li><strong>Late charges</strong> (charged per day):<strong> &#8377;&nbsp;</strong><span><%=p.late%></span></li>--%>
                    </ul>
                </div>
                <div class="pt-2">
                    <h6></h6>
                    <hr>
                </div>
                <%--<div>
                    <h4>Cancellation Policy</h4>
                    <p style="color:#adadad;">Strict policy – Free cancellation within 48 hours<%=p.policy%><br></p>
                    <hr>
                </div>--%>
                <div class="pt-2">
                    <div id="map" width="100%" style="border:0; height:200px"></div>
                </div>
                <hr>
                <div class="pt-2">
                    <div class="d-inline">
                        <% if (c != null) {%>
                        <h3 class="d-inline"><%=comments.length + 1%> Reviews</h3>
                        <%} else {%>
                        <h3 class="d-inline"><%=comments.length%> Reviews</h3>
                        <%}%>
                    </div>
                    <div class="d-inline float-right">
                        <p style="font-weight:600;font-size:24px;"><i class="fa fa-star"
                                                                      style="color:#f8b645;"></i><%=p.rating%>
                        </p>
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
                    <form method="post" action="<%=Const.root%>comment">
                        <div class="form-row">
                            <div class="col">
                                <h5>Share your experience</h5>
                            </div>
                            <div class="col-lg-12"><textarea id="review" class="form-control" rows="5" placeholder="Write your review here...."></textarea></div>
                        </div>
                        <div class="form-row">

                            <div class="col-lg-5">
                                <fieldset class="rating">
                                    <input type="radio" id="star5" name="rating" value="5"/>
                                    <label class="star" for="star5" title="Awesome" aria-hidden="true"></label>
                                    <input type="radio" id="star4" name="rating" value="4"/>
                                    <label class="star" for="star4" title="Great" aria-hidden="true"></label>
                                    <input type="radio" id="star3" name="rating" value="3"/>
                                    <label class="star" for="star3" title="Very good" aria-hidden="true"></label>
                                    <input type="radio" id="star2" name="rating" value="2"/>
                                    <label class="star" for="star2" title="Good" aria-hidden="true"></label>
                                    <input type="radio" id="star1" name="rating" value="1"/>
                                    <label class="star" for="star1" title="Bad" aria-hidden="true"></label>
                                </fieldset>
                            </div>

                            <div class="col clearfix">
                                <%if (session.getAttribute("user") != null) {%>
                                <button class="btn btn-primary float-right qbtn" id="submitCmt" type="button"
                                        style="margin-right:0;">Add review
                                </button>
                                <div id="cmtStat"></div>
                                <%} else {%>
                                <button class="btn btn-primary float-right qbtn" type="button" data-toggle="modal"
                                        data-target="#login">Add review
                                </button>
                                <%}%>
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
                            <div class="col-md-12 col-xs-12">
                                <p style="margin-bottom:0px;"><a href="Profile/<%=C.user_name%>"
                                                                 style="color:rgb(0,0,0);text-decoration:none;font-weight:600;"><%=C.user_firstName + " " + C.user_lastName%>
                                </a> <%=C.review%><br>
                                    <small class="text-muted"><%=C.time.toGMTString()%>&nbsp;</small>
                                </p>
                            </div>
                        </div>
                        <div class="row no-gutters">
                            <div class="col-md-12 col-xs-12">
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
    var address = "<%=p.region%>";

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 14,
            center: {lat: -34.397, lng: 150.644}
        });
        geocoder = new google.maps.Geocoder();
        codeAddress(geocoder, map);
    }

    function codeAddress(geocoder, map) {
        geocoder.geocode({'address': address}, function (results, status) {
            if (status === 'OK') {
                map.setCenter(results[0].geometry.location);
                var cityCircle = new google.maps.Circle({
                    strokeColor: '#f8b645',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#ffbd45',
                    fillOpacity: 0.35,
                    map: map,
                    center: results[0].geometry.location,
                    radius: 750
                });
            } else {
                alert('Geocode was not successful for the following reason: ' + status);
            }
        });
    }
</script>
<script>
    var from_$input = $('#input_from').pickadate({
            disable: [
                <%for(i = 0; i < Dates.length-1; i++) {%>
                {
                    from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                    to: [<%=(Dates[i][1].getYear())%>, <%=(Dates[i][1].getMonthValue()-1)%>, <%=(Dates[i][1].getDayOfMonth()-1)%>]
                },
                    <%}
                    if (i>0){%>{
                    from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                    to: [<%=Dates[i][1].getYear()%>, <%=Dates[i][1].getMonthValue()-1%>, <%=Dates[i][1].getDayOfMonth()-1%>]
                }<%}%>
            ]
        }),
        from_picker = from_$input.pickadate('picker');

    var to_$input = $('#input_to').pickadate({
            disable: [
                <% i=0;
                for(i = 0; i < Dates.length-1; i++) {%>
                {
                    from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                    to: [<%=(Dates[i][1].getYear())%>, <%=(Dates[i][1].getMonthValue()-1)%>, <%=(Dates[i][1].getDayOfMonth()-1)%>]
                },
                    <%}
                if (i>0){%>{
                    from: [<%=Dates[i][0].getYear()%>, <%=Dates[i][0].getMonthValue()-1%>, <%=Dates[i][0].getDayOfMonth()-1%>],
                    to: [<%=Dates[i][1].getYear()%>, <%=Dates[i][1].getMonthValue()-1%>, <%=Dates[i][1].getDayOfMonth()-1%>]
                }<%}%>
            ]
        }),
        to_picker = to_$input.pickadate('picker');
    <%if (session.getAttribute("user") != null){%>
    $("#submitCmt").click(function () {
        let r = 0;
        $("input[name='rating']").each(function () {
            if (this.checked) {
                r = this.value;
            }
        });
        $.post("<%=Const.root%>comment", {
            rating: r,
            review: $("#review").val()
        }, function () {
            location.reload(true);
        }).fail(function (xhr, error, response) {
            $("#cmtStat").text(response);
        })
    });
    <%}%>
</script>
<script src="assets/js/datepick.js"></script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=<%=Const.Maps_APIKey%>&callback=initMap">
</script>
<jsp:include page="footer.jsp"/>
<%}%>