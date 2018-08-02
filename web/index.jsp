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
<div class="modal fade visible" role="dialog" tabindex="-1" id="login">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#f8b645;">
        <h4 class="text-monospace modal-title">Login</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <div>
          <form><label>E-mail:</label><input class="form-control" type="text"
                                             required=""><label>Password:</label><input class="form-control"
                                                                                        type="password"
                                                                                        required=""><a
                  class="d-table" href="#" style="font-size:10px;">Forgot your password?</a>
            <button
                    class="btn btn-primary" type="submit" style="background-color:#f8b645;margin-top:10px;">
              Login
            </button>
          </form>
        </div>
      </div>
      <div class="modal-footer d-block">
        <div class="row">
          <div class="col">
            <button class="btn btn-primary" type="button"
                    style="width:100%;background-color:rgb(48,51,137);"><a href="#"
                                                                           style="color:rgb(255,255,255);font-size:20px;"><i
                    class="fab fa-facebook-square" style="font-size:30px;"></i>&nbsp; Login with
              Facebook</a></button>
          </div>
          <div
                  class="col">
            <button class="btn btn-primary" type="button"
                    style="width:100%;background-color:rgb(189,29,29);margin-top:10px;"><a href="#"
                                                                                           style="color:rgb(255,255,255);font-size:20px;"><i
                    class="fab fa-google-plus-square" style="font-size:30px;"></i>&nbsp; Login with
              Google</a></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade visible" role="dialog" tabindex="-1" id="signup">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#f8b645;">
        <h4 class="modal-title">Sign up</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
        <div>
          <form method="post" action="signup"><label>Username:</label><input class="form-control" type="text"
                                                                             required="true"><label>Firstname:</label><input
                  class="form-control" type="text" required="true"><label>Lastname:</label><input
                  class="form-control" type="text" required=""><label>Company name:</label>
            <input
                    class="form-control" type="text" required=""><label>Mobile number:</label><input
                    class="form-control" type="text" required="" maxlength="10" minlength="10"
                    pattern="^[0-9]*$"><label>E-mail:</label><input class="form-control"
                                                                    type="email"><label>Password:</label>
            <input
                    class="form-control" type="password" required=""><label>Confirm password:</label><input
                    class="form-control" type="password" required="">
            <div class="form-check"><input class="form-check-input" type="checkbox" required=""
                                           id="formCheck-2"><label class="form-check-label"
                                                                   for="formCheck-2">By clicking sign up you
              agree to our<a href="terms.html"> terms&nbsp;of service</a>&nbsp;and that you have read our
              <a href="terms.html">Privacy&nbsp;Policy</a>.</label></div>
            <button
                    class="btn btn-primary" type="submit" style="background-color:#f8b645;margin-top:10px;">
              Sign up
            </button>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <div class="row">
          <div class="col">
            <button class="btn btn-primary" type="button"
                    style="width:100%;background-color:rgb(48,51,137);"><a href="#"
                                                                           style="color:rgb(255,255,255);font-size:20px;"><i
                    class="fab fa-facebook-square" style="font-size:30px;"></i>&nbsp; Login with
              Facebook</a></button>
          </div>
          <div
                  class="col">
            <button class="btn btn-primary" type="button"
                    style="width:100%;background-color:rgb(189,29,29);margin-top:10px;"><a href="#"
                                                                                           style="color:rgb(255,255,255);font-size:20px;"><i
                    class="fab fa-google-plus-square" style="font-size:30px;"></i>&nbsp; Login with
              Google</a></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<section data-aos="fade-up" data-aos-duration="650" class="head" style="background-color:rgba(0,0,0,0.5);">
  <div class="tline" style="margin-top:0;padding-top:20%;">
    <h1 class="text-monospace text-capitalize text-center" style="color:rgb(248,182,69);">Update to renting.</h1>
    <h5 class="text-center" style="color:rgb(248,182,69);">fohire helps you find things you want to borrow. Let's
      fohire.<br></h5>
  </div>
  <div>
    <div class="container">
      <form>
        <div class="form-row formres" style="padding:50px 0px;">
          <div class="col"><input class="form-control searchqirayaa" type="text" placeholder="Search fohire">
          </div>
          <div class="col"><select class="form-control">
            <option value="All" selected="">All Categories</option>
            <option value="13">This is item 2</option>
            <option value="14">This is item 3</option>
          </select></div>
          <div class="col"><select class="form-control">
            <optgroup label="This is a group">
              <option value="12" selected="">This is item 1</option>
              <option value="13">This is item 2</option>
              <option value="14">This is item 3</option>
            </optgroup>
          </select></div>
          <div
                  class="col">
            <button class="btn btn-primary btn-block" type="submit"
                    style="background-color:rgb(248,182,69);border-color:transparent;">Search
            </button>
          </div>
          <div class="clearfix"></div>
        </div>
      </form>
    </div>
  </div>
  <div>
    <h2 class="text-center" style="color:#f8b645;">Be a lender yourself.</h2>
    <h5 class="text-center" style="color:#f8b645;">Lend&nbsp;<a class="text-light" href="#">here.</a></h5>
  </div>
