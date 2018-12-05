package Servlet;

import Objects.Const;
import com.mysql.cj.jdbc.MysqlDataSource;

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
        int user_id = (int) request.getSession().getAttribute("user");
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("update users set deactivated = 1 where user_id = ?");
            preparedStatement.setInt(1, user_id);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("update product set status = 0 where user_id = ?");
            preparedStatement.setInt(1, user_id);
            preparedStatement.executeUpdate();
            request.getSession().setAttribute("user", null);
            response.sendRedirect("/");
        } catch (SQLException e) {
            e.printStackTrace();
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
