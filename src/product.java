import java.util.InvalidPropertiesFormatException;

public class product {
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
