<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Objects.product" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="Objects.DB" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Objects.comment" %>
<%! Connection connection;

    public void jspInit() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void jspDestroy() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Lend"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<%--<% product p = (product) request.getAttribute("product");
    if(p==null) {
        request.getRequestDispatcher("500.jsp").forward(request,response);
    }%>--%>
<% product p = new product();
    try {
        String id = request.getParameter("id");
        p.product_id = Integer.parseInt(id);
        //p.fillDetails(connection);        //comment to be removed
        request.setAttribute("des", p.description);
        session.setAttribute("product", p.product_id);
    } catch (Exception e) {
        request.getRequestDispatcher("404.jsp").forward(request, response);
    }
    comment[] comments = p.getComments(connection);
%>
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
                            <td>Check in date:</td>
                            <td>25/3/18</td>
                        </tr>
                        <tr>
                            <td>Check out date:</td>
                            <td>30/3/19</td>
                        </tr>
                        <tr>
                            <td>Deposit amount:</td>
                            <td><i class="fa fa-rupee"></i><%= p.deposit%>/-</td>
                        </tr>
                        <tr>
                            <td><%= p.price%>&#9587;2 days<br></td>
                            <td><i class="fa fa-rupee"></i><%= (p.price) * 2%>/-</td>
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
                <button class="btn btn-primary qbtn" type="button">Book</button>
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
                        <% for (int i = 0; i < 4; i++) {%>
                        <div class="carousel-item <%if(i==0){%>active<%}%>"><img class="w-100 d-block" src="<%--<%=p.img[i]%>--%>" alt="Slide Image"></div>
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
                    <%--to be written with rudra--%>
                </div>
            </div>
        </div>
    </div>
</div>
<section>
    <div style="height:500px;position:relative;"><img class="img-fluid" src="assets/img/s.jpg" style="width:100%;height:100%;border-radius:0;">
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
                <h5><i class="fa fa-star" style="color:#f8b645;"></i>&nbsp;4.5<br></h5>
                <hr>
                <h5>Dates<br></h5>
                <form>
                    <div>
                        <div>
                            <h5 style="color:#adadad;">Start Date:</h5><input class="form-control" type="date" style="color:#adadad;"></div>
                        <div>
                            <h5 style="color:#adadad;">End Date:</h5><input class="form-control" type="date" style="color:#adadad;"></div>
                    </div>
                    <button class="btn btn-primary" type="button" style="background-color:#f8b645;width:100%;margin:5px 0px;" data-toggle="modal" data-target="#book">Book</button>
                    <button class="btn btn-primary" type="button" style="background-color:#f8b645;width:100%;margin:10px 0px;">Contact</button>
                </form>
            </div>
            <div class="col offset-lg-1">
                <div class="profile-header-container">
                    <div class="profile-header-img">
                        <img class="img-circle" src="assets/img/photo.jpg"/>
                        <div class="rank-label-container">
                            <span class="label label-default rank-label"><i class="fas fa-check"></i></span>
                        </div>
                    </div>
                </div>

                <h5 class="text-center" style="color:#adadad;">Owner</h5>
                <h2><%=p.product_name%>
                </h2>
                <h6><%=p.category%>
                </h6>
                <h4 style="color:#adadad;"><%=p.region%>
                </h4>
                <div>
                    <h6><c:out value="${des}" escapeXml="true"/></h6>
                    <hr>
                </div>
                <div>
                    <ul class="list-unstyled">
                        <li><strong>Deposit amount</strong>:<strong> &#8377;&nbsp;</strong><span><%=p.deposit%></span></li>
                        <li><strong>Late charges</strong> (charged per day):<strong> &#8377;&nbsp;</strong><span><%=p.late%></span></li>
                    </ul>
                </div>
                <div>
                    <h6></h6>
                    <hr>
                </div>
                <div>
                    <h4>Cancellation Policy</h4>
                    <p style="color:#adadad;">Strict policy – Free cancellation within 48 hours<%=p.policy%><br></p>
                    <hr>
                </div>
                <div>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29336.062459368477!2d72.61464429085115!3d23.206386086975506!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395c2a3c9618d2c5%3A0xc54de484f986b1fa!2sDhirubhai+Ambani+Institute+of+Information+and+Communication+Technology!5e0!3m2!1sen!2sin!4v1530942375698" width="100%" height="200" frameborder="0" style="border:0" allowfullscreen></iframe>
                </div>
                <hr>
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
                                    <input type="radio" id="star4half" name="rating" value="4 and a half"/><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
                                    <input type="radio" id="star4" name="rating" value="4"/><label class="full" for="star4" title="Pretty good - 4 stars"></label>
                                    <input type="radio" id="star3half" name="rating" value="3 and a half"/><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
                                    <input type="radio" id="star3" name="rating" value="3"/><label class="full" for="star3" title="Meh - 3 stars"></label>
                                    <input type="radio" id="star2half" name="rating" value="2 and a half"/><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
                                    <input type="radio" id="star2" name="rating" value="2"/><label class="full" for="star2" title="Kinda bad - 2 stars"></label>
                                    <input type="radio" id="star1half" name="rating" value="1 and a half"/><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
                                    <input type="radio" id="star1" name="rating" value="1"/><label class="full" for="star1" title="Sucks big time - 1 star"></label>
                                    <input type="radio" id="starhalf" name="rating" value="half"/><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
                                </fieldset>
                            </div>

                            <div
                                    class="col">
                                <button class="btn btn-primary float-right qbtn" type="submit" style="margin-right:0;">Add review</button>
                            </div>
                        </div>
                    </form>
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
                <%--<div class="media" style="overflow:visible;">
                    <div><img src="assets/img/user-photo4.jpg" class="mr-3" style="width: 50px; height:50px;border-radius:50%;"></div>
                    <div class="media-body" style="overflow:visible;">
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p style="margin-bottom:0px;"><a href="#" style="color:rgb(0,0,0);text-decoration:none;font-weight:600;">Brennan Prill</a> This guy has been going 100+ MPH on side streets. <br>
                                    <small class="text-muted">August 6, 2016&nbsp;</small></p>
                            </div>
                        </div>
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p class="d-inline"><i class="fa fa-star" style="color:#f8b645;"></i>4.5</p><a class="float-right" href="#"><i class="fa fa-trash-o" style="font-size:21px;color:black;"></i></a></div>
                        </div>
                    </div>
                </div>--%>
                <% for (comment c : comments) {%>
                <div class="media" style="overflow:visible;">
                    <div><img src="<%=c.user_propic%>" class="mr-3" style="width: 50px; height:50px;border-radius:50%;"></div>
                    <div class="media-body" style="overflow:visible;">
                        <div class="row no-gutters">
                            <div class="col-md-12">
                                <p style="margin-bottom:0px;"><a href="#" style="color:rgb(0,0,0);text-decoration:none;font-weight:600;"><%=c.user_firstname%>
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
                <%}%>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>