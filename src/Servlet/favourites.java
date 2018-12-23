package Servlet;

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
import java.sql.SQLException;

@WebServlet(name = "favourites")
public class favourites extends HttpServlet {
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

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        PrintWriter out = response.getWriter();
        int product_id = 0;
        try {
            product_id = Integer.parseInt(request.getParameter("pid"));
        } catch (NumberFormatException e) {
            out.print("Don't send wrong parameters");
        }
        String action = request.getParameter("action");
        if (product_id != 0 && action != null) {

            if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
                int user_id = (int) request.getSession().getAttribute("user");


                if (action.equals("add")) {
                    PreparedStatement preparedStatement = connection.prepareStatement("insert into favorites values (?, ?)");
                    preparedStatement.setInt(1, user_id);
                    preparedStatement.setInt(2, product_id);
                    preparedStatement.executeUpdate();
                } else if (action.equals("delete")) {
                    PreparedStatement preparedStatement = connection.prepareStatement("delete from favorites where (user_id = ? and product_id = ?)");
                    preparedStatement.setInt(1, user_id);
                    preparedStatement.setInt(2, product_id);
                    preparedStatement.executeUpdate();
                }
            }
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
