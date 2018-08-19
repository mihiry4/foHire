package Servlet;

import Objects.DB;
import Objects.IdTokenVerifierAndParser;
import Objects.user;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Random;

import static org.apache.http.params.CoreProtocolPNames.USER_AGENT;

//Handle exceptional request still remaining
//otp expiry remaining
@WebServlet(name = "signup")
public class signup extends HttpServlet {
    private Connection connection;
    private HashMap<String, Integer> map = new HashMap<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id_token = request.getParameter("id_token");
        if (id_token != null) {
            try {
                GoogleIdToken.Payload payload = IdTokenVerifierAndParser.getPayload(id_token);
                String googleAuth = payload.getSubject();
                String email = payload.getEmail();
                boolean emailVerified = payload.getEmailVerified();
                String pictureUrl = (String) payload.get("picture");
                String lastName = (String) payload.get("family_name");
                String firstName = (String) payload.get("given_name");
                user u = new user();
                u.googleLogin(connection, firstName, lastName, email, googleAuth, emailVerified, pictureUrl);
                //user u = new user(connection, firstName, lastName, email, googleAuth, emailVerified, pictureUrl);
                if (u.userid != 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", u.userid);
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot sign in");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                String type = request.getParameter("type");
                if (type.equals("d")) {
                    String username = request.getParameter("username");
                    String firstname = request.getParameter("firstName");
                    String lastname = request.getParameter("lastName");
                    String companyName = request.getParameter("companyName");   //what to do???
                    String mobileNumber = request.getParameter("mobileNumber");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String otp = request.getParameter("otp");

                    if (map.containsKey(mobileNumber) && map.get(mobileNumber).toString().equals(otp)) {
                        map.remove(mobileNumber);
                        user u = new user();
                        try {
                            u.signup(connection, firstname, lastname, username, email, mobileNumber, password, true);
                        } catch (IllegalArgumentException e) {
                            response.sendError(HttpServletResponse.SC_CONFLICT, "User with this details already exists");
                        }
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("user", u.userid);
                        response.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid OTP");
                    }
                } else {
                    String mobile = request.getParameter("mobileNumber");
                    int num;
                    if (! map.containsKey(mobile)) {
                        num = 1000 + (int) (Math.random() * (9999 - 1000));
                        map.put(mobile, num);
                    } else {
                        num = map.get(mobile);
                    }
                    String url = "http://www.smsidea.co.in/sendsms.aspx?mobile=7984180139&pass=VQKZO&senderid=SMSBUZ&to=" + mobile + "&msg=Your one time passcode for fohire is " + num;
                    URL obj = new URL(url);
                    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                    con.setRequestMethod("GET");
                    int responseCode = con.getResponseCode();
                    System.out.println("GET Response Code :: " + responseCode);

                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
        rd.forward(request, response);*/
        /*String mobile = request.getParameter("mob");
        String num = "4df";
        String url = "http://www.smsidea.co.in/sendsms.aspx?mobile=7984180139&pass=VQKZO&senderid=SMSBUZ&to=" + mobile + "&msg=Your one time passcode for fohire is " + num;
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();*/
        URL sendUrl = new URL("http://smsidea.co.in/sendsms.aspx");
        HttpURLConnection httpConnection = (HttpURLConnection) sendUrl
                .openConnection();
        httpConnection.setRequestMethod("POST");
        httpConnection.setDoInput(true);
        httpConnection.setDoOutput(true);
        httpConnection.setUseCaches(false);
        DataOutputStream dataStreamToServer = new DataOutputStream(
                httpConnection.getOutputStream());
        dataStreamToServer.writeBytes("mobile="
                + URLEncoder.encode("7984180139", "UTF-8") + "&pass="
                + URLEncoder.encode("VQKZO", "UTF-8") + "&senderid="
                + URLEncoder.encode("SMSBUZ", "UTF-8") + "&to="
                + URLEncoder.encode("7984180139", "UTF-8") + "&msg="
                + URLEncoder.encode("mmdgfkxc.hgk.xghuk", "UTF-8"));
        dataStreamToServer.flush();
        dataStreamToServer.close();
        BufferedReader dataStreamFromUrl = new BufferedReader(
                new InputStreamReader(httpConnection.getInputStream()));
        String dataFromUrl = "", dataBuffer = "";
        while ((dataBuffer = dataStreamFromUrl.readLine()) != null) {
            dataFromUrl += dataBuffer;
        }
        dataStreamFromUrl.close();
        System.out.println("Response: " + dataFromUrl);
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
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(DB.DBclass, DB.user, DB.pass);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
