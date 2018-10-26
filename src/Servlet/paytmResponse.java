package Servlet;

import Objects.Const;
import com.paytm.pg.merchant.CheckSumServiceHelper;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.TreeMap;

@WebServlet(name = "paytmResponse")
public class paytmResponse extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paytmChecksum = null;
        TreeMap<String, String> paytmParams = new TreeMap<>();
        for (Map.Entry<String, String[]> requestParamsEntry : request.getParameterMap().entrySet()) {
            if ("CHECKSUMHASH".equalsIgnoreCase(requestParamsEntry.getKey())) {
                paytmChecksum = requestParamsEntry.getValue()[0];
            } else {
                paytmParams.put(requestParamsEntry.getKey(), requestParamsEntry.getValue()[0]);
            }
        }
        boolean isValidChecksum = false;
        try {
            isValidChecksum = CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(Const.PayTm_Merchant_key, paytmParams, paytmChecksum);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (isValidChecksum) {
            System.out.append("Checksum Matched");
            String OID = paytmParams.get("ORDER_ID");
            JSONObject object = new JSONObject();
            object.put("MID", Const.PayTm_Merchant_ID);
            object.put("ORDERID", OID);
            String postData = "JsonData=" + object.toString();
            URL url = new URL("https://securegw-stage.paytm.in/merchant-status/getTxnStatus");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("contentType", "application/json");
            connection.setUseCaches(false);
            connection.setDoOutput(true);
            DataOutputStream requestWriter = new DataOutputStream(connection.getOutputStream());
            requestWriter.writeBytes(postData);
            requestWriter.close();
            String responseData = "";
            InputStream is = connection.getInputStream();
            BufferedReader responseReader = new BufferedReader(new InputStreamReader(is));
            if ((responseData = responseReader.readLine()) != null) {
                System.out.append("Response Json = " + responseData);
            }
            System.out.append("Requested Json = " + postData + " ");
            responseReader.close();
        } else {
            System.out.append("Checksum MisMatch");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
