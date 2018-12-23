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

@WebServlet(name = "Message")
public class Message extends HttpServlet {
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
        String s = request.getRequestURI();
        String[] arr = s.split("/");
        if (arr.length == Const.value) {
            response.sendRedirect(Const.root + "Conversations");
            return;
        }
        String S = arr[Const.value];
        if (S.equals("assets")) {
            s = s.substring(Const.substr);
            request.getRequestDispatcher(s).forward(request, response);
            return;
        }
        int userid = (Integer) request.getSession().getAttribute("user");
        String user_id, otheru, otherf;
        PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
        preparedStatement.setInt(1, userid);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        user_id = rs.getString(1);
        preparedStatement.close();

        otheru = arr[Const.value];
        preparedStatement = connection.prepareStatement("select first_name from users where user_name = ?");
        preparedStatement.setString(1, otheru);
        rs = preparedStatement.executeQuery();
        if (rs.next()) {
            otherf = rs.getString(1);
        } else {
            response.sendRedirect(Const.root + "Conversations");
            return;
        }

        request.setAttribute("u", user_id);
        request.setAttribute("otheru", otheru);
        request.setAttribute("otherf", otherf);
        request.getRequestDispatcher("/message.jsp").forward(request, response);
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
