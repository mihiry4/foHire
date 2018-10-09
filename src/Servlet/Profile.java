package Servlet;

import Objects.Const;
import Objects.user;
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
        String arr[] = s.split("/");
        s = arr[3];
        int user_id=0;
        boolean signedUser = false;
        if (request.getSession().getAttribute("user")!=null){
            user_id = (int) request.getSession().getAttribute("user");
        }
        user u = new user();
        if (user_id!=0){
            try {
                PreparedStatement ps = connection.prepareStatement("select user_id from users where user_id = ? and user_name = ?");
                ps.setInt(1, user_id);
                ps.setString(2, s);
                if(ps.executeQuery().next()){
                    signedUser = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        u.userid = user_id;
        u.fillDetails(connection);
        request.setAttribute("Profile_user", u);
        request.setAttribute("signedUser", signedUser);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
