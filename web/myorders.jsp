<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 26-10-2018
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Deactivate"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<section>
    <div class="container">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <a href="invoice.html" class="orders_link">
                    <div class="orders">
                        <div class="d-inline-block p-2"><img src="assets/img/th-06.jpg"></div>
                        <div class="d-inline-block p-2">
                            <h5>Name</h5>
                            <p>Product name</p>
                        </div>
                    </div>
                </a>
                <a href="invoice.html" class="orders_link">
                    <div class="orders">
                        <div class="d-inline-block p-2"><img src="assets/img/d.jpg"></div>
                        <div class="d-inline-block p-2">
                            <h5>Name</h5>
                            <p>Product name</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
