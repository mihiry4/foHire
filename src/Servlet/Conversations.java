package Servlet;

import Objects.Const;

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

@WebServlet(name = "Conversations")
public class Conversations extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("why are you doing this???");
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respond(request, response);
        } catch (SQLException e) {
            connection = Const.openConnection();
            try {
                respond(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    private void respond(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        if (request.getSession().getAttribute("user") == null) {
            request.getRequestDispatcher(Const.root).forward(request, response);
            return;
        }
        int userid = (Integer) request.getSession().getAttribute("user");
        String user_id;
        PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
        preparedStatement.setInt(1, userid);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        user_id = rs.getString(1);
        preparedStatement.close();

        request.setAttribute("u", user_id);
        request.getRequestDispatcher("/conversations.jsp").forward(request, response);
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
