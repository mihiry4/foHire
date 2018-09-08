package Servlet;

import Objects.DB;
import com.pusher.rest.Pusher;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.print.Printable;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "DeliverMessages")
public class DeliverMessages extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Pusher pusher = new Pusher("594981", "5489f23731a659f68496", "b5746c3440f5d60fccca");


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
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
