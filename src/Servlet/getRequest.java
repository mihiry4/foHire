package Servlet;

import org.json.JSONArray;
import org.json.JSONObject;

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
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet(name = "getRequest")
public class getRequest extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        JSONArray array = new JSONArray();
        int user_id = (Integer) request.getSession().getAttribute("user");
        PreparedStatement preparedStatement = connection.prepareStatement("select Booked_From, Booked_Till, price, deposit, Amount, first_name, user_name, Time, product_name, Request_id, PG_id, last_name from (Request inner join product using (product_id)) inner join users on (Requestee=users.user_id) where (Requester = ? and Pending = ? and Accepted = ?)");
        preparedStatement.setInt(1, user_id);
        preparedStatement.setBoolean(2, false);
        preparedStatement.setBoolean(3, true);
        ResultSet rs = preparedStatement.executeQuery();
        putObj(array, rs, true);
        preparedStatement = connection.prepareStatement("select Booked_From, Booked_Till, price, deposit, Amount, first_name, user_name, Time, product_name, Request_id, PG_id, last_name from (Request inner join product using (product_id)) inner join users on (Requester=users.user_id) where (Requestee = ? and Pending = ?)");
        preparedStatement.setInt(1, user_id);
        preparedStatement.setBoolean(2, true);
        rs = preparedStatement.executeQuery();
        putObj(array, rs, false);
        PrintWriter out = response.getWriter();
        out.print(array);
        out.close();
    }

    private void putObj(JSONArray array, ResultSet rs, boolean pay) throws SQLException {
        while (rs.next()) {
            JSONObject object = new JSONObject();
            object.put("from", rs.getObject(1, LocalDate.class));
            object.put("till", rs.getObject(2, LocalDate.class));
            object.put("price", rs.getInt(3));
            object.put("deposit", rs.getInt(4));
            object.put("amount", rs.getInt(5));
            object.put("first_name", rs.getString(6));
            object.put("user_name", rs.getString(7));
            object.put("time", rs.getTimestamp(8));
            object.put("product_name", rs.getString(9));
            object.put("pay", pay);
            object.put("Request_id", rs.getString(10));
            object.put("Order_id", rs.getString(11));
            object.put("last_name", rs.getString(12));
            array.put(object);
        }
        rs.close();
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
