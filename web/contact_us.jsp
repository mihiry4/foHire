<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="foHire"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value=""/>
</jsp:include>
<section style="margin-top: 50px;">
    <div class="container">
        <h2 class="text-center">Contact us</h2>
        <h6 class="text-center">Please provide us with your valuable feedback. It will help us to improve your experience.</h6>
        <div class="row" style="margin-top: 70px;">
            <div class="col-lg-8 offset-lg-2">
                <form>
                    <div class="table-responsive table-borderless">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <td><strong>Name</strong></td>
                                <td><input class="form-control" type="text"></td>
                            </tr>
                            <tr>
                                <td><strong>E-mail</strong></td>
                                <td><input class="form-control" type="email"></td>
                            </tr>
                            <tr>
                                <td><strong>Description</strong></td>
                                <td><textarea class="form-control" rows="5"></textarea></td>
                            </tr>
                            <tr>
                                <td colspan="2"><button class="btn btn-primary float-right qbtn" type="button">Send</button></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="yes"/>
</jsp:include>