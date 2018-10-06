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
<section data-aos="fade-up" data-aos-duration="650" class="head" style="background-color:rgba(0,0,0,0.5);">
    <div class="tline" style="margin-top:0;padding-top:10%;">
        <h1 class="text-monospace text-capitalize text-center" style="color:rgb(248,182,69);">Update to renting.</h1>
        <h5 class="text-center" style="color:rgb(248,182,69);">Fohire helps you find things you want to rent.<br></h5>
    </div>
    <div>
        <div class="container">
            <form>
                <div class="form-row formres" style="padding:50px 0px;">
                    <div class="col-lg-8 offset-lg-2">
                        <div class="form-group d-flex">
                            <input class="form-control searchqirayaa" type="text" placeholder="Search ">
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
        <h5 class="text-center" style="color:#f8b645;">Lend&nbsp;<a class="text-light" href="lend.jsp">here.</a></h5>
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
                    <a href="#" class="catblocka">
                        <div class="catblock">
                            <div class="d-inline-block" style="margin:30px 20px;">
                                <h6 style="color:rgb(65,65,65);">Books</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-4">
                    <a href="#" class="catblocka">
                        <div class="catblock">
                            <div class="d-inline-block" style="margin:30px 20px;">
                                <h6 style="color:rgb(65,65,65);">Blu-ray and console games</h6>
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
        <h4 class="text-center">Discover some of the best rental deals and book them for tonight, tomorrow and next week.<br></h4>
    </div>
    <div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <section class="py-5">
                        <div class="container">
                            <div class="row filtr-container">
                                <div class="col-md-6 col-lg-3 filtr-item nodec" data-category="2,3">        <%--start from this--%>
                                    <div class="cardparent">
                                        <a href="#" class="nodec">
                                            <div>
                                                <div class="card"><img class="img-fluid card-img-top w-100 d-block rounded-0" src="assets/img/back1.jpg"></div>
                                                <div class="pricetag">
                                                    <p style="margin-bottom:0px;color:#f8b645;"><strong>Product name&nbsp;&middot;&nbsp;</strong><i class="icon ion-android-star-half"></i><strong>4.5</strong><br></p>
                                                    <p style="margin-bottom:0px;font-size:22px;"><strong>Ahmedabad</strong></p>
                                                    <p>Rs.100000 Per Day</p>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="d-flex card-foot">
                                            <div class="click" onclick="heartcng(this)">
                                                <span class="fa fa-heart-o"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>      <%--Upto this--%>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>