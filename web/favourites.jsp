<%@ page import="Objects.Const" %>
<%@ page import="Objects.product" %>

<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 24/10/18
  Time: 9:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<% int i = 0;
    product[] favs = (product[]) request.getAttribute("favs");%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="favourites"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="non-index"/>
</jsp:include>
<section style="margin-top:5%;">
<div class="container">
<div class="row">
    <div class="col-lg-12 offset-lg-0">
        <h3 class="facebook" style="color:#595959;">Your wishlist</h3>
    </div>
</div>
<div class="row filtr-container">
    <%
        for (product p : favs) {
            if (p.status) {
                i++;
    %>
    <div class="col-md-6 col-lg-3 filtr-item nodec" data-category="2,3">        <%--start from this--%>
        <div class="cardparent">
            <a href="Product/<%=p.product_id%>" class="nodec">
                <div>
                    <div class="card"><img alt="<%=p.product_id%>"
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
                <div class="click active" onclick="heartcng(this, <%=p.product_id%>)">
                    <span class="fa fa-heart<%if (!p.favourite){%>-o<%}%>"></span>
                </div>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>      <%--Upto this--%>
    <%if (i == 0) {%>
    <div class="row" style="margin-top:10%;">
        <div class="col-lg-12 offset-lg-0">
            <h5 class="text-center facebook" style="color:#595959;">Your wishlist is empty.</h5>
        </div>
    </div>
    <%}%>
</div>
<jsp:include page="footer.jsp"/>