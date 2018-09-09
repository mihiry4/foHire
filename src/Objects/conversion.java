package Objects;

import java.sql.Timestamp;

public class conversion {
    public String last_msg;
    public Timestamp time;
    public String name;
    public String email;
    public String profile_pic;

    public conversion(String last_msg, Timestamp time, String name, String email, String profile_pic) {
        this.last_msg = last_msg;
        this.time = time;
        this.name = name;
        this.email = email;
        this.profile_pic = profile_pic;
    }
}
