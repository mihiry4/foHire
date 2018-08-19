package Objects;

import java.sql.Timestamp;

public class comment {
    public double rating;
    public String review;
    public Timestamp time;
    public String user_firstname;
    public String user_propic;

    public comment(double rating, String review, Timestamp time, String user_firstname, String user_propic) {
        this.rating = rating;
        this.review = review;
        this.time = time;
        this.user_firstname = user_firstname;
        this.user_propic = user_propic;
    }
}
