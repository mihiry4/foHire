package Servlet;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "Lend")
@MultipartConfig
public class Lend extends HttpServlet {
    Connection connection;
    private AmazonS3 s3;

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

    protected void respondPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        /*boolean uploadFlag;
        Part filePart = request.getPart("thumbnail"); // Retrieves <input type="file" name="file">
        List<Part> fileParts = request.getParts().stream().filter(part -> "images".equals(part.getName())).collect(Collectors.toList()); // Retrieves <input type="file" name="file" multiple="true">

        uploadFlag = (filePart.getContentType().equals("image/png") || filePart.getContentType().equals("image/jpg") || filePart.getContentType().equals("image/jpeg")) && filePart.getSize() <= 5242880;
        for (Part filePart1 : fileParts) {
            uploadFlag = uploadFlag && (filePart1.getContentType().equals("image/png") || filePart1.getContentType().equals("image/jpg") || filePart1.getContentType().equals("image/jpeg")) && filePart1.getSize() <= 5242880;
        }

        if (!uploadFlag) {
            request.setAttribute("LendSuccess", false);
            RequestDispatcher rd = request.getRequestDispatcher(Const.root + "Lend");
            rd.forward(request, response);
            return;
        }

        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String availTill = request.getParameter("availTill");
        String availFrom = request.getParameter("availFrom");
        String rent = request.getParameter("rent");
        String region = request.getParameter("region");
        String city = request.getParameter("city");
        String deposit = request.getParameter("deposit");
        String description = request.getParameter("description");
        int user_id;
        user_id = (Integer) request.getSession().getAttribute("user");
        product p = new product();
        p.lend(connection, user_id, productName, category, description, region, city, rent, deposit, availFrom, availTill);
        if (p.product_id != 0) {

            //image handling
            int i = 0;

            *//*InputStream thumbnailContent = filePart.getInputStream();
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("image/png");
            PutObjectRequest objectRequest = new PutObjectRequest("fohire", "product/" + p.product_id + "_" + i, thumbnailContent, metadata);
            s3.putObject(objectRequest);*//*
            ++i;


            for (Part filePart1 : fileParts) {
                *//*InputStream Content = filePart1.getInputStream();
                ObjectMetadata metadata1 = new ObjectMetadata();
                metadata.setContentType("image/png");
                PutObjectRequest objectRequest1 = new PutObjectRequest("fohire", "product/" + p.product_id + "_" + i, Content, metadata1);
                s3.putObject(objectRequest1);*//*
                if (++i > 3) break;
            }

            p.setImg(connection, i);
            request.setAttribute("LendSuccess", true);
            RequestDispatcher rd = request.getRequestDispatcher("/");
            rd.forward(request, response);
        } else {
            request.setAttribute("LendSuccess", false);
            RequestDispatcher rd = request.getRequestDispatcher("Lend");
            rd.forward(request, response);
        }*/
        request.setAttribute("LendSuccess", true);
        RequestDispatcher rd = request.getRequestDispatcher("/");
        rd.forward(request, response);
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
        s3 = AmazonS3ClientBuilder.standard().withRegion(Regions.AP_SOUTH_1).withCredentials(DefaultAWSCredentialsProviderChain.getInstance()).build();

    }
}