</section>
<section style="background-color:#fffdfd;padding-top:60px;padding-bottom:60px;">
  <div>
    <div class="container">
      <div class="row places">
        <div class="col-lg-12">
          <div>
            <h1 class="text-left">Explore fohire<br></h1>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">&nbsp;Blu ray and games</h6>
              </div>
            </a>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">&nbsp;Books</h6>
              </div>
            </a>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">Electronics</h6>
              </div>
            </a>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">Sports and outdoors</h6>
              </div>
            </a>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">&nbsp;Utilities</h6>
              </div>
            </a>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="catblock">
            <a href="#">
              <div class="d-inline-block" style="width:100px;height:70px;"><img class="rounded img-fluid"
                                                                                src="assets/img/s.jpg"
                                                                                style="width:100%;height:100%;">
              </div>
              <div class="d-inline-block">
                <h6 style="color:rgb(65,65,65);">&nbsp;Others</h6>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<section style="background-color:#ffffff;">
  <div>
    <h1 class="text-center">Discover Our Great Last-Minute Rental Deals.<br></h1>
    <h4 class="text-center">Discover some of the best rental deals and book them for tonight, tomorrow and next
      week.<br></h4>
  </div>
  <div>
    <div class="container">
      <div class="row">
        <div class="col">
          <section class="py-5">
            <div class="container">
              <div class="row filtr-container">
                <div class="col-md-6 col-lg-3 filtr-item" data-category="2,3">
                  <div class="card border-dark">
                    <div class="card-header text-light" style="background-color:#f8b645;">
                      <h5 class="d-inline-block m-0" style="width:75%;">This girl</h5>
                    </div>
                    <img class="img-fluid card-img w-100 d-block rounded-0"
                         src="assets/img/th-01.jpg">
                    <div class="d-flex card-footer">
                      <button class="btn btn-dark btn-sm btn-orng" type="button"
                              style="background-color:#f8b645;"><i
                              class="icon ion-android-star-half"></i>4.5
                      </button>
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
                    <img class="img-fluid card-img w-100 d-block rounded-0"
                         src="assets/img/th-08.jpg">
                    <div class="d-flex card-footer">
                      <button class="btn btn-dark btn-sm btn-orng" type="button"
                              style="background-color:#f8b645;"><i
                              class="icon ion-android-star-half"></i>4.5
                      </button>
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
                    <img class="img-fluid card-img w-100 d-block rounded-0"
                         src="assets/img/th-06.jpg">
                    <div class="d-flex card-footer">
                      <button class="btn btn-dark btn-sm btn-orng" type="button"
                              style="background-color:#f8b645;"><i
                              class="icon ion-android-star-half"></i>4.5
                      </button>
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
                    <img class="img-fluid card-img w-100 d-block rounded-0"
                         src="assets/img/th-02.jpg">
                    <div class="d-flex card-footer">
                      <button class="btn btn-dark btn-sm btn-orng" type="button"
                              style="background-color:#f8b645;"><i
                              class="icon ion-android-star-half"></i>4.5
                      </button>
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
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
</section>
<jsp:include page="footer.jsp"/>