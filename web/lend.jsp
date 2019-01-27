<%@ page import="Objects.Const" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 11:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    if (request.getSession().getAttribute("user") == null)
        request.getRequestDispatcher("index.jsp").forward(request, response);
%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Lend your product"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<%if (request.getAttribute("LendSuccess") != null && !(Boolean) request.getAttribute("LendSuccess")) {%>

<%}%>
<div class="container">
    <div class="row no-gutters justify-content-center">
        <div class="col-lg-8">
            <div class="lendform">
                <form method="post" action="<%=Const.root%>lend" enctype="multipart/form-data">
                    <div id="fstpg1">
                        <fieldset>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th colspan="4">Lend your product</th>
                                    </tr>
                                    </thead>
                                    <tbody class="tbdy">
                                    <tr>
                                        <td>Product name:</td>
                                        <td colspan="3"><input name="productName" required="" class="form-control" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td>Product category:</td>
                                        <td colspan="3"><select required="" name="category" class="form-control">
                                            <option value="1" selected="">Books</option>
                                            <option value="2">Blu-ray and console games</option>
                                            <option value="3">Sports Equipment</option>
                                        </select></td>
                                    </tr>
                                    <tr>
                                        <td>Available From:</td>
                                        <td colspan="3"><input name="availFrom" class="form-control" type="date"></td>
                                    </tr>
                                    <tr>
                                        <td>Available Till:</td>
                                        <td colspan="3"><input name="availTill" class="form-control" type="date"></td>
                                    </tr>
                                    <tr>
                                        <td>Rent expected(<i class="fa fa-rupee"></i>):</td>
                                        <td><input required="" name="rent" class="form-control form-control-lg" type="number" ></td>
                                        <td></td>
                                        <td>Per day</td>
                                    </tr>
                                    <tr>
                                        <td>Deposit amount(<i class="fa fa-rupee"></i>):</td>
                                        <td colspan="2"><input name="deposit" class="form-control" type="number" required=""></td>
                                        <td colspan="2"></td>
                                    </tr>


                                    <tr>
                                        <td colspan="4">
                                            <button class="btn btn-primary float-right qbtn" type="button" id="nextbtn1">Next</button>
                                        </td>
                                    </tr>
                                    <%if (request.getAttribute("LendSuccess") != null && !(Boolean) request.getAttribute("LendSuccess")) {%>
                                    <tr>
                                        <td colspan="4" class="fohireclr text-center font-weight-bold rounded" style="font-size: 20px" >Lend failed!</td>
                                    </tr>
                                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                    <div class="d-none" id="secpg1">
                        <fieldset>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th colspan="2">Lend your Objects</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Thumbnail image:</td>
                                        <td colspan="2"><input required="" name="thumbnail" type="file" accept="image/*" onchange="readURL(this);"><img src="#" id="blah" style="height:0;width:0;"/></td>
                                    </tr>
                                    <tr>
                                        <td>Product images:<span class="d-block" style="font-size:13px;">(Maximum 3 images)</span></td>
                                        <td colspan="2"><input required="" name="images" type="file" accept="image/*" multiple="multiple" id="gallery-photo-add" max="3">
                                            <div class="gallery"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Location:</td>
                                        <td colspan="2"><input required="" name="region" id="autocomplete"
                                                               placeholder="Enter your address"
                                                               onFocus="geolocate()" class="form-control" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td>Description:</td>
                                        <td colspan="2"><textarea required="" name="description" class="form-control"></textarea></td>
                                    </tr>
                                    <%--<tr>--%>
                                        <%--<td>Late charges(<i class="fa fa-rupee"></i>):--%>
                                            <%--<p style="font-size:11px;">(per day late charge)</p>--%>
                                        <%--</td>--%>
                                        <%--<td><input name="late" class="form-control" type="number"></td>--%>
                                        <%--<td>/-</td>--%>
                                    <%--</tr>--%>
                                    <%--<tr>--%>
                                        <%--<td>Cancellation policy:</td>--%>
                                        <%--<td colspan="2"><select name="policy" class="form-control"></select></td>--%>
                                    <%--</tr>--%>
                                    <tr>
                                        <td>
                                            <button class="btn btn-primary qbtn" type="button" id="prvbtn1">Previous
                                            </button>
                                        </td>
                                        <td><button class="btn btn-primary float-right qbtn" type="submit">Submit</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <input type="hidden" name="city" id="cty">
                            </div>
                        </fieldset>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function initAutocomplete() {
        autocomplete = new google.maps.places.Autocomplete(
            (document.getElementById('autocomplete')),
            {types: ['geocode']});

        autocomplete.addListener('place_changed', function () {
            var place = autocomplete.getPlace();
            for (let i = 0; i < place.address_components.length; i++) {
                if (place.address_components[i].types[0] === "locality") {
                    document.getElementById("cty").value = place.address_components[i].long_name;
                }
            }
        });
    }

    function geolocate() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var geolocation = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                var circle = new google.maps.Circle({
                    center: geolocation,
                    radius: position.coords.accuracy
                });
                autocomplete.setBounds(circle.getBounds());
            });
        }
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=<%=Const.Maps_APIKey%>&libraries=places&callback=initAutocomplete"
        async defer></script>
<jsp:include page="footer.jsp">
    <jsp:param name="chatkit" value="no"/>
</jsp:include>
