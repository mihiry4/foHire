package Servlet;

import Objects.product;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.mysql.cj.exceptions.ConnectionIsClosedException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "Lend")
@MultipartConfig
public class Lend extends HttpServlet {
    Connection connection;
    private AmazonS3 s3;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respondPost(request, response);
        } catch (ConnectionIsClosedException e) {
            connection = Objects.Const.openConnection();
            respondPost(request, response);
        }
    }

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ConnectionIsClosedException {
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String availTill = request.getParameter("availTill");
        String availFrom = request.getParameter("availFrom");
        String rent = request.getParameter("rent");
        String region = request.getParameter("region");
        String city = request.getParameter("city");
        String deposit = request.getParameter("deposit");
        String description = request.getParameter("description");
        int user_id = 0;
        user_id = (Integer) request.getSession().getAttribute("user");    //todo:if user not logged in prompt him to log in
        product p = new product();
        p.lend(connection, user_id, productName, category, description, region, city, rent, deposit, availFrom, availTill);
        if (p.product_id != 0) {

            //image handling
            int i = 0;
            Part filePart = request.getPart("thumbnail"); // Retrieves <input type="file" name="file">
            InputStream thumbnailContent = filePart.getInputStream();
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("image/png");
            PutObjectRequest objectRequest = new PutObjectRequest("fohire", "product/" + p.product_id + "_" + i, thumbnailContent, metadata);
            s3.putObject(objectRequest);
            ++i;

            List<Part> fileParts = request.getParts().stream().filter(part -> "images".equals(part.getName())).collect(Collectors.toList()); // Retrieves <input type="file" name="file" multiple="true">

            for (Part filePart1 : fileParts) {
                InputStream Content = filePart1.getInputStream();
                ObjectMetadata metadata1 = new ObjectMetadata();
                metadata.setContentType("image/png");
                PutObjectRequest objectRequest1 = new PutObjectRequest("fohire", "product/" + p.product_id + "_" + i, Content, metadata1);
                s3.putObject(objectRequest1);
                if (++i > 3) break;
            }

            p.setImg(connection, i);
            RequestDispatcher rd = request.getRequestDispatcher("LendSuccess.jsp");
            rd.forward(request, response);
        } else {
            //error in uploading product    ToDo:edited with rudra
            PrintWriter out = response.getWriter();
            out.println("error");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
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
