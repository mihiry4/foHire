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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "/login")
public class login extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String input = request.getParameter("login");
        String password = request.getParameter("password");
        user u = null;
        if (input != null && password != null && ! input.equals("") && ! password.equals(""))
            u = new user();
        try {
            u.login(connection, input, password);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Username or password does not match.");
        }


        HttpSession session = request.getSession();
        session.setAttribute("user", u.userid);
        response.setStatus(HttpServletResponse.SC_OK);

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