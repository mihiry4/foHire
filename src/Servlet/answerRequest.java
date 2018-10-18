package Servlet;

import Objects.Const;
import com.mysql.cj.jdbc.MysqlDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "answerRequest")
public class answerRequest extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("You don't get anything from here");
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int i = 0;
        try {
            int user_id = (Integer) request.getSession().getAttribute("user");
            int request_id = Integer.parseInt(request.getParameter("request"));
            boolean accepted = request.getParameter("type").equals("accept");
            PreparedStatement preparedStatement = connection.prepareStatement("update Request set Pending = ?, Accepted = ? where Request_id = ? and Requestee = ?");
            preparedStatement.setBoolean(1, false);
            preparedStatement.setBoolean(2, accepted);
            preparedStatement.setInt(3, request_id);
            preparedStatement.setInt(4, user_id);
            i = preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (i == 0) {
                response.setStatus(400);
            }
        }
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
