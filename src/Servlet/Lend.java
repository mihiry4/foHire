package Servlet;

import Objects.DB;
import Objects.product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.nio.file.Files;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "Lend")
@MultipartConfig
public class Lend extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String availTill = request.getParameter("availTill");
        String availFrom = request.getParameter("availFrom");
        String rent = request.getParameter("rent");
        String deposit = request.getParameter("deposit");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String late = request.getParameter("late");
        String policy = request.getParameter("policy");
        int user_id = (int) request.getSession().getAttribute("user");
        String img[] = new String[5];
        product p = new product();


        //image handling
        int i = 0;
        Part filePart = request.getPart("thumbnail"); // Retrieves <input type="file" name="file">
        String thumbnail = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream thumbnailContent = filePart.getInputStream();
        img[i] = "C:/Users/Manan/Pictures/" + thumbnail;
        File target = new File(img[i]);
        Files.copy(thumbnailContent, target.toPath(), StandardCopyOption.REPLACE_EXISTING);

        List<Part> fileParts = request.getParts().stream().filter(part -> "images".equals(part.getName())).collect(Collectors.toList()); // Retrieves <input type="file" name="file" multiple="true">

        for (Part filePart1 : fileParts) {
            String fileName1 = Paths.get(filePart1.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            InputStream fileContent1 = filePart1.getInputStream();
            img[++ i] = DB.path + fileName1;
            File target1 = new File(img[i]);
            Files.copy(fileContent1, target1.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        p.lend(user_id, productName, category, description, location, img, rent, deposit, availFrom, availTill, late, policy);
        RequestDispatcher rd = request.getRequestDispatcher("successLend.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("404.jsp");
        rd.forward(request, response);
    }

    @Override
    public void destroy() {
        super.destroy();
    }

    @Override
    public void init() throws ServletException {
        super.init();

    }
}
