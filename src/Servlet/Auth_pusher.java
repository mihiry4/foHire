package Servlet;

import Objects.ApiResponse;
import Objects.ChatKit;
import Objects.Const;
import com.mysql.cj.exceptions.ConnectionIsClosedException;

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
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Auth_pusher")
public class Auth_pusher extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondPost(request, response);
        } catch (ConnectionIsClosedException e) {
            connection = Objects.Const.openConnection();
            respondPost(request, response);
        }
    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ConnectionIsClosedException, IOException {
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            int user_id = (int) request.getSession().getAttribute("user");
            PrintWriter out = response.getWriter();
            String user_name = request.getParameter("user_id");
            Map<String, String> map = new HashMap<>();
            map.put("instanceLocator", Const.Pusher_instanceLocator);
            map.put("key", Const.Pusher_secret);
            try {
                PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_name = ? and user_id =  ?");
                preparedStatement.setString(1, user_name);
                preparedStatement.setInt(2, user_id);
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    ChatKit chatKit = new ChatKit(map);
                    ApiResponse a = chatKit.authenticate(user_name);
                    out.print(a);
                }
            } catch (ConnectionIsClosedException e) {
                throw e;
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //doPost(request, response);
        RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
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
