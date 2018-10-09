package Servlet;

import Objects.Const;
import com.mysql.cj.jdbc.MysqlDataSource;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;

@WebServlet(name = "DeliverMessages")
public class DeliverMessages extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Enumeration e = request.getParameterNames();
            while (e.hasMoreElements()) {
                request.getParameter((String) e.nextElement());
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user");
        String email = request.getParameter("EMail");
        int other_user_id;
        String name;
        String profile_pic;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id, concat(first_name, \" \", last_name) as name, profile_pic from users where email_id = ?");
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            other_user_id = resultSet.getInt(1);
            name = resultSet.getString(2);
            profile_pic = resultSet.getString(3);
            out.print(name + profile_pic);    // to be added by Rudra
            preparedStatement = connection.prepareStatement("select sender, content, time from messages where (sender = ? and receiver = ?) or (sender = ? and receiver = ?)");
            preparedStatement.setInt(1, user_id);
            preparedStatement.setInt(2, other_user_id);
            preparedStatement.setInt(3, other_user_id);
            preparedStatement.setInt(4, user_id);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                if (resultSet.getInt(1) == user_id) {
                    //if user has sent the message
                    out.print("");
                } else {
                    //if user has not sent the message
                }
            }
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
