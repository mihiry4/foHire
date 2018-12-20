package Objects;

import com.sun.istack.internal.NotNull;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Date;

public final class product {

    public int product_id;
    public int user_id;
    public String product_name;
    public String category;
    public String description;
    public String region;
    public String city;
    public int img;
    public double rating;
    public boolean favourite;
    int favourites;
    public int price;
    public int deposit;
    Date availFrom;
    Date availTill;
    boolean status;
    public String[] user_details;
    public LocalDate[][] Dates;
    public comment[] NU;
    public comment U;

    //ToDo: add about status
    public void lend(@NotNull Connection connection, int user_id, String product_name, String category, String description, String region, String city, String price, String deposit, String availFrom, String availTill) {
        try {
            product_id = 0;
            if (user_id != 0 && product_name != null && category != null && description != null && region != null && city != null && price != null && deposit != null && availFrom != null &&
                    !product_name.equals("") && !category.equals("") && !deposit.equals("") && !region.equals("") && !city.equals("") && !price.equals("") && !description.equals("") && !availFrom.equals("")) {
                int Category = 0;
                int Price = 0;
                int Deposit = 0;
                java.sql.Date AvailFrom = null;
                java.sql.Date AvailTill = null;
                try {
                    Category = Integer.parseInt(category);
                    Price = Integer.parseInt(price);
                    Deposit = Integer.parseInt(deposit);
//                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//                    LocalDate AF = LocalDate.parse(availFrom, formatter);
//                    AvailFrom = new java.sql.Date(Integer.parseInt(availFrom.substring(6, 10)), Integer.parseInt(availFrom.substring(3, 5)), Integer.parseInt(availFrom.substring(0, 2)));
//                    AvailTill = new java.sql.Date(Integer.parseInt(availTill.substring(6, 10)), Integer.parseInt(availTill.substring(3, 5)), Integer.parseInt(availTill.substring(0, 2)));
                    AvailFrom = java.sql.Date.valueOf(availFrom);
                    AvailTill = java.sql.Date.valueOf(availTill);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }

                PreparedStatement preparedStatement = connection.prepareStatement("insert into fohire.product (user_id, product_name, category, description, region, city, rating, favourites, featured, price, deposit, available_from, available_till, status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
                preparedStatement.setInt(1, user_id);
                preparedStatement.setString(2, product_name);
                preparedStatement.setInt(3, Category);
                preparedStatement.setString(4, description);
                preparedStatement.setString(5, region);
                preparedStatement.setString(6, city);
                preparedStatement.setDouble(7, 0);
                preparedStatement.setInt(8, 0);
                preparedStatement.setBoolean(9, false);
                preparedStatement.setInt(10, Price);
                preparedStatement.setInt(11, Deposit);
                preparedStatement.setDate(12, AvailFrom);
                preparedStatement.setDate(13, AvailTill);
                preparedStatement.setBoolean(14, true);
                preparedStatement.executeUpdate();
                ResultSet rs = preparedStatement.getGeneratedKeys();
                if (rs.next()) {
                    product_id = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void setImg(@NotNull Connection connection, int tot_img) {
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement("update fohire.product set total_image = ? where fohire.product.product_id = ?");
            preparedStatement.setInt(1, tot_img);
            preparedStatement.setInt(2, product_id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void getBookedDates(@NotNull Connection connection) {
        LocalDate[][] Dates = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select booked_from, booked_till from Booking where product_id = ? and booked_till < ? order by booked_till desc");
            preparedStatement.setInt(1, product_id);
            preparedStatement.setObject(2, LocalDate.now());
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.last();
            int row = resultSet.getRow();
            Dates = new LocalDate[row][2];
            resultSet.beforeFirst();
            for (int i = 0; i < Dates.length; i++) {
                resultSet.next();
                Dates[i][0] = resultSet.getObject(1, LocalDate.class);
                Dates[i][1] = resultSet.getObject(2, LocalDate.class);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        this.Dates = Dates;
    }

    public void getLender(@NotNull Connection connection) {
        String[] userDetails = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_name, first_name, last_name, profile_pic from fohire.users where user_id = ?");
            preparedStatement.setInt(1, user_id);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            userDetails = new String[4];
            userDetails[0] = rs.getString(1);
            userDetails[1] = rs.getString(2);
            userDetails[2] = rs.getString(3);
            userDetails[3] = rs.getString(4);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        this.user_details = userDetails;
    }

    public void fillDetails(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from fohire.product where product_id = ?");
            preparedStatement.setInt(1, product_id);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            user_id = rs.getInt("user_id");
            product_name = rs.getString("product_name");
            int cat = rs.getInt("category");
            description = rs.getString("description");
            region = rs.getString("region");
            city = rs.getString("city");
            img = rs.getInt("total_image");
            rating = rs.getDouble("rating");
            favourites = rs.getInt("favourites");
            price = rs.getInt("price");
            deposit = rs.getInt("deposit");
            availFrom = rs.getDate("available_from");
            availTill = rs.getDate("available_till");
            status = rs.getBoolean("status");
            switch (cat) {
                case 1:
                    category = "Books";
                    break;
                case 2:
                    category = "Blu-ray and console games";
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void getCommentsNU(@NotNull Connection connection, int user_id) {
        comment[] comments = new comment[0];
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select rating, review, timestamp, first_name, last_name, user_name from reviews natural join users where product_id = ? and user_id != ? and deleted = ?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setInt(1, this.product_id);
            preparedStatement.setInt(2, user_id);
            preparedStatement.setBoolean(3, false);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.last();
            int row = resultSet.getRow();
            comments = new comment[row];
            resultSet.beforeFirst();
            for (int i = 0; i < comments.length; i++) {
                resultSet.next();
                comments[i] = new comment(resultSet.getDouble(1), resultSet.getString(2), resultSet.getTimestamp(3), resultSet.getString(4), resultSet.getString(5), resultSet.getString(6));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        NU = comments;
    }

    public void getCommentU(@NotNull Connection connection, int user_id) {
        comment comment = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select rating, review, timestamp, first_name, last_name, user_name from reviews natural join users where product_id = ? and user_id = ? and deleted = ?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setInt(1, this.product_id);
            preparedStatement.setInt(2, user_id);
            preparedStatement.setBoolean(3, false);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                comment = new comment(resultSet.getDouble(1), resultSet.getString(2), resultSet.getTimestamp(3), resultSet.getString(4), resultSet.getString(5), resultSet.getString(6));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        U = comment;
    }
}
