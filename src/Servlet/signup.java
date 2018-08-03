package Servlet;

import Objects.DB;
import Objects.user;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "signup")
public class signup extends HttpServlet {
    private Connection connection;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            connection = DriverManager.getConnection("jdbc.localhost", "username", "password");
            String username = request.getParameter("username");
            String Firstname = request.getParameter("Firstname");
            String Lastname = request.getParameter("Lastname");
            user u = new user(connection, Firstname, Lastname, username, "njn", "sdg", true);
            System.out.println(u.userid);
            if(u!=null){
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", u.userid);
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
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
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
