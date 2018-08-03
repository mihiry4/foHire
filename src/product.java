import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;
import java.util.InvalidPropertiesFormatException;

public class product {

    int product_id;
    int user_id;
    String product_name;
    int category;
    String description;
    int Cancellation_policy;
    int late_charges;
    int region;
    String  image_1;
    String  image_2;
    String  image_3;
    String  image_4;
    double rating;
    int favorites;
    boolean featured;
    int price;
    int deposit;
    Time upload_time;
    int rent_duration;
    Date available_from;
    Date available_till;
    boolean status;



    @Override
    protected final void finalize() throws Throwable {
        super.finalize();
    }

    int user_id;
    public product(int user_id, String name, String description) throws InvalidPropertiesFormatException        //Lend constructor
    {
        this.user_id = user_id;


        if(!checkValid()){
            throw new InvalidPropertiesFormatException("Does not meet Lend specifications");    //print proper message
        }
    }

public product(){

        this.user_id=1;
}
    private boolean checkValid(){
        //check for valid object
        return false;
    }
    public product(int product_id)      //borrow constructor
    {

    }
}
