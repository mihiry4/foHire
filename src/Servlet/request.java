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
            int user_id = (Integer) request.getSession().getAttribute("user");
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            LocalDate fromDate = LocalDate.parse(request.getParameter("fromDate"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            LocalDate tillDate = LocalDate.parse(request.getParameter("tillDate"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            if (tillDate.isAfter(fromDate) && fromDate.isAfter(LocalDate.now().plusDays(1))) {
                PreparedStatement preparedStatement = connection.prepareStatement("select booked_from, booked_till from Booking where product_id = ? and booked_till < ? order by booked_till desc");
                preparedStatement.setInt(1, product_id);
                preparedStatement.setObject(2, LocalDate.now());
                ResultSet rs = preparedStatement.executeQuery();
                boolean flag = true;
                while (rs.next()) {
                    if (!(tillDate.isBefore(rs.getObject(1, LocalDate.class).minusDays(1)) || fromDate.isAfter(rs.getObject(2, LocalDate.class).plusDays(1)))) {
                        flag = false;
                        break;
                    }
                }
                if (flag) {
                    preparedStatement = connection.prepareStatement("select user_id, price, deposit from fohire.product where product_id = ?");
                    preparedStatement.setInt(1, product_id);
                    rs = preparedStatement.executeQuery();
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
        } catch (Exception e) {
            response.setStatus(400);
        }


    }

    @Override
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
