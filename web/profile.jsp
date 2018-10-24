<%@ page import="Objects.Const" %>
<%@ page import="Objects.user" %>
<%@ page import="java.sql.*" %>
<%! Connection connection;

    @Override
    public void jspInit() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(Const.DBclass, Const.user, Const.pass);
        } catch (Exception e) {
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
<% user u = (user) request.getAttribute("Profile_user");               /*ToDo: comment to be removed*/
    boolean signedUser = (boolean)request.getAttribute("signedUser");
    int uid = (int) session.getAttribute("user");
    if(u==null) {
        request.getRequestDispatcher("500.jsp").forward(request,response);
    }
    else{
        ResultSet rs = null;
        try {
            PreparedStatement ps = connection.prepareStatement("select p.* from users natural join product as p where user_name = ?");
            ps.setString(1, u.userName);
            rs = ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="<%=u.userName%>"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<section style="margin-top:3%;">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div><img class="img-fluid" src="assets/img/th-02.jpg"></div>
                <div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th style="font-size:26px;"><%=u.userName%></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><%=u.firstName%></td>
                            </tr>
                            <tr>
                                <td><%=u.lastName%></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%if (u.showEmail && u.showMobile){%>
                <div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Contact info</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%if (u.showMobile){%>
                            <tr>
                                <td><%=u.mobile%></td>
                            </tr>
                            <%} if (u.showEmail){%>
                            <tr>
                                <td><%=u.email%></td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div><%}%>
                <div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Social networks</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%if (u.facebook_auth!=null){%>
                            <tr>
                                <td>Facebook<i class="fa fa-check float-right"></i></td>
                            </tr>
                            <%} if (u.google_auth!=null){%>
                            <tr>
                                <td>Google<i class="fa fa-check float-right"></i></td>
                            </tr>
                            <%} if (u.google_auth==null && u.facebook_auth == null){%>
                            <tr>
                                <td>Not verified on social accounts</td>        <%--ToDo: update CSS--%>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col">
                <div>
                    <ul class="nav nav-tabs nav-fill">
                        <li class="nav-item"><a class="nav-link active fohireclr" role="tab" data-toggle="tab" href="#tab-1">Products by <%=u.firstName%></a></li>
                        <li class="nav-item"><a class="nav-link fohireclr" role="tab" data-toggle="tab" href="#tab-2">Reviews by Firstname</a></li>     <%--ToDo: remove reviews--%>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel" id="tab-1">
                            <section class="py-5" style="padding-top:0px;">
                                <div class="container">
                                    <div class="row filtr-container">
                                        <%try {
                                            while (rs.next()){%>
                                        <div class="col-md-6 col-lg-5 offset-lg-1 filtr-item nodec" data-category="2,3">
                                            <div style="position:relative;">
                                                <a href="#" class="nodec">
                                                    <div>
                                                        <div class="card"><img class="img-fluid card-img-top w-100 d-block rounded-0" src=<%=rs.getString("image_1")%>></div>
                                                        <div class="d-inline-block pricetag">
                                                            <p style="margin-bottom:0px;color:#f8b645;"><strong><%=rs.getString("product_name")%>&nbsp;·&nbsp;</strong><i class="icon ion-android-star-half"></i><strong><%=rs.getDouble("rating")%></strong><br></p>
                                                            <p style="margin-bottom:0px;font-size:22px;"><strong><%=rs.getString("city")%></strong></p>     <%--ToDo: region or city--%>
                                                            <p>Rs.<%=rs.getInt("price")%> Per Day</p>
                                                        </div>
                                                        <%if (signedUser){%><div class="d-inline-block float-right pricetag"><a href="#a"><i class="fa fa-trash fohireclr" style="font-size:19px;"></i></a></div><%}%>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                        <%}
                                        }catch (SQLException e){
                                            e.printStackTrace();
                                        }%>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div class="tab-pane" role="tabpanel" id="tab-2">
                            <div class="row">
                                <div class="col-md-6 col-lg-5 filtr-item" data-category="2,3">
                                    <div class="card border-dark"><img class="img-fluid card-img-top w-100 d-block rounded-0" src="assets/img/back1.jpg"></div>
                                    <div class="pricetag">
                                        <p style="margin-bottom:0px;color:#f8b645;"><strong>Product name&nbsp;·&nbsp;</strong><i class="icon ion-android-star-half"></i><strong>4.5</strong><br></p>
                                        <p style="margin-bottom:0px;font-size:22px;"><strong>Ahmedabad</strong></p>
                                        <p>Rs.100000 Per Day</p>
                                    </div>
                                </div>
                                <div class="col align-self-center">
                                    <div class="media" style="overflow:visible;">
                                        <div><img src="assets/img/user-photo4.jpg" class="mr-3" style="width: 50px; height:50px;border-radius:50%;"></div>
                                        <div class="media-body" style="overflow:visible;">
                                            <div class="row no-gutters">
                                                <div class="col-md-12">
                                                    <p style="margin-bottom:0px;"><a href="#">Brennan Prill:</a> This guy has been going 100+ MPH on side streets. <br>
                                                        <small class="text-muted">August 6, 2016&nbsp;</small></p>
                                                </div>
                                            </div>
                                            <div class="row no-gutters">
                                                <div class="col-md-12">
                                                    <p><i class="fa fa-star" style="color:#f8b645;"></i>4.5</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-5 filtr-item" data-category="2,3">
                                    <div class="card border-dark"><img class="img-fluid card-img-top w-100 d-block rounded-0" src="assets/img/back1.jpg"></div>
                                    <div class="pricetag">
                                        <p style="margin-bottom:0px;color:#f8b645;"><strong>Product name&nbsp;·&nbsp;</strong><i class="icon ion-android-star-half"></i><strong>4.5</strong><br></p>
                                        <p style="margin-bottom:0px;font-size:22px;"><strong>Ahmedabad</strong></p>
                                        <p>Rs.100000 Per Day</p>
                                    </div>
                                </div>
                                <div class="col align-self-center">
                                    <div class="media" style="overflow:visible;">
                                        <div><img src="assets/img/user-photo4.jpg" class="mr-3" style="width: 50px; height:50px;border-radius:50%;"></div>
                                        <div class="media-body" style="overflow:visible;">
                                            <div class="row no-gutters">
                                                <div class="col-md-12">
                                                    <p style="margin-bottom:0px;"><a href="#">Brennan Prill:</a> This guy has been going 100+ MPH on side streets. <br>
                                                        <small class="text-muted">August 6, 2016&nbsp;</small></p>
                                                </div>
                                            </div>
                                            <div class="row no-gutters">
                                                <div class="col-md-12">
                                                    <p><i class="fa fa-star" style="color:#f8b645;"></i>4.5</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%}%>