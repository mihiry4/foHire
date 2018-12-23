package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "comment")
public class comment extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondPost(request, response);
        } catch (SQLException e) {
            connection = Objects.Const.openConnection();
            try {
                respondPost(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        HttpSession session = request.getSession();
        int user = (Integer) session.getAttribute("user");
        int product = (Integer) session.getAttribute("product");
        if (user != 0 && product != 0) {
            String r = request.getParameter("rating");
            String review = request.getParameter("review");
            double rating = Double.parseDouble(r);
            PreparedStatement preparedStatement = connection.prepareStatement("update fohire.reviews set deleted = true where product_id = ? and user_id = ?");
            preparedStatement.setInt(1, product);
            preparedStatement.setInt(2, user);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("insert into reviews (product_id, user_id, rating, review) values (?,?,?,?)");
            preparedStatement.setInt(1, product);
            preparedStatement.setInt(2, user);
            preparedStatement.setDouble(3, rating);
            preparedStatement.setString(4, review);
            preparedStatement.executeUpdate();
        }
        response.setHeader("REFRESH", "0");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/404.jsp");
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
