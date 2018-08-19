package Objects;

import com.sun.istack.internal.NotNull;

import java.security.MessageDigest;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class user {
    public int userid;
    public String firstName;
    public String lastName;
    public String userName;
    public String email;
    String mobile;
    String facebook_auth;
    String google_auth;
    Timestamp firstCreated;
    Timestamp lastActive;
    String profilePic;
    int numOfPost;
    boolean verifiedUser;
    boolean TCverified;
    boolean emailVerified;
    boolean mobileVerified;

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

    public void login(@NotNull Connection connection, String input, String password) throws IllegalArgumentException {    //for login purpose
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where (email_id = ? OR user_name = ? OR mobile_number = ?) and password = ?");
            preparedStatement.setString(1, input);
            preparedStatement.setString(2, input);
            preparedStatement.setString(3, input);
            preparedStatement.setString(4, hashpass(password));
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                this.userid = resultSet.getInt(1);
            } else {
                throw new IllegalArgumentException("Entered invalid credentials");
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    void fillProduct(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT first_name, profile_pic from users where user_id= ?");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            this.firstName = resultSet.getString(1);
            this.profilePic = resultSet.getString(2);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    void fillDetails(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from users where user_id= ?");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();   //set pointer to first row

            this.firstName = resultSet.getString(2);
            this.lastName = resultSet.getString(3);
            this.userName = resultSet.getString(4);
            this.email = resultSet.getString(5);
            this.mobile = resultSet.getString(6);
            this.facebook_auth = resultSet.getString(8);
            this.google_auth = resultSet.getString(9);
            this.firstCreated = resultSet.getTimestamp(10);
            this.lastActive = resultSet.getTimestamp(13);
            this.profilePic = resultSet.getString(14);
            this.numOfPost = resultSet.getInt(15);
            this.emailVerified = resultSet.getBoolean(12);
            this.mobileVerified = resultSet.getBoolean(11);
            this.verifiedUser = resultSet.getBoolean(19);
            this.TCverified = resultSet.getBoolean(18);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void signup(@NotNull Connection connection, String firstName, String lastName, String userName, String email, String mobile, String password, boolean TCverified) throws IllegalArgumentException//for signUp
    {
        try {
            if (! validate(connection, email, userName, mobile)) {
                throw new IllegalArgumentException("Account already exists for this information");
            }
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, user_name, email_id, mobile_number, password, TC_verified) VALUES (?, ?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, userName);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, mobile);
            preparedStatement.setString(6, hashpass(password));
            preparedStatement.setBoolean(7, TCverified);
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

    public void googleLogin(@NotNull Connection connection, String firstName, String lastName, String email, String google_auth, boolean emailVerified, String profilePic) {  //for google login/signup
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where email_id = ?");
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                preparedStatement = connection.prepareStatement("update users set first_name= ? , last_name = ?, email_id = ?, google_auth = ?, email_verified = ?, profile_pic = ? where user_id = ?");
                preparedStatement.setInt(7, id);
            } else {
                preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, email_id, google_auth, email_verified, profile_pic) values (?, ?, ?, ?, ?, ?)");
            }
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, google_auth);
            preparedStatement.setBoolean(5, emailVerified);
            preparedStatement.setString(6, profilePic);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("SELECT user_id from users where email_id = ?");
            preparedStatement.setString(1, email);
            rs = preparedStatement.executeQuery();
            rs.next();
            this.userid = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getLastActive(int user_id, @NotNull Connection connection) {
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
    }

    public int getUnreadMessages(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT distinct conversation_id from messages where recipient= ?");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();   //set pointer to first row
            return resultSet.getInt(1);     //different conversations id for our recipient
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return - 1;
    }

    public void deleteUser(@NotNull Connection connection) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("insert into deleted_users select * from users where user_id=?");
            preparedStatement.setInt(1, userid);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("delete from users where user_id=?");
            preparedStatement.setInt(1, userid);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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

    public void deleteMessageThread(@NotNull Connection connection) {
        //to be added
    }

    private String hashpass(@NotNull String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

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
}
