import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "login")
public class login extends HttpServlet {
    Connection connection;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String input = request.getParameter("login");
        String password = request.getParameter("password");
        user user = new user(connection, input, password);
        if(user!=null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.userid);
        }else {

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
            connection = DriverManager.getConnection("gdbc", "usrname", "password");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
