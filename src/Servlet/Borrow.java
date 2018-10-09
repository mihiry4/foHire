package Servlet;

import Objects.Const;
import Objects.product;
import com.mysql.cj.jdbc.MysqlDataSource;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String item = request.getParameter("item");
        String category = request.getParameter("category");
        String city = request.getParameter("city");
        int user_id = 0 ;
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            user_id = (int) request.getSession().getAttribute("user");}

        if (item == null || category == null || city == null || item.equals("") || category.equals("") || city.equals("")) {
            response.setStatus(404);
        } else {
            try {
                PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (product_name like ? and category = ? and city = ?) and (favorites.user_id = ? or favorites.user_id is null ) order by product.upload_time desc");        //ToDo: can be improved: Handle null city and cat values
                preparedStatement.setString(1, "%" + item + "%");
                preparedStatement.setString(2, category);
                preparedStatement.setString(3, city);
                preparedStatement.setInt(4, user_id);
                ResultSet rs = preparedStatement.executeQuery();
                PrintWriter out = response.getWriter();
                while (rs.next()) {
                    product p = new product();
                    p.product_id = rs.getInt(1);
                    p.favourite = rs.getInt(2) != 0;
                    p.fillDetails(connection);
                    StringBuilder sb = new StringBuilder();
                    sb.append("<div class=\"col-md-6 col-lg-3 filtr-item nodec\" data-category=\"2,3\">\n")
                            .append("<div class=\"cardparent\">\n")
                            .append("a href=\"#\" class=\"nodec\">\n").append("<div>\n")
                            .append("<div class=\"card\"><img class=\"img-fluid card-img-top w-100 d-block rounded-0\" src=\"")
                            .append(p.img[0]).append("\"></div>\n").append("<div class=\"pricetag\">\n")
                            .append("<p style=\"margin-bottom:0;color:#f8b645;\"><strong>")
                            .append(p.product_name).append("&nbsp;&middot;&nbsp;</strong><i class=\"icon ion-android-star-half\"></i><strong>")
                            .append(p.rating).append("</strong><br></p>\n")
                            .append("<p style=\"margin-bottom:0;font-size:22px;\"><strong>")
                            .append(p.city).append("</strong></p>\n").append("<p>&#8377;")
                            .append(p.price).append(" Per Day</p>\n").append("</div>\n")
                            .append("</div>\n").append("</a>\n")
                            .append("<div class=\"d-flex card-foot\">\n")
                            .append("<div class=\"click\" onclick=\"heartcng(this)\">\n")
                            .append("<span class=\"fa fa-heart");
                    if (!p.favourite) sb.append("-o");
                    sb.append("\"></span>\n").append("</div>\n").append("</div>\n").append("</div>\n").append("</div>");
                    out.print(sb);
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
            MysqlDataSource dataSource = new MysqlDataSource();
            dataSource.setURL(Const.DBclass);
            dataSource.setUser(Const.user);
            dataSource.setPassword(Const.pass);
            connection = dataSource.getConnection();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
