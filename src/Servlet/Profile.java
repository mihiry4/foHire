package Servlet;

import Objects.user;

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

@WebServlet(name = "Profile")
public class Profile extends HttpServlet {
    Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("why are you doing this???");
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String s = request.getRequestURI();
        String[] arr = s.split("/");
        String S = arr[3];
        if (S.equals("assets")) {
            s = s.substring(15);
            request.getRequestDispatcher(s).forward(request, response);
        }
        int user_id=0;
        boolean signedUser = false;
        if (request.getSession().getAttribute("user")!=null){
            user_id = (Integer) request.getSession().getAttribute("user");
        }
        user u = new user();
        if (user_id!=0){
            try {
                PreparedStatement ps = connection.prepareStatement("select user_id from users where user_id = ? and user_name = ?");
                ps.setInt(1, user_id);
                ps.setString(2, S);
                if(ps.executeQuery().next()){
                    signedUser = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.getRequestDispatcher("404.jsp").forward(request, response);
            }
        }
        ResultSet rs = null;
        try {
            PreparedStatement ps = connection.prepareStatement("select p.* from users natural join product as p where user_name = ?");
            ps.setString(1, u.userName);
            rs = ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("404.jsp").forward(request, response);
        }
        u.userid = user_id;
        u.fillDetails(connection);
        request.setAttribute("Profile_user", u);
        request.setAttribute("signedUser", signedUser);
        request.setAttribute("products", rs);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
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
