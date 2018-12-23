package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UpdatePayment")
public class UpdatePayment extends HttpServlet {
    private Connection connection;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            respond(request, response);
        } catch (SQLException e) {
            connection = Objects.Const.openConnection();
            try {
                respond(request, response);
            } catch (SQLException x) {
                x.printStackTrace();
            }
        }
    }

    private void respond(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        int uid = (Integer) request.getSession().getAttribute("user");
        int type;
        try {
            type = Integer.parseInt(request.getParameter("type"));
            if (type > 3)
                throw new NumberFormatException();
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Incorrect payment type");
            return;
        }
        PreparedStatement preparedStatement;
        switch (type) {
            case 1:
                try {
                    String acc = request.getParameter("Account");
                    int Acc = Integer.parseInt(acc);
                    String IFSC = request.getParameter("IFSC");
                    if (IFSC == null || acc.isEmpty() || IFSC.isEmpty() || (acc.length() != 11 && acc.length() != 16) || IFSC.length() != 11) {
                        response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE, "Valid Account number and IFSC required");
                        return;
                    } else {
                        preparedStatement = connection.prepareStatement("UPDATE payment_options set Type = 1, Account_no = ?, IFSC = ? where user_id = ?");
                        preparedStatement.setInt(1, Acc);
                        preparedStatement.setString(2, IFSC);
                        preparedStatement.setInt(3, uid);
                        preparedStatement.executeUpdate();
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE, "Valid Account number and IFSC required");
                    return;
                }
                break;
            case 2:
                String UPI = request.getParameter("VPA");
                if (UPI == null || UPI.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE, "UPI ID is required");
                    return;
                } else {

                    preparedStatement = connection.prepareStatement("UPDATE payment_options set Type = 2, UPI = ? where user_id = ?");
                    preparedStatement.setString(1, UPI);
                    preparedStatement.setInt(2, uid);
                    preparedStatement.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK);

                }
                break;
            case 3:
                try {
                    String Wallet = request.getParameter("Paytm");
                    int wallet = Integer.parseInt(Wallet);
                    if (Wallet.isEmpty() || Wallet.length() != 10) {
                        response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE, "Paytm wallet number is required");
                        return;
                    } else {
                        preparedStatement = connection.prepareStatement("UPDATE payment_options set Type = 3, Paytm_Wallet= ? where user_id = ?");
                        preparedStatement.setInt(1, wallet);
                        preparedStatement.setInt(2, uid);
                        preparedStatement.executeUpdate();
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Incorrect mobile number format");
                    return;
                }
                break;
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
