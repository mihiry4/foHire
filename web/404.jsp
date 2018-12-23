<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 27-07-2018
  Time: 05:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="foHire"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="non-index"/>
</jsp:include>
<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1"><img alt="404 error" src="assets/img/404.png"
                                                    style="display: block;margin-left: auto;margin-right: auto;width: 100%;"/>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <h2 class="text-center" style="filter: blur(0px);color: #f8b645;">This page has been borrowed!</h2>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
