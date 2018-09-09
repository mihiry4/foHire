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
            preparedStatement.setString(4, password);
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

    public message[] getMessages(@NotNull Connection connection) {
        message[] messages = null;
        try {
            /*PreparedStatement preparedStatement = connection.prepareStatement("SELECT message_id, content, sender, receiver, time, u.email_id as sender_email, CONCAT(u.first_name, \" \", u.last_name) as sender_name, u1.email_id as rec_email, CONCAT(u1.first_name, \" \", u1.last_name) as rec_name FROM `messages` JOIN `users` AS u JOIN `users` as u1 ON (u.user_id=sender AND u1.user_id=receiver) WHERE message_id in (SELECT MAX(message_id) FROM messages WHERE sender = ? or receiver = ? GROUP BY (sender+receiver), (ABS(sender-receiver))) ");
            preparedStatement.setInt(1,userid);
            ResultSet rs = preparedStatement.executeQuery();*/

        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }

    public conversion[] getConversions(@NotNull Connection connection) {
        conversion[] conversions = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT content, sender, receiver, time, u.email_id as sender_email, CONCAT(u.first_name, \" \", u.last_name) as sender_name, u.profile_pic as sender_pic, u1.email_id as rec_email, CONCAT(u1.first_name, \" \", u1.last_name) as rec_name, u1.profile_pic as receiver_pic FROM `messages` JOIN `users` AS u JOIN `users` as u1 ON (u.user_id=sender AND u1.user_id=receiver) WHERE message_id in (SELECT MAX(message_id) FROM messages WHERE sender = ? or receiver = ? GROUP BY (sender+receiver), (ABS(sender-receiver))) ");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.last();
            int row = resultSet.getRow();
            conversions = new conversion[row];
            resultSet.beforeFirst();
            for (int i = 0; i < conversions.length; i++) {
                resultSet.next();
                if (resultSet.getInt(2) == userid) {
                    conversions[i] = new conversion(resultSet.getString(1), resultSet.getTimestamp(4), resultSet.getString(9), resultSet.getString(8), resultSet.getString(10));
                } else {
                    conversions[i] = new conversion(resultSet.getString(1), resultSet.getTimestamp(4), resultSet.getString(6), resultSet.getString(5), resultSet.getString(7));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conversions;
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

    public void googleLogin(@NotNull Connection connection, String firstName, String lastName, String email, String google_auth, boolean emailVerified, String profilePic) {  //for google login/signup     //too be improved   //user_name to be checked
        try {
            String generatedUid;
            PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where email_id = ?");
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                preparedStatement = connection.prepareStatement("update users set first_name= ? , last_name = ?, email_id = ?, google_auth = ?, email_verified = ?, profile_pic = ? where user_id = ?");
                preparedStatement.setInt(7, id);
            } else {
                generatedUid = email.split("@")[0];
                preparedStatement = connection.prepareStatement("select user_id from users where user_name = ?");
                preparedStatement.setString(1, generatedUid);
                rs = preparedStatement.executeQuery();
                if (rs.next()) {
                    generatedUid = randomAlphaNumeric(10);

                }
                preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, email_id, google_auth, email_verified, profile_pic, referral, user_name) values (?, ?, ?, ?, ?, ?, ?, ?)");
            }
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, google_auth);
            preparedStatement.setBoolean(5, emailVerified);
            preparedStatement.setString(6, profilePic);
            preparedStatement.setString(7, randomAlphaNumeric(7));
            //preparedStatement.setString(8, generatedUid);
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

    public static String hashpass(@NotNull String base) {
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
