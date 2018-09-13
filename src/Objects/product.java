package Objects;

import com.sun.istack.internal.NotNull;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;

public final class product {


    @Override
    protected final void finalize() throws Throwable {
        super.finalize();
    }

    public int product_id;
    int user_id;
    public String product_name;
    public String category;
    public String description;
    public String region;
    public String city;
    public String[] img;
    public double rating;
    int favourites;
    public int price;
    public int deposit;
    public int late;
    public int policy;
    Date availFrom;
    Date availTill;
    boolean status;

    public void lend(int user_id, String product_name, String category, String description, String region, String img[], String price, String deposit, String availFrom, String availTill, String late, String policy) {
        //to be added

    }

    public void fillDetails(@NotNull Connection connection) {

    }

    public comment[] getComments(@NotNull Connection connection) {
        comment[] comments = null;
        /*try {
            PreparedStatement preparedStatement = connection.prepareStatement("select (rating, review, timestamp, first_name, profile_pic, user_id) from reviews natural join users where product_id = ?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setInt(1, this.product_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.last();
            int row = resultSet.getRow();
            comments = new comment[row];
            resultSet.beforeFirst();
            for (int i=0; i<comments.length; i++) {
                resultSet.next();
                comments[i] = new comment( resultSet.getDouble(1), resultSet.getString(2), resultSet.getTimestamp(3), resultSet.getString(4), resultSet.getString(5), resultSet.getInt(6));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }*/
        comments = new comment[1];
        comments[0] = new comment(4.3, "dgkfxg Good product", new Timestamp(System.currentTimeMillis()), "manan", "assets/img/user-photo4.jpg", 1);
        return comments;
    }

    public product() {

        this.user_id = 1;
        this.description = "";
    }

    private boolean checkValid() {
        //check for valid object
        return false;
    }

    public product(int product_id)      //borrow constructor
    {

    }
}
