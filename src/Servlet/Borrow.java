package Servlet;

import Objects.Const;
import Objects.product;
import com.mysql.cj.exceptions.ConnectionIsClosedException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "Borrow")
public final class Borrow extends HttpServlet {
    private Connection connection;

    private void printProduct(ResultSet rs, PrintWriter out) throws SQLException {
        while (rs.next()) {
            product p = new product();
            p.product_id = rs.getInt(1);
            p.favourite = rs.getInt(2) != 0;
            p.fillDetails(connection);
            StringBuilder sb = new StringBuilder();
            sb.append("<div class=\"col-md-6 col-lg-3 filtr-item nodec\" data-category=\"2,3\">\n")
                    .append("<div class=\"cardparent\">\n")
                    .append("<a href=\"").append(Const.root).append("product/").append(p.product_id).append("\" class=\"nodec\">\n").append("<div>\n")
                    .append("<div class=\"card\"><img class=\"img-fluid card-img-top w-100 d-block rounded-0\" src=\"")
                    .append(Const.S3URL).append("product/").append(p.product_id).append("_0").append("\"></div>\n").append("<div class=\"pricetag\">\n")
                    .append("<p style=\"margin-bottom:0;color:#f8b645;\"><strong>")
                    .append(p.product_name).append("&nbsp;&middot;&nbsp;</strong><i class=\"icon ion-android-star-half\"></i><strong>")
                    .append(p.rating).append("</strong><br></p>\n")
                    .append("<p style=\"margin-bottom:0;font-size:22px;\"><strong>")
                    .append(p.city).append("</strong></p>\n").append("<p>&#8377;")
                    .append(p.price).append(" Per Day</p>\n").append("</div>\n")
                    .append("</div>\n").append("</a>\n")
                    .append("<div class=\"d-flex card-foot\">\n")
                    .append("<div class=\"click\" onclick=\"heartcng(this, ").append(p.product_id).append("\">\n")
                    .append("<span class=\"fa fa-heart");
            if (!p.favourite) sb.append("-o");
            sb.append("\"></span>\n").append("</div>\n").append("</div>\n").append("</div>\n").append("</div>");
            out.print(sb);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondPost(request, response);
        } catch (ConnectionIsClosedException e) {
            connection = Objects.Const.openConnection();
            respondPost(request, response);
        }
    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ConnectionIsClosedException {
        PrintWriter out = response.getWriter();
        String item = request.getParameter("item");
        String category = request.getParameter("category");
        String city = request.getParameter("city");
        String type = request.getParameter("type");
        String sort = request.getParameter("sort");


        int user_id = 0;
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            user_id = (Integer) request.getSession().getAttribute("user");
        }

        if (type != null) {
            if (type.equals("item")) {
                try {
                    if (item == null || item.equals("")) {
                        response.setStatus(404);
                    } else {
                        PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (product_name like ?) and (favorites.user_id = ? or favorites.user_id is null ) order by product.upload_time desc");
                        preparedStatement.setString(1, "%" + item + "%");
                        preparedStatement.setInt(2, user_id);
                        ResultSet rs = preparedStatement.executeQuery();
                        printProduct(rs, out);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else if (type.equals("category")) {
                try {
                    if (category == null || category.equals("")) {
                        response.setStatus(404);
                    } else {
                        PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (category = ?) and (favorites.user_id = ? or favorites.user_id is null ) order by product.upload_time desc");
                        preparedStatement.setInt(1, Integer.parseInt(category));
                        preparedStatement.setInt(2, user_id);
                        ResultSet rs = preparedStatement.executeQuery();
                        printProduct(rs, out);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            if (item == null || category == null || city == null || item.equals("") || category.equals("") || city.equals("")) {
                response.setStatus(404);
            } else {
                try {
                    int s = Integer.parseInt(sort);
                    String Sort;
                    switch (s) {
                        case 0:
                            Sort = "price asc, product.upload_time desc";
                            break;
                        case 1:
                            Sort = "price desc, product.upload_time desc";
                            break;
                        case 3:
                            Sort = "product.rating desc, product.upload_time desc";
                            break;
                        case 2:
                        default:
                            Sort = "product.upload_time desc, product.rating desc";
                            break;
                    }
                    PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (product_name like ? and category = ? and city = ?) and (favorites.user_id = ? or favorites.user_id is null ) order by " + Sort);
                    preparedStatement.setString(1, "%" + item + "%");
                    preparedStatement.setInt(2, Integer.parseInt(category));
                    preparedStatement.setString(3, city);
                    preparedStatement.setInt(4, user_id);
                    ResultSet rs = preparedStatement.executeQuery();
                    printProduct(rs, out);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
        rd.forward(request, response);
    }

    @Override
    public void destroy() {
        super.destroy();
        Objects.Const.closeConnection(connection);
    }

    @Override
    public void init() throws ServletException {
        super.init();
        connection = Objects.Const.openConnection();
    }
}
