package Servlet;

import Objects.Const;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "Deactivate")
public class Deactivate extends HttpServlet {
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

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        int user_id = (Integer) request.getSession().getAttribute("user");
        PreparedStatement preparedStatement = connection.prepareStatement("update users set deactivated = 1 where user_id = ?");
        preparedStatement.setInt(1, user_id);
        preparedStatement.executeUpdate();
        preparedStatement = connection.prepareStatement("update product set status = 0 where user_id = ?");
        preparedStatement.setInt(1, user_id);
        preparedStatement.executeUpdate();
        request.getSession().invalidate();
        response.sendRedirect(Const.root);
    }

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
