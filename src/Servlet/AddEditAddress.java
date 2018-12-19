package Servlet;

import com.mysql.cj.exceptions.ConnectionIsClosedException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AddEditAddress")
public class AddEditAddress extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondPost(request, response);
        } catch (ConnectionIsClosedException e) {
            connection = Objects.Const.openConnection();
            respondPost(request, response);
        }


    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String AddressID = request.getParameter("AID");
            int userId = (Integer) request.getSession().getAttribute("user");
            String name = request.getParameter("name");
            String house = request.getParameter("houseNo");
            String street = request.getParameter("Street");
            String locality = request.getParameter("locality");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String pincode = request.getParameter("pincode");
            String phone = request.getParameter("phone");


            PreparedStatement preparedStatement = connection.prepareStatement("insert into Addresses values ()");
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("404.jsp").forward(request, response);
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
