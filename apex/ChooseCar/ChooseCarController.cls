public class ChooseCarController {
    
    private final User__c currentUser;
    
    public final List<Car__c> cars { get; set; } 
    public final List<Car__c> currentUserCars { get; set; }
    
    public String login { get; set; }
    public String id { get; set; }
    
    public ChooseCarController() {
        currentUser = CustomObjectsHelper.getCurrentUser();
        
        cars = [select Car_make__c, Car_Model__c, Engine__c, Colour__c, List_Price__c, Currency__c, Id from Car__c where isRent__c = false];
        currentUserCars = [select Car_make__c, Car_Model__c, Engine__c, Colour__c, List_Price__c, Currency__c, Id from Car__c where isRent__c = true and currentRenter__c = :currentUser.email__c];
    }
    
    public PageReference rent() {
        Car__c car = getCarById(id);
        System.scheduleBatch(new RemoveCarRent(car.Id), 'Remove Car Rent' + system.now(), 1);
        update new Car__c(Id = id, isRent__c = true, currentRenter__c = currentUser.email__c);
        SendEmail.sendRentCarMessage(car, new List<String>{ currentUser.email__c });
        return null;
    }
    
    public PageReference signout() {
        CustomObjectsHelper.setCurrentUser(null);
        PageReference reference = new PageReference('/apex/LoginPage');

        return reference;
    }
    
    private Car__c getCarById(String id) {
        for(Car__c car : cars) {
            if(car.Id == id) {
                return car;
            }
        }
        return null;
    }
    
}