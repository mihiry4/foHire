<%@ page import="Objects.Const" %>
<%@ page import="Objects.product" %>
<%@ page import="com.mysql.cj.jdbc.MysqlDataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 09:40 PM
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="foHire"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="index"/>
</jsp:include>
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
    }
%>
<% product products[] = new product[0];
    try {
        int user_id = 0;
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            user_id = (Integer) request.getSession().getAttribute("user");
        }
        PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (favorites.user_id = ? or favorites.user_id is null) order by upload_time desc limit 6", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        preparedStatement.setInt(1, user_id);
        ResultSet rs = preparedStatement.executeQuery();
        rs.last();
        int row = rs.getRow();
        products = new product[row];
        rs.beforeFirst();
        for (int i = 0; i < products.length; i++) {
            rs.next();
            products[i] = new product();
            products[i].product_id = rs.getInt(1);
            products[i].favourite = rs.getInt(2) != 0;
            products[i].fillDetails(connection);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<section data-aos="fade-up" data-aos-duration="650" class="head" style="background-color:rgba(0,0,0,0.5);">
    <div class="tline" style="margin-top:0;padding-top:10%;">
        <h1 class="text-capitalize text-center" style="color:rgb(248,182,69);">Update to renting.</h1>
        <h5 class="text-center" style="color:rgb(248,182,69);">Fohire helps you find things you want to rent.<br></h5>
    </div>
    <div>
        <div class="container">
            <form method="post" action="borrow.jsp">
                <div class="form-row formres" style="padding:50px 0;">
                    <div class="col-lg-8 offset-lg-2">
                        <div class="form-group d-flex">
                            <input class="form-control searchqirayaa" type="text" name="item" placeholder="Search ">
                            <input type="hidden" name="type" value="item">
                            <button class="btn btn-primary d-inline searchbtn" type="submit">
                                <i class="fa fa-search" style="color:#f8b645;"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div>
        <h2 class="text-center" style="color:#f8b645;">Be a lender yourself.</h2>
        <h5 class="text-center" style="color:#f8b645;">Lend&nbsp;<a class="text-light" <% if (session == null || session.getAttribute("user") == null) {%>  data-toggle="modal" data-target="#login" href="#"<%} else { %> href="lend.jsp" <% } %> >here.</a></h5>
    </div>
</section>
<section style="background-color:#fffdfd;padding-top:60px;padding-bottom:60px;">
    <div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <div>
                        <h3>Explore fohire</h3>
                    </div>
                </div>
            </div>
            <div class="row places">
                <div class="col-lg-4">
                    <a href="borrow.jsp?category=1&type=category" class="catblocka">
                        <div class="catblock">
                            <div class="d-inline-block" style="margin:30px 20px;">
                                <h6 style="color:rgb(65,65,65);">Books</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4">
                    <a href="borrow.jsp?category=2&type=category" class="catblocka">
                        <div class="catblock">
                            <div class="d-inline-block" style="margin:30px 20px;">
                                <h6 style="color:rgb(65,65,65);">Blu-ray and console games</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4">
                    <a href="borrow.jsp?category=3&type=category" class="catblocka">
                        <div class="catblock">
                            <div class="d-inline-block" style="margin:30px 20px;">
                                <h6 style="color:rgb(65,65,65);">Sports Equipment</h6>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<section style="background-color:#ffffff;">

    <div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <div>
                        <h4 class="">New Arrivals<br></h4>
                    </div>
                    <section class="py-5">
                        <div class="container">
                            <div class="row filtr-container">
                                <%for (product p : products) {%>
                                <div class="col-md-6 col-lg-3 filtr-item nodec" data-category="2,3">        <%--start from this--%>
                                    <div class="cardparent">
                                        <a href="product.jsp?product=<%=p.product_id%>" class="nodec">
                                            <div>
                                                <div class="card"><img
                                                        class="img-fluid card-img-top w-100 d-block rounded-0"
                                                        src="<%=Const.S3URL+"product/"+p.product_id+"_0"%>"></div>
                                                <div class="pricetag">
                                                    <p style="margin-bottom:0;color:#f8b645;">
                                                        <strong><%=p.product_name%>&nbsp;&middot;&nbsp;</strong><i
                                                            class="icon ion-android-star-half"></i><strong><%=p.rating%>
                                                    </strong><br>
                                                    </p>
                                                    <p style="margin-bottom:0;font-size:22px;">
                                                        <strong><%=p.city%>
                                                        </strong></p>
                                                    <p>&#8377; <%=p.price%> Per Day</p>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="d-flex card-foot">
                                            <div class="click" onclick="heartcng(this)">
                                                <span class="fa fa-heart<%if (!p.favourite){%>-o<%}%>"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>      <%--Upto this--%>
                                <%if (products.length == 0) {%>No products
                                available<%}%>    <%--ToDo: Edited with rudra--%>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>