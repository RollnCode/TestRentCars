public class HandleReport {
    
    public final List<Car__c> cars { get; set; } 
    public final List<Car__c> rentCars { get; set; } 
    
    public HandleReport() {
        cars = [select Car_make__c, Car_Model__c, Engine__c, Colour__c, List_Price__c, Currency__c, rentTimes__c, currentRenter__c from Car__c where isRent__c = true order by rentTimes__c desc];
        rentCars = [select Car_make__c, Car_Model__c, Engine__c, Colour__c, List_Price__c, Currency__c, rentTimes__c, currentRenter__c from Car__c where rentTimes__c > 0 order by rentTimes__c desc];
    }
    
    public PageReference signout() {
        CustomObjectsHelper.setCurrentUser(null);
        PageReference reference = new PageReference('/apex/LoginPage');
        return reference;
    }
    
}