package Servlet;

import Objects.Const;
import com.mysql.cj.jdbc.MysqlDataSource;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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


                try {
                    if (action.equals("add")) {
                        PreparedStatement preparedStatement = connection.prepareStatement("insert into favorites values (?, ?)");
                        preparedStatement.setInt(1, user_id);
                        preparedStatement.setInt(2, product_id);
                        preparedStatement.executeUpdate();
                    }else if (action.equals("delete")){
                        PreparedStatement preparedStatement = connection.prepareStatement("delete from favorites where (user_id = ? and product_id = ?)");
                        preparedStatement.setInt(1, user_id);
                        preparedStatement.setInt(2, product_id);
                        preparedStatement.executeUpdate();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }


            } else {
                //ToDo: send user to login page
            }
        }
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
