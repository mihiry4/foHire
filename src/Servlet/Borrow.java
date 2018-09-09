package Servlet;

import Objects.DB;
import Objects.product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "Borrow")
public final class Borrow extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String item = request.getParameter("item");
        String category = request.getParameter("category");
        String city = request.getParameter("city");

        if (item == null || category == null || city == null || item.equals("") || category.equals("") || city.equals("")) {
            response.setStatus(404);
        } else {
            try {
                PreparedStatement preparedStatement = connection.prepareStatement("select product_id from product where product_name like ? and category = ? and city = ?");
                preparedStatement.setString(1, "%" + item + "%");
                preparedStatement.setString(2, category);
                preparedStatement.setString(3, city);
                ResultSet rs = preparedStatement.executeQuery();
                PrintWriter out = response.getWriter();
                while (rs.next()) {
                    product p = new product();
                    p.product_id = rs.getInt(1);
                    p.fillDetails(connection);
                    out.print("<div class=\"col-md-6 col-lg-3 filtr-item\" data-category=\"2,3\">\n" +
                            "                    <div class=\"card border-dark\">\n" +
                            "                        <div class=\"card-header text-light\" style=\"background-color:#f8b645;\">\n" +
                            "                            <h5 class=\"m-0\">" + p.product_name + "</h5>\n" +
                            "                        </div>\n" +
                            "                        <img class=\"img-fluid card-img w-100 d-block rounded-0\" src=\"" + p.img[1] + "\">\n" +
                            "                        <div class=\"d-flex card-footer\">\n" +
                            "                            <button class=\"btn btn-dark btn-sm btn-orng\" type=\"button\" style=\"background-color:#f8b645;\"><i class=\"icon ion-android-star-half\"></i>" + p.rating + "</button>\n" +
                            "                            <div class=\"click\" onclick=\"heartcng(" + p.product_id + ")\">\n" +
                            "                                <span class=\"fa fa-heart-o\"></span>\n" +
                            "                                <div class=\"ring\"></div>\n" +
                            "                                <div class=\"ring2\"></div>\n" +
                            "                            </div>\n" +
                            "                        </div>\n" +
                            "                    </div>\n" +
                            "                    <div class=\"pricetag\">\n" +
                            "                        <p style=\"margin-bottom:0px;\"><strong>" + p.city + "</strong></p>\n" +
                            "                        <p>Rs." + p.price + " Per Day</p>\n" +
                            "                    </div>\n" +
                            "                </div>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
        rd.forward(request, response);
    }

    @Override
    public void destroy() {
        super.destroy();
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
