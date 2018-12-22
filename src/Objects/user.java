package Objects;

import com.sun.istack.internal.NotNull;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.*;

public final class user {
    public int userid;
    public String firstName;
    public String lastName;
    public String userName;
    public String email;
    public String mobile;
    public String facebook_auth;
    public String google_auth;
    Timestamp firstCreated;
    Timestamp lastActive;
    String profilePic;
    int numOfPost;
    boolean verifiedUser;
    boolean emailVerified;
    boolean mobileVerified;
    public boolean showMobile;
    public boolean showEmail;

    @Override
    protected final void finalize() throws Throwable {
        super.finalize();
    }

    private static boolean validate(@NotNull Connection connection, String email, String mobile, String userName) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where email_id = ? OR user_name = ? OR mobile_number = ?");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, userName);
            preparedStatement.setString(3, mobile);
            ResultSet rs = preparedStatement.executeQuery();
            return (! rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    /*public String getUserName(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_name from users where user_id = ?");
            preparedStatement.setInt(1, userid);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            return rs.getString(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }*/

    public static String hashpass(@NotNull String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();

            for (byte aHash : hash) {
                String hex = Integer.toHexString(0xff & aHash);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void fillDetails(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from users where user_id= ?");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();   //set pointer to first row

            this.firstName = resultSet.getString("first_name");
            this.lastName = resultSet.getString("last_name");
            this.userName = resultSet.getString("user_name");
            this.email = resultSet.getString("email_id");
            this.mobile = resultSet.getString("mobile_number");
            this.facebook_auth = resultSet.getString("facebook_auth");
            this.google_auth = resultSet.getString("google_auth");
            this.firstCreated = resultSet.getTimestamp("timestamp");
            this.lastActive = resultSet.getTimestamp("last_active");
            this.profilePic = resultSet.getString("profile_pic");
            this.numOfPost = resultSet.getInt("number_of_post");
            this.emailVerified = resultSet.getBoolean("email_verified");
            this.mobileVerified = resultSet.getBoolean("mobile_verified");
            this.verifiedUser = resultSet.getBoolean("verified_user");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void signup(@NotNull Connection connection, String firstName, String lastName, String userName, String email, String mobile, String password, boolean TCverified, String referral) throws IllegalArgumentException//for signUp
    {
        try {
            if (! validate(connection, email, userName, mobile)) {
                throw new IllegalArgumentException("Account already exists for this information");
            }
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where user_name = ?");
            ResultSet rsp = preparedStatement.executeQuery();
            if (! rsp.next()) {
                throw new ArithmeticException("promo code does not exist");
            } else {
                preparedStatement = connection.prepareStatement("update users set referral_amt = referral_amt+1 where user_name = ? and referral_amt<=5");
                preparedStatement.executeUpdate();
            }
            preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, user_name, email_id, mobile_number, password, TC_verified, referral_amt) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, userName);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, mobile);
            preparedStatement.setString(6, hashpass(password));
            preparedStatement.setBoolean(7, TCverified);
            preparedStatement.setInt(8, 1);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("SELECT user_id from users where email_id = ?");
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            this.userid = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void SocialLogin(@NotNull Connection connection, String firstName, String lastName, String email, String social_auth, boolean emailVerified, String profilePic, boolean google/*if signIn with google*/) {  //for google login/signup     //ToDo:to be improved and user_name to be checked
        try {
            String generatedUid;
            PreparedStatement preparedStatement;
            if (google) {preparedStatement = connection.prepareStatement("select user_id, google_auth from users where email_id = ?");}
            else {preparedStatement = connection.prepareStatement("select user_id, facebook_auth from users where email_id = ?");}
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                if (google){if(rs.getString("google_auth")==null) {
                    preparedStatement = connection.prepareStatement("update users set google_auth = ?, email_verified = ? where user_id = ?");
                    preparedStatement.setInt(3, id);
                    preparedStatement.setBoolean(2, emailVerified);
                    preparedStatement.setString(1, social_auth);
                    preparedStatement.executeUpdate();
                }}else{
                if(rs.getString("facebook_auth")==null) {
                    preparedStatement = connection.prepareStatement("update users set facebook_auth = ?, email_verified = ? where user_id = ?");
                    preparedStatement.setInt(3, id);
                    preparedStatement.setBoolean(2, emailVerified);
                    preparedStatement.setString(1, social_auth);
                    preparedStatement.executeUpdate();
                }}
                this.userid=id;
            } else {
                generatedUid = email.split("@")[0];
                preparedStatement = connection.prepareStatement("select user_id from users where user_name = ?");
                preparedStatement.setString(1, generatedUid);
                rs = preparedStatement.executeQuery();
                while (rs.next()) {
                    generatedUid = randomAlphaNumeric(10);
                    preparedStatement = connection.prepareStatement("select user_id from users where user_name = ?");
                    preparedStatement.setString(1, generatedUid);
                    rs = preparedStatement.executeQuery();
                }
                if (google){preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, email_id, google_auth, email_verified, profile_pic, user_name) values (?, ?, ?, ?, ?, ?, ?)");}
                else{preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, email_id, facebook_auth, email_verified, profile_pic, user_name) values (?, ?, ?, ?, ?, ?, ?)");}
                preparedStatement.setString(1, firstName);
                preparedStatement.setString(2, lastName);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, social_auth);
                preparedStatement.setBoolean(5, emailVerified);
                preparedStatement.setString(6, profilePic);
                preparedStatement.setString(7, generatedUid);
                preparedStatement.executeUpdate();
                preparedStatement = connection.prepareStatement("SELECT user_id from users where email_id = ?");
                preparedStatement.setString(1, email);
                rs = preparedStatement.executeQuery();
                rs.next();
                this.userid = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public product[] getFavProducts(@NotNull Connection connection) {
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("select product_id from fohire.favorites where favorites.user_id = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setInt(1, userid);
            ResultSet rs = preparedStatement.executeQuery();
            rs.last();
            int row = rs.getRow();
            rs.beforeFirst();
            product[] products = new product[row];
            for (int i = 0; i < products.length; i++) {
                products[i] = new product();
                rs.next();
                products[i].favourite = true;
                products[i].product_id = rs.getInt(1);
                products[i].fillDetails(connection);
            }
            return products;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return new product[0];
    }

    /*public String getLastActive(int user_id, @NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT last_active from users where user_id= ?");
            preparedStatement.setInt(1, user_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();   //set pointer to first row
            LocalDateTime then = resultSet.getTimestamp(13).toLocalDateTime();
            LocalDateTime now = LocalDateTime.now();
            long m = ChronoUnit.MINUTES.between(now, then);
            long h = ChronoUnit.HOURS.between(now, then);
            long d = ChronoUnit.DAYS.between(now, then);
            long M = ChronoUnit.MONTHS.between(now, then);
            long y = ChronoUnit.YEARS.between(now, then);
            //last active found. If more than 1 year then no need for months and days and all.
            if (y >= 1) {
                return ("Last Active: " + y + " year(s) ago");
            } else if (M >= 1) {
                return ("Last Active: " + M + " month(s) ago");
            } else if (d >= 1) {
                return ("Last Active: " + d + " month(s) ago");
            } else if (h >= 1) {
                return ("Last Active: " + h + " hour(s) ago");
            } else if (m >= 2) {
                return ("Last Active: " + m + " minutes ago");
            } else {
                return "Active";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }*/

    public int getProfileCompletion() {
        int i = 0;
        if (facebook_auth != null) i++;
        if (google_auth != null) i++;
        if (profilePic != null) i++;
        if (mobileVerified) i++;
        if (emailVerified) i++;
        i *= 20;
        return i;
    }

    public void login(@NotNull Connection connection, String input, String password) throws IllegalArgumentException {    //for login purpose
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where (email_id = ? OR user_name = ? OR mobile_number = ?) and password = ?");
            preparedStatement.setString(1, input);
            preparedStatement.setString(2, input);
            preparedStatement.setString(3, input);
            preparedStatement.setString(4, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                this.userid = resultSet.getInt(1);
                preparedStatement = connection.prepareStatement("update users set deactivated = 0 where user_id = ?");
                preparedStatement.setInt(1, this.userid);
                preparedStatement.executeUpdate();
            } else {
                throw new IllegalArgumentException("Entered invalid credentials");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    private static String randomAlphaNumeric(int count) {

        StringBuilder builder = new StringBuilder();

        while (count-- != 0) {

            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());

            builder.append(ALPHA_NUMERIC_STRING.charAt(character));

        }

        return builder.toString();

    }
}
