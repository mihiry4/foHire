package Servlet;

import Objects.product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import static java.time.temporal.ChronoUnit.DAYS;

@WebServlet(name = "request")
public class request extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

    private void respond(HttpServletRequest request, HttpServletResponse response) throws SQLException {
            int user_id = (Integer) request.getSession().getAttribute("user");
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            LocalDate fromDate = LocalDate.parse(request.getParameter("fromDate"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            LocalDate tillDate = LocalDate.parse(request.getParameter("tillDate"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            if (tillDate.isAfter(fromDate) && fromDate.isAfter(LocalDate.now().plusDays(1))) {
                boolean flag = true;
                product p = new product();
                p.product_id = product_id;
                p.getBookedDates(connection);
                LocalDate[][] Dates = p.Dates;
                for (LocalDate[] Date : Dates) {
                    if (!(tillDate.isBefore(Date[0].minusDays(1)) || fromDate.isAfter(Date[1].plusDays(1)))) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    PreparedStatement preparedStatement = connection.prepareStatement("select user_id, price, deposit from fohire.product where product_id = ?");
                    preparedStatement.setInt(1, product_id);
                    ResultSet rs = preparedStatement.executeQuery();
                    rs.next();
                    int requestee = rs.getInt(1);
                    int price = rs.getInt(2);
                    int deposit = rs.getInt(3);
                    long days = fromDate.until(tillDate, DAYS);
                    long amount = (days * price) + deposit;
                    preparedStatement = connection.prepareStatement("insert into Request (Requester, Requestee, product_id, Booked_From, Booked_Till, Amount) values (?, ?, ?, ?, ?, ?)");
                    preparedStatement.setInt(1, user_id);
                    preparedStatement.setInt(2, requestee);
                    preparedStatement.setInt(3, product_id);
                    preparedStatement.setObject(4, fromDate);
                    preparedStatement.setObject(5, tillDate);
                    preparedStatement.setLong(6, amount);
                    preparedStatement.executeUpdate();
                }
            }

    }

    @Override
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
