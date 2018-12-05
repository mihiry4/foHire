package Servlet;

import Objects.Const;
import com.google.maps.GeoApiContext;
import com.mysql.cj.jdbc.MysqlDataSource;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "Order")
public class Order extends HttpServlet {
    private Connection connection;
    private GeoApiContext geoApi;

    private static String calculateRFC2104HMAC(String data)
    {
        String result=null;
        try {

            // get an hmac_sha256 key from the raw secret bytes
            SecretKeySpec signingKey = new SecretKeySpec(Const  .Razorpay_secret.getBytes(), "HmacSHA256");

            // get an hmac_sha256 Mac instance and initialize with the signing key
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            // compute the hmac on input data bytes
            byte[] rawHmac = mac.doFinal(data.getBytes());

            // base64-encode the hmac
            result = DatatypeConverter.printHexBinary(rawHmac).toLowerCase();

        } catch (Exception e) {
            e.printStackTrace();
            //throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
        }
        return result;
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String payment_id = request.getParameter("payment_id");
        String signature = request.getParameter("signature");
        String order_id = request.getParameter("order_id");

        String generated_sign = calculateRFC2104HMAC(order_id+"|"+payment_id);

        try{
            if (generated_sign.equals(signature)){
                out.println("payment successful");

            }else {
                out.println("payment failed");
            }
        }finally {
            out.println("payment failed");
            out.close();
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
