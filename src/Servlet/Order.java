package Servlet;

import Objects.Const;
import Objects.product;
import Objects.user;
import com.mysql.cj.jdbc.MysqlDataSource;
import com.paytm.pg.merchant.CheckSumServiceHelper;

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
import java.util.Map;
import java.util.TreeMap;

@WebServlet(name = "Order")
public class Order extends HttpServlet {
    private Connection connection;
    private int cur_order_id;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            int request_id = Integer.parseInt(request.getParameter("request"));
            int user_id = (Integer) request.getSession().getAttribute("user");
            PreparedStatement preparedStatement = connection.prepareStatement("select * from Request where Request_id = ? and Requester = ?");
            preparedStatement.setInt(1, request_id);
            preparedStatement.setInt(2, user_id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int requester = rs.getInt("Requester");
                int product_id = rs.getInt("product_id");
                LocalDate fromDate = rs.getObject("Booked_From", LocalDate.class);
                LocalDate tillDate = rs.getObject("Booked_Till", LocalDate.class);
                int amount = rs.getInt("Amount");
                boolean pending = rs.getBoolean("Pending");
                boolean accepted = rs.getBoolean("Accepted");
                if (requester == user_id && !pending && accepted) {
                    product p = new product();
                    p.product_id = product_id;
                    LocalDate[][] Dates = p.getBookedDates(connection);
                    boolean flag = true;
                    for (LocalDate[] Date : Dates) {
                        if (!(tillDate.isBefore(Date[0].minusDays(1)) || fromDate.isAfter(Date[1].plusDays(1)))) {
                            flag = false;
                            break;
                        }
                    }
                    if (flag) {
                        user u = new user();
                        u.userid = user_id;
                        u.fillDetails(connection);
                        cur_order_id++;
                        TreeMap<String, String> paytmParams = new TreeMap<>();
                        paytmParams.put("MID", Const.PayTm_Merchant_ID);
                        paytmParams.put("ORDER_ID", Integer.toString(cur_order_id));
                        paytmParams.put("CHANNEL_ID", "WEB");
                        paytmParams.put("CUST_ID", "CUST_" + u.userName);
                        paytmParams.put("MOBILE_NO", u.mobile);
                        paytmParams.put("EMAIL", u.email);
                        paytmParams.put("TXN_AMOUNT", Integer.toString(amount));
                        paytmParams.put("WEBSITE", "WEBSTAGING");
                        paytmParams.put("INDUSTRY_TYPE_ID", "Retail");
                        paytmParams.put("CALLBACK_URL", "paytmResponse");
                        String paytmChecksum = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum(Const.PayTm_Merchant_key, paytmParams);
                        StringBuilder outputHtml = new StringBuilder();
                        outputHtml.append("<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>");
                        outputHtml.append("<html>");
                        outputHtml.append("<head>");
                        outputHtml.append("<title>Merchant Checkout Page</title>");
                        outputHtml.append("</head>");
                        outputHtml.append("<body>");
                        outputHtml.append("<center><h1>Please do not refresh this page...</h1></center>");
                        outputHtml.append("<form method='post' action='https://securegw-stage.paytm.in/theia/processTransaction' name='f1'>");
                        for (Map.Entry<String, String> entry : paytmParams.entrySet()) {
                            outputHtml.append("<input type='hidden' name='").append(entry.getKey()).append("' value='").append(entry.getValue()).append("'>");
                        }
                        outputHtml.append("<input type='hidden' name='CHECKSUMHASH' value='").append(paytmChecksum).append("'>");
                        outputHtml.append("</form>");
                        outputHtml.append("<script type='text/javascript'>");
                        outputHtml.append("document.f1.submit();");
                        outputHtml.append("</script>");
                        outputHtml.append("</body>");
                        outputHtml.append("</html>");
                        out.print(outputHtml);
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
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
