<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 4/10/18
  Time: 11:03 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="foHire"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value=""/>
</jsp:include>
<section style="margin-top: 40px">
    <div class="container">
        <div class="row">
            <div class="col">
                <div>
                    <h1 class="fohireclr text-center">FAQs</h1>
                </div>
                <div style="margin-top: 10px;">
                    <h4>Q. What is fohire?</h4>
                    <h5>&nbsp; Fohire is an upgraded style of using commodities. We help you lend and borrow stuff, when buying makes no sense.</h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. How can I lend?</h4>
                    <h5>&nbsp; You can lend stuff you&#39;re not using by clicking lend button.<br /></h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. How can I borrow?</h4>
                    <h5>&nbsp; Borrowing is easiest thing to do on our website. Just type in product name or category into the search bar and hit search. Browse from our hundreds of different products.<br /></h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. Will fohire provide delivery services?</h4>
                    <h5>&nbsp; We try to provide delivery services to most of the products to save you from the hassle. Those products meeting our criteria for delivery are displayed with a book button next to them.<br /></h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. Can I choose whom to lend my things?</h4>
                    <h5>&nbsp; Definitely. While we are very proud of our borrowers, your stuff is always yours to choose who to lend to. You can accept or decline requests as it suits you.<br /></h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. What happens if my products gets damaged?</h4>
                    <h5>&nbsp; We understand no one likes a damaged return. You can ask for damage compensation from Fohire if you&#39;re using our services. We estimate the damage charges and guarantee you the right compensation.<br /></h5>
                </div>
                <div style="margin-top: 30px;">
                    <h4>Q. Can I choose the rent for products?</h4>
                    <h5>&nbsp; No one understands your product&#39;s value more than you do yourself. Hence, you own all rights to adjust the rent and deposit rates.<br /></h5>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>
