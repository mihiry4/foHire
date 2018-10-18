<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Choose from catalouge"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<%
    String Item = request.getParameter("item");
    String Category = request.getParameter("category");
    String City = request.getParameter("city");
    String typ = request.getParameter("type");
    if ((Item != null) && !(Item.equals(""))) {
%>
<script>$(document).ready(function () {
    $.post("Borrow", {
        item: <%=Item%>,
        category: <%=Category%>,
        city: <%=City%>,
        typ: <%=typ%>
    }, function (data) {
        $("#results").innerText = data
    }).fail(function () {
        $("#fail").text("Could not find any item like this");
    });
});</script>
<%}%>
<script>$(document).ready(function () {
    $("#search").click(function () {
        $.post("Borrow", {
            item: $("#item").val(),
            category: $("#category").val(),
            city: $("#city").val()
        }, function (data) {
            $("#results").innerText = data
        }).fail(function () {
            $("#fail").text("Could not find any item like this");
        });
    });
});</script>
<section style="margin-top:3%;">            <%--ToDo: add spinner by rudra--%>
    <div class="container">
        <form>
            <div class="form-row">
                <div class="col"><input id="item" class="form-control" type="text" placeholder="What are you looking for?"></div>
                <div class="col"><select id="category" class="form-control">
                    <optgroup label="Select Category">
                        <option value="1" selected="">Books</option>
                        <option value="2">Blu-ray and console games</option>
                    </optgroup>
                </select></div>
                <div
                        class="col"><input id="city" class="form-control" type="text" placeholder="Search region here"></div>
                <div class="col">
                    <button id="search" class="btn btn-primary btn-block" type="button" style="background-color:#f8b645;">Search</button>
                </div>
            </div>
        </form>
    </div>
</section>
<section style="background-color:#ffffff;">
    <section class="py-5">
        <div class="container">
            <div id="results" class="row filtr-container">
                <%--<div class="col-md-6 col-lg-3 filtr-item" data-category="2,3">
                    <div class="card border-dark">
                        <div class="card-header text-light" style="background-color:#f8b645;">
                            <h5 class="d-inline-block m-0" style="width:75%;">This girl</h5>
                        </div>
                        <img class="img-fluid card-img w-100 d-block rounded-0" src="assets/img/th-01.jpg">
                        <div class="d-flex card-footer">
                            <button class="btn btn-dark btn-sm btn-orng" type="button" style="background-color:#f8b645;"><i class="icon ion-android-star-half"></i>4.5</button>
                            <div class="click" onclick="heartcng(0)">
                                <span class="fa fa-heart-o"></span>
                                <div class="ring"></div>
                                <div class="ring2"></div>
                            </div>
                        </div>
                    </div>
                    <div class="pricetag">
                        <p style="margin-bottom:0px;"><strong>Ahmedabad</strong></p>
                        <p>Rs.100000 Per Day</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 filtr-item" data-category="2,3">
                    <div class="card border-dark">
                        <div class="card-header text-light" style="background-color:#f8b645;">
                            <h5 class="d-inline-block m-0" style="width:75%;">This girl</h5>
                        </div>
                        <img class="img-fluid card-img w-100 d-block rounded-0" src="assets/img/th-08.jpg">
                        <div class="d-flex card-footer">
                            <button class="btn btn-dark btn-sm btn-orng" type="button" style="background-color:#f8b645;"><i class="icon ion-android-star-half"></i>4.5</button>
                            <div class="click" onclick="heartcng(1)">
                                <span class="fa fa-heart-o"></span>
                                <div class="ring"></div>
                                <div class="ring2"></div>
                            </div>
                        </div>
                    </div>
                    <div class="pricetag">
                        <p style="margin-bottom:0px;"><strong>Ahmedabad</strong></p>
                        <p>Rs.100000 Per Day</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 filtr-item" data-category="2,3">
                    <div class="card border-dark">
                        <div class="card-header text-light" style="background-color:#f8b645;">
                            <h5 class="m-0">Lorem Ipsum</h5>
                        </div>
                        <img class="img-fluid card-img w-100 d-block rounded-0" src="assets/img/th-06.jpg">
                        <div class="d-flex card-footer">
                            <button class="btn btn-dark btn-sm btn-orng" type="button" style="background-color:#f8b645;"><i class="icon ion-android-star-half"></i>4.5</button>
                            <div class="click" onclick="heartcng(2)">
                                <span class="fa fa-heart-o"></span>
                                <div class="ring"></div>
                                <div class="ring2"></div>
                            </div>
                        </div>
                    </div>
                    <div class="pricetag">
                        <p style="margin-bottom:0px;"><strong>Ahmedabad</strong></p>
                        <p>Rs.100000 Per Day</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 filtr-item" data-category="2,3">
                    <div class="card border-dark">
                        <div class="card-header text-light" style="background-color:#f8b645;">
                            <h5 class="m-0">Lorem Ipsum</h5>
                        </div>
                        <img class="img-fluid card-img w-100 d-block rounded-0" src="assets/img/th-02.jpg">
                        <div class="d-flex card-footer">
                            <button class="btn btn-dark btn-sm btn-orng" type="button" style="background-color:#f8b645;"><i class="icon ion-android-star-half"></i>4.5</button>
                            <div class="click" onclick="heartcng(3)">
                                <span class="fa fa-heart-o"></span>
                                <div class="ring"></div>
                                <div class="ring2"></div>
                            </div>
                        </div>
                    </div>
                    <div class="pricetag">
                        <p style="margin-bottom:0px;"><strong>Ahmedabad</strong></p>
                        <p>Rs.100000 Per Day</p>
                    </div>
                </div>--%>
            </div>
        </div>
    </section>
</section>
<jsp:include page="footer.jsp"/>
