import com.sun.istack.internal.NotNull;

import java.security.MessageDigest;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class user {
    int userid;
    String firstName;
    String lastName;
    String userName;
    String email;
    String mobile;
    String facebook_auth;
    String google_auth;
    Timestamp firstCreated;
    Timestamp lastActive;
    String profilePic;
    Timestamp dateOfBirth;
    int numOfPost;
    String city;
    boolean verifiedUser;
    boolean TCverified;
    boolean emailVerified;
    boolean mobileVerified;

    @Override
    protected final void finalize() throws Throwable {
        super.finalize();
    }

    public user(@NotNull Connection connection, int user_id)        //from session id
    {
        fillDetails(connection, user_id);
    }

    static boolean validate(){
        //code for validation
        return  true;
    }
    public user(@NotNull Connection connection, String input, String password)  {    //for login purpose
        try{
        PreparedStatement preparedStatement = connection.prepareStatement("select user_id from users where (email_id = ? OR user_name = ? OR mobile_number = ?) and password = ?");
        preparedStatement.setString(1, input);
        preparedStatement.setString(2, input);
        preparedStatement.setString(3, input);
        preparedStatement.setString(4, hashpass(password));
        ResultSet resultSet = preparedStatement.executeQuery();
        if(resultSet.next()){
            this.userid = resultSet.getInt(1);
            fillDetails(connection, this.userid);
        }
        else {
            throw new IllegalArgumentException("Entered invalid credentials");
        }
        }
        catch(SQLException se){
            se.printStackTrace();
        }
    }
    void fillDetails(@NotNull Connection connection, int user_id){
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from users where user_id= ?");
            preparedStatement.setInt(1, user_id);
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
            this.dateOfBirth = resultSet.getTimestamp(15);
            this.numOfPost = resultSet.getInt(16);
            this.city = resultSet.getString(19);
            this.emailVerified = resultSet.getBoolean(12);
            this.mobileVerified = resultSet.getBoolean(11);
            this.verifiedUser = resultSet.getBoolean(21);
            this.TCverified = resultSet.getBoolean(20);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public user(@NotNull Connection connection, String firstName, String lastName, String userName, String email, String password, boolean TCverified)  //for signUp
    {
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT into users (first_name, last_name, user_name, email_id, password, TC_verified) VALUES (?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, userName);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, hashpass(password));
            preparedStatement.setBoolean(6, TCverified);
            preparedStatement.executeUpdate();
            preparedStatement = connection.prepareStatement("SELECT user_id from users where email_id = ?");
            preparedStatement.setString(1, email);
            preparedStatement.executeUpdate();
            if(!validate()){
                throw new IllegalArgumentException("Account already exists for this information");
            }
            fillDetails(connection, userid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getLastActive(int user_id,@NotNull Connection connection)
    {
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
            if(y>=1)
            {
                return ("Last Active: "+y+" year(s) ago");
            }
            else if(M>=1)
            {
                return ("Last Active: "+M+" month(s) ago");
            }
            else if(d>=1)
            {
                return ("Last Active: "+d+" month(s) ago");
            }
            else if(h>=1)
            {
                return ("Last Active: "+h+" hour(s) ago");
            }
            else if(m>=2)
            {
                return ("Last Active: "+m+" minutes ago");
            }
            else{
                return "Active";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getUnreadMessages(@NotNull Connection connection)
    {
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT distinct conversation_id from messages where recipient= ?");
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();   //set pointer to first row
            return resultSet.getInt(1);     //different conversations id for our recipient
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void deleteUser(@NotNull Connection connection)
    {
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

    public int getProfileCompletion()
    {
        int i=0;
        if (facebook_auth!=null) i++;
        if (google_auth!=null) i++;
        if (profilePic!=null) i++;
        if (mobileVerified) i++;
        if (emailVerified) i++;
        i*=20;
        return i;
    }

    public void deleteMessageThread(@NotNull Connection connection)
    {
        //to be added
    }

    private String hashpass(@NotNull String base) {
        try{
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch(Exception ex){
            throw new RuntimeException(ex);
        }
    }
    /*
    Add user on
    public void addUser()
    {

    }



    public void addUserFb()
    {
    }

    public void addUserGoogle()
    {
    }
     */
}
