package Servlet;

import Objects.Const;
import com.mysql.cj.jdbc.MysqlDataSource;
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

@WebServlet(name = "getRequest")
public class getRequest extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONArray array = new JSONArray();
        try {
            int user_id = (Integer) request.getSession().getAttribute("user");
            PreparedStatement preparedStatement = connection.prepareStatement("select Booked_From, Booked_Till, price, deposit, Amount from Request inner join product using (product_id) where (Requestee = ? and Pending = ?) or (Requester = ? and Pending = ? and Accepted = ?)");
            preparedStatement.setInt(1, user_id);
            preparedStatement.setBoolean(2, true);
            preparedStatement.setInt(3, user_id);
            preparedStatement.setBoolean(4, false);
            preparedStatement.setBoolean(5, true);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                JSONObject object = new JSONObject();
                object.put("from", rs.getInt(1));
                object.put("till", rs.getInt(2));
                object.put("price", rs.getInt(3));
                object.put("deposit", rs.getInt(4));
                object.put("amount", rs.getInt(5));
                array.put(object);
            }
            /*JSONArray array = new JSONArray();
            JSONObject object = new JSONObject();
            object.put("from", "df");
            object.put("till", "sdfh");
            object.put("price", "hgjsaj");
            object.put("deposit", "5678");
            object.put("amount", "avgsjk");
            array.put(object);*/
            PrintWriter out = response.getWriter();
            out.print(array);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
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
