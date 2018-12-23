package Servlet;

import Objects.Const;
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        out.print("why are you doing this???");
        out.close();
    }

    private void respond(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int profileUID;
        int user_id = 0;
        boolean signedUser = false;
        if (request.getSession().getAttribute("user") != null) {
            user_id = (Integer) request.getSession().getAttribute("user");
        }
        String s = request.getRequestURI();
        String[] arr = s.split("/");
        if (arr.length == Const.value) {
            if (user_id != 0) {

                PreparedStatement ps = connection.prepareStatement("select user_name from users where user_id = ?");
                ps.setInt(1, user_id);
                ResultSet rs = ps.executeQuery();
                rs.next();
                response.sendRedirect(Const.root + "profile/" + rs.getString(1));
                ps.close();

            } else {
                response.sendRedirect(Const.root);
            }
            return;
        }
        String S = arr[Const.value];
        if (S.equals("assets")) {
            s = s.substring(Const.substr);
            request.getRequestDispatcher(s).forward(request, response);
            return;
        }

        PreparedStatement ps = connection.prepareStatement("select user_id from users where user_name = ? and deactivated = 0");
        ps.setString(1, S);
        ResultSet r = ps.executeQuery();
        if (r.next()) {
            profileUID = r.getInt(1);
        } else {
            request.getRequestDispatcher("/404.jsp").forward(request, response);
            return;
        }
        ps.close();


        user u = new user();
        u.userName = S;
        if (user_id != 0) {

            ps = connection.prepareStatement("select user_id from users where user_id = ? and user_name = ?");
            ps.setInt(1, user_id);
            ps.setString(2, u.userName);
            if (ps.executeQuery().next()) {
                signedUser = true;
            }

        }
        ResultSet rs;
        ps = connection.prepareStatement("select p.* from users natural join product as p where user_name = ? and status = true");
        ps.setString(1, u.userName);
        rs = ps.executeQuery();

        u.userid = profileUID;
        u.fillDetails(connection);
        request.setAttribute("Profile_user", u);
        request.setAttribute("signedUser", signedUser);
        request.setAttribute("products", rs);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
