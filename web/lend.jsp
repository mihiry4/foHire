<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 28-07-2018
  Time: 11:02 PM
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Lend"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<div class="container">
    <div class="row no-gutters justify-content-center">
        <div class="col-lg-8">
            <div class="lendform">
                <form>
                    <div id="fstpg">
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
                                        <td colspan="3"><input class="form-control" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td>Product category:</td>
                                        <td colspan="3"><select class="form-control">
                                            <option value="game">Games</option>
                                        </select></td>
                                    </tr>
                                    <tr>
                                        <td>Available From:</td>
                                        <td colspan="3"><input class="form-control" type="date"></td>
                                    </tr>
                                    <tr>
                                        <td>Available Till:</td>
                                        <td colspan="3"><input class="form-control" type="date"></td>
                                    </tr>
                                    <tr>
                                        <td>Rent expected(<i class="fa fa-rupee"></i>):</td>
                                        <td><input class="form-control form-control-lg" type="text"></td>
                                        <td>/-</td>
                                        <td><select class="form-control">
                                            <option value="" selected=""></option>
                                            <option value="day">Per Day</option>
                                            <option value="month">Per Month</option>
                                        </select></td>
                                    </tr>
                                    <tr>
                                        <td>Deposit amount(<i class="fa fa-rupee"></i>):</td>
                                        <td colspan="2"><input class="form-control" type="text"></td>
                                        <td colspan="2">/-</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <button class="btn btn-primary float-right qbtn" type="button" id="nextbtn">
                                                Next
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                    <div class="d-none" id="secpg">
                        <fieldset>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th colspan="2">Lend your product</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Thumbnail image:</td>
                                        <td colspan="2"><input type="file" accept=".jpg" required=""></td>
                                    </tr>
                                    <tr>
                                        <td>Product images:</td>
                                        <td colspan="2"><input type="file" accept="image/*" multiple=""></td>
                                    </tr>
                                    <tr>
                                        <td>Location:</td>
                                        <td colspan="2"><input class="form-control" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td>Description:</td>
                                        <td colspan="2"><textarea class="form-control"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td>Late charges(<i class="fa fa-rupee"></i>):
                                            <p style="font-size:11px;">(per day late charge)</p>
                                        </td>
                                        <td><input class="form-control" type="text"></td>
                                        <td>/-</td>
                                    </tr>
                                    <tr>
                                        <td>Cancellation policy:</td>
                                        <td colspan="2"><select class="form-control"></select></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button class="btn btn-primary qbtn" type="button" id="prvbtn">Previous
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-primary float-right qbtn" type="submit">Submit
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>