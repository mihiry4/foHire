package Servlet;

import Objects.Const;
import Objects.user;
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

@WebServlet(name = "ChangePass")
public class ChangePass extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int user_id = (int) request.getSession().getAttribute("user");
        String Opasswd = request.getParameter("old_pass");
        String Npasswd = request.getParameter("new_pass");
        String Cpasswd = request.getParameter("conf_pass");
        if (Npasswd.equals(Cpasswd)) {
            try {
                PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where user_id =? and password = ?");
                preparedStatement.setInt(1, user_id);
                preparedStatement.setString(2, user.hashpass(Opasswd));
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    preparedStatement = connection.prepareStatement("update users set password = ? where user_id = ?");
                    preparedStatement.setString(1, user.hashpass(Npasswd));
                    preparedStatement.setInt(2, user_id);
                    preparedStatement.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            PrintWriter out = response.getWriter();
            out.print("Your password has been successfully updated");
        } else {
            request.getRequestDispatcher("404.jsp").forward(request, response);
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
