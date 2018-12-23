package Servlet;

import Objects.product;

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

@WebServlet(name = "Home")
public class Home extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("why are you doing this???");
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respond(request, response);
        } catch (SQLException e) {
            connection = Objects.Const.openConnection();
            try {
                respond(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    private void respond(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        product[] products;
        int user_id = 0;
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            user_id = (Integer) request.getSession().getAttribute("user");
        }
        PreparedStatement preparedStatement = connection.prepareStatement("select product_id, favorites.user_id from product left outer join favorites using (product_id) where (favorites.user_id = ? or favorites.user_id is null) and status = true order by upload_time desc limit 6", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        preparedStatement.setInt(1, user_id);
        ResultSet rs = preparedStatement.executeQuery();
        rs.last();
        int row = rs.getRow();
        products = new product[row];
        rs.beforeFirst();
        for (int i = 0; i < products.length; i++) {
            rs.next();
            products[i] = new product();
            products[i].product_id = rs.getInt(1);
            products[i].favourite = rs.getInt(2) != 0;
            products[i].fillDetails(connection);
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
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
