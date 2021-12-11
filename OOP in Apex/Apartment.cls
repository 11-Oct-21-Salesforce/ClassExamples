public class Apartment {
    public Decimal monthlyRent {
        get;
        set {
            if(value > 0) {
                this.monthlyRent = value;
            }
        }
    }
    
    public Decimal sqFootage {
        get;
        set {
            if(value > 0) {
                this.sqFootage = value;
            }
    	}
    }
    
    public Boolean hasBalcony{get;set;}
    
    public Decimal numberOfBathrooms{
        get;
        set {
            Decimal quotient = value / 0.5;
            if((value.intValue() == value) || (quotient.intValue() == quotient)) {
                this.numberOfBathrooms = value;
            }
        }
    }
    
    public Integer numberOfBedrooms{
        get;
        set {
            if(value < 0) {
                this.numberOfBedrooms = value;
            }
        }
    }
    
    public String apartmentNumber{get;set;}
    
    // Constructors serve to help us construct instances of classes.
    // By default all classes have a no argument constructor.
    // However, once we declare one of our own we lose that default constructor.
    // 
    // Constructors must be public, have no return type, and share their name with the class they belong to.
    public Apartment(Decimal monthlyRent, Decimal sqFootage, Decimal numberOfBathrooms, Integer numberOfBedrooms) {
        this(monthlyRent, sqFootage, numberOfBathrooms, numberOfBedrooms, false, '');
    }
    
    public Apartment(Decimal monthlyRent, Decimal sqFootage, Decimal numberOfBathrooms, Integer numberOfBedrooms, Boolean hasBalcony, String apartmentNumber) {
        this.monthlyRent = monthlyRent;
        this.sqFootage = sqFootage;
        this.numberOfBathrooms = numberOfBathrooms;
        this.numberOfBedrooms = numberOfBedrooms;
        this.hasBalcony = hasBalcony;
        this.apartmentNumber = apartmentNumber;
    }
}