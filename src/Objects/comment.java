package Objects;

import java.sql.Timestamp;

public final class comment {
    public double rating;
    public String review;
    public Timestamp time;
    public String user_firstName;
    public String user_lastName;
    public String user_name;

    public comment(double rating, String review, Timestamp time, String user_firstName, String user_lastName, String user_name) {
        this.rating = rating;
        this.review = review;
        this.time = time;
        this.user_firstName = user_firstName;
        this.user_lastName = user_lastName;
        this.user_name = user_name;
    }
}
