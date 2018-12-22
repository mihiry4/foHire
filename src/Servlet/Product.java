package Servlet;

import Objects.Const;
import Objects.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "/Product")
public class Product extends HttpServlet {
    Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().println("Why? why are you sending post request to this page?");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String s = request.getRequestURI();
        String[] arr = s.split("/");
        String S = arr[Const.value];
        if (S.equals("assets")) {
            s = s.substring(Const.substr);
            request.getRequestDispatcher(s).forward(request, response);
            return;
        }
        int productId;
        try {
            productId = Integer.parseInt(S);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher(Const.root + "404.jsp").forward(request, response);
            return;
        }
        product p = new product();
        p.product_id = productId;
        if (!p.fillDetails(connection)) {
            request.getRequestDispatcher(Const.root + "404.jsp").forward(request, response);
            return;
        }
        p.getLender(connection);
        p.getBookedDates(connection);
        int uid = 0;
        Integer UID = (Integer) request.getSession().getAttribute("user");
        if (UID != null)
            uid = UID;
        p.getCommentsNU(connection, uid);
        p.getCommentU(connection, uid);
        request.setAttribute("product", p);
        request.getRequestDispatcher(Const.root + "product.jsp").forward(request, response);
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
