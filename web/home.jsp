<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 23/12/18
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Objects.Const" %>
<%@ page import="Objects.product" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="foHire"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="index"/>
</jsp:include>
<% product[] products = (product[]) request.getAttribute("products");%>
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
        <h5 class="text-center" style="color:#f8b645;">Lend&nbsp;<a
                class="text-light" <% if (session == null || session.getAttribute("user") == null) {%>
                data-toggle="modal" data-target="#login" href="#"<%} else { %> href="lend.jsp" <% } %> >here.</a></h5>
    </div>
</section>
<section style="background-color:#ffffff;padding-top:60px;padding-bottom:60px;">
    <div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <div>
                        <h3>Explore Fohire</h3>
                    </div>
                </div>
            </div>
            <div class="row places mt-4">
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
                                <div class="col-md-6 col-lg-3 filtr-item nodec"
                                     data-category="2,3">        <%--start from this--%>
                                    <div class="cardparent">
                                        <a href="<%=Const.root%>product/<%=p.product_id%>" class="nodec">
                                            <div>
                                                <div class="card"><img alt="<%=p.product_id%>"
                                                                       class="img-fluid card-img-top w-100 d-block rounded-0"
                                                                       src="<%=Const.S3URL+"product/"+p.product_id+"_0"%>">
                                                </div>
                                                <div class="pricetag">
                                                    <p style="margin-bottom:0;color:#f8b645;">
                                                        <strong><%=p.product_name%>&nbsp;&middot;&nbsp;</strong><i
                                                            class="icon ion-android-star-half"></i><strong><%=p.rating%>
                                                    </strong><br>
                                                    </p>
                                                    <p style="margin-bottom:0;font-size:22px;color:rgb(224,163,58);">
                                                        <strong><%=p.city%>
                                                        </strong></p>
                                                    <p style="color:rgb(163,120,45);font-weight: 600;">
                                                        &#8377; <%=p.price%> Per Day</p>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="d-flex card-foot">
                                            <div class="click active"  <% if (session != null && session.getAttribute("user") != null) { %>
                                                 onclick="heartcng(this, <%=p.product_id%>)" <%} else {%>
                                                 data-target="#login" data-toggle="modal" <%}%>  >
                                                <span class="fa fa-heart<%if (!p.favourite){%>-o<%}%>"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>      <%--Upto this--%>
                                <%if (products.length == 0) {%>No products
                                available<%}%>
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