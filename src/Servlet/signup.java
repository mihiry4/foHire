package Servlet;

import Objects.Const;
import Objects.IdTokenVerifierAndParser;
import Objects.user;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.mysql.cj.exceptions.ConnectionIsClosedException;
import org.json.JSONException;
import org.json.JSONObject;

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
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

//Handle exceptional request still remaining
//otp expiry remaining
@WebServlet(name = "signup")
public class signup extends HttpServlet {
    private Connection connection;
    private HashMap<String, Integer> map = new HashMap<>();

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

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
                u.SocialLogin(connection, firstName, lastName, email, googleAuth, emailVerified, pictureUrl, true);
                if (u.userid != 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", u.userid);
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot sign in");
                }
            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                String type = request.getParameter("type");
                if (type == null) {
                    String username = request.getParameter("username");
                    String firstname = request.getParameter("firstName");
                    String lastname = request.getParameter("lastName");
                    String companyName = request.getParameter("companyName");   //ToDO:what to do???
                    String mobileNumber = request.getParameter("mobileNumber");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String otp = request.getParameter("otp");
                    String referral = request.getParameter("referral");
                    String reCAPTCHA = request.getParameter("g-recaptcha-response");

                    if (isCaptchaValid(reCAPTCHA)) {
                        if (map.containsKey(mobileNumber) && map.get(mobileNumber).toString().equals(otp)) {
                            map.remove(mobileNumber);
                            user u = new user();
                            try {
                                u.signup(connection, firstname, lastname, username, email, mobileNumber, password, true, referral);
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
                        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid reCAPTCHA");
                    }
                } else if (type.equals("o")) {
                    String mobile = request.getParameter("mobileNumber");
                    int num;
                    if (!map.containsKey(mobile)) {
                        num = 1000 + (int) (Math.random() * (9999 - 1000));
                        map.put(mobile, num);
                    } else {
                        num = map.get(mobile);
                    }
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
                            + URLEncoder.encode("Your one time passcode for fohire is " + num, "UTF-8"));
                    dataStreamToServer.flush();
                    dataStreamToServer.close();
                    BufferedReader dataStreamFromUrl = new BufferedReader(
                            new InputStreamReader(httpConnection.getInputStream()));
                    StringBuilder dataFromUrl = new StringBuilder();
                    String dataBuffer;
                    while ((dataBuffer = dataStreamFromUrl.readLine()) != null) {
                        dataFromUrl.append(dataBuffer);
                    }
                    dataStreamFromUrl.close();
                    System.out.println("Response: " + dataFromUrl);
                }
            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondGet(request, response);
        } catch (SQLException e) {
            connection = Objects.Const.openConnection();
            try {
                respondGet(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    private void respondGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String Fb_token = request.getParameter("code");
        if (Fb_token != null) {
            String token = null;
            try {
                String g = "https://graph.facebook.com/oauth/access_token?client_id=" + Const.Fb_clientID + "&redirect_uri=" + URLEncoder.encode(Const.Redirect_URL, "UTF-8") + "&client_secret=" + Const.Fb_clientSecret + "&code=" + Fb_token;
                URL u = new URL(g);
                URLConnection c = u.openConnection();
                BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
                String inputLine;
                StringBuilder b = new StringBuilder();
                while ((inputLine = in.readLine()) != null)
                    b.append(inputLine).append("\n");
                in.close();
                token = b.toString();
                if (token.startsWith("{"))
                    throw new Exception("error on requesting token: " + token + " with code: " + Fb_token);
            } catch (Exception e) {
                e.printStackTrace();
                // an error occurred, handle this
            }

            String graph = null;
            try {
                String g = "https://graph.facebook.com/me?" + token;
                URL u = new URL(g);
                URLConnection c = u.openConnection();
                BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
                String inputLine;
                StringBuilder b = new StringBuilder();
                while ((inputLine = in.readLine()) != null)
                    b.append(inputLine).append("\n");
                in.close();
                graph = b.toString();
            } catch (ConnectionIsClosedException e) {
                throw e;
            } catch (Exception e) {
                e.printStackTrace();
                // an error occurred, handle this
            }

            String facebook_Auth;
            String firstName;
            String lastName;
            String email;

            try {
                JSONObject json = new JSONObject(graph);
                facebook_Auth = json.getString("id");
                firstName = json.getString("first_name");
                lastName = json.getString("last_name");
                email = json.getString("email");
                user u = new user();
                u.SocialLogin(connection, firstName, lastName, email, facebook_Auth, true, null, false);
            } catch (JSONException e) {
                e.printStackTrace();
                // an error occurred, handle this
            }
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/404.jsp");
            rd.forward(request, response);
        }
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

    private static boolean isCaptchaValid(String response) {
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify?"
                    + "secret=" + Const.reCAPTCHA_secret
                    + "&response=" + response;
            InputStream res = new URL(url).openStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, Charset.forName("UTF-8")));

            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            String jsonText = sb.toString();
            res.close();

            JSONObject json = new JSONObject(jsonText);
            return json.getBoolean("success");
        } catch (Exception e) {
            return false;
        }
    }
}
