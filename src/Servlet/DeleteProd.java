package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "DeleteProd")
public class DeleteProd extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            respondPost(request, response);
        } catch (SQLException e) {
            connection = Objects.Const.openConnection();
            try {
                respondPost(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    private void respondPost(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        try {
            String Pid = request.getParameter("pid");
            int pid = Integer.parseInt(Pid);
            int uid = (Integer) request.getSession().getAttribute("user");
            PreparedStatement preparedStatement = connection.prepareStatement("update product set status = 0 where product_id = ? and user_id = ?");
            preparedStatement.setInt(1, pid);
            preparedStatement.setInt(2, uid);
            preparedStatement.executeUpdate();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            throw e;
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Some error occurred.");
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
