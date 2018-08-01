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
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="lendform">
                <form>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th colspan="2">Lend your Product</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Product name:</td>
                                <td><input class="form-control" type="text"></td>
                            </tr>
                            <tr>
                                <td>Product category:</td>
                                <td><select class="form-control">
                                    <option value="12" selected="">Games</option>
                                    <option value="13">This is item 2</option>
                                    <option value="14">This is item 3</option>
                                </select></td>
                            </tr>
                            <tr>
                                <td>Available From:</td>
                                <td><input class="form-control" type="date" required=""></td>
                            </tr>
                            <tr>
                                <td>Available Till:</td>
                                <td><input class="form-control" type="date" required=""></td>
                            </tr>
                            <tr>
                                <td>Thumbnail image</td>
                                <td><input type="file" accept="image/*"></td>
                            </tr>
                            <tr>
                                <td>Product images</td>
                                <td><input type="file" accept="image/*" multiple=""></td>
                            </tr>
                            <tr>
                                <td>Address:</td>
                                <td><input class="form-control" type="text"></td>
                            </tr>
                            <tr>
                                <td>Location:</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Description:</td>
                                <td><textarea class="form-control" rows="10"></textarea></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <button class="btn btn-primary btn-block" type="submit"
                                            style="background-color:#f8b645;">Submit
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>