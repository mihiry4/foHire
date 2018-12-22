package Servlet;

import Objects.Const;
import com.mysql.cj.exceptions.ConnectionIsClosedException;

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
        } catch (ConnectionIsClosedException e) {
            connection = Objects.Const.openConnection();
            respondPost(request, response);
        }
    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ConnectionIsClosedException {
        int user_id = (Integer) request.getSession().getAttribute("user");
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("update users set deactivated = 1 where user_id = ?");
            preparedStatement.setInt(1, user_id);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("update product set status = 0 where user_id = ?");
            preparedStatement.setInt(1, user_id);
            preparedStatement.executeUpdate();
            request.getSession().invalidate();
            response.sendRedirect(Const.root);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(Const.root + "404.jsp");
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
