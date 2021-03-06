package Servlet;

import Objects.ApiResponse;
import Objects.ChatKit;
import Objects.Const;
import org.json.JSONArray;
import org.json.JSONObject;

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
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ChatWith")
public class ChatWith extends HttpServlet {
    Connection connection;

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

    private void respondPost(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        Map<String, String> map = new HashMap<>();
        map.put("instanceLocator", Const.Pusher_instanceLocator);
        map.put("key", Const.Pusher_secret);
        ChatKit chatKit = null;
        try {
            chatKit = new ChatKit(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(request.getSession()!=null && request.getSession().getAttribute("user")!= null){
            try {
                String Sender = "";

                int sender = (int)request.getSession().getAttribute("user");
                String receiver = request.getParameter("rec");
                PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
                preparedStatement.setInt(1, sender);
                ResultSet rs = preparedStatement.executeQuery();
                if (rs.next()){
                    Sender = rs.getString(1);
                }
                assert chatKit != null;
                ApiResponse A = chatKit.getUserRooms(Sender);
                JSONObject a = new JSONObject(A.toString());
                JSONArray rooms = a.getJSONArray("payload");
                for (int i = 0; i < rooms.length(); i++) {
                    JSONObject room = rooms.getJSONObject(i);
                    JSONArray members = room.getJSONArray("member_user_ids");
                    if (members.getString(0).equals(receiver)||members.getString(1).equals(receiver)){
                        response.sendRedirect(Const.root + "message/" + receiver);
                        return;
                    }
                }
                Map<String, Object> map1 = new HashMap<>();
                map1.put("private", true);
                map1.put("user_ids",new String[]{Sender,receiver});
                map1.put("name", Sender + "_" + receiver);
                chatKit.createRoom(Sender, map1);
                response.sendRedirect(Const.root + "message/" + receiver);
            } catch (SQLException e) {
                throw e;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

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
