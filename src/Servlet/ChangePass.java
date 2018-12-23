package Servlet;

import Objects.user;

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
        int user_id = (int) request.getSession().getAttribute("user");
        String Opasswd = request.getParameter("old_pass");
        String Npasswd = request.getParameter("new_pass");
        String Cpasswd = request.getParameter("conf_pass");
        if (Npasswd.equals(Cpasswd)) {
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
            PrintWriter out = response.getWriter();
            out.print("Your password has been successfully updated");
        } else {
            request.getRequestDispatcher("404.jsp").forward(request, response);
        }
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
