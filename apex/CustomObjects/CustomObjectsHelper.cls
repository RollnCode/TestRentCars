public class CustomObjectsHelper {

    public static void createObjectsAndFillData() {
        CustomObjectCreator creator = new CustomObjectCreator();
        List<CustomObjectCreator.CustomObject> customObjects = new List<CustomObjectCreator.CustomObject>();
        customObjects.add(new CustomObjectCreator.CustomObject('Quote', 'Quote', 'Quotes'));
        customObjects.add(new CustomObjectCreator.CustomObject('Quote_Line', 'Quote_Line', 'Quote_Lines'));
        List<CustomObjectCreator.CustomField> customFields = new List<CustomObjectCreator.CustomField>();
        customFields.add(new CustomObjectCreator.CustomField('Quote.Employees', 'numberofEmployees', 'Number'));
        customFields.add(new CustomObjectCreator.CustomField('Quote_Line.No_of_Lives', 'numberofLives', 'Number'));
        creator.createCustomObjects(customObjects);
        creator.createCustomFields(customFields);
    }
    
    public static void insertQuote(List<Integer> numbersOfEmployees) {
        for(Integer i = 0; i < numbersOfEmployees.size(); i++) {
            Quote__c quote = new Quote__c(numberOfEmployees__c = numbersOfEmployees[i]); 
            insert quote;
        }
    }
    
    public static void insertQuoteLine(List<Integer> numbersOfLives) {
        for(Integer i = 0; i < numbersOfLives.size(); i++) {
            Quote_Line__c quote_line = new Quote_Line__c(numberOfLives__c = numbersOfLives[i]); 
            insert quote_line;
        }
    }
    
    public static Integer getNumberOfEmployees() {
        List<AggregateResult> sum = [select Sum(numberofEmployees__c) from Quote__c];
        return Integer.valueOf(sum[0].get('expr0'));
    }
    
    public static Integer getNumberOfLives() {
		List<AggregateResult> sum = [select Sum(numberOfLives__c) from Quote_Line__c];
        return Integer.valueOf(sum[0].get('expr0'));
    }
    
    public static void getAllCars() {
        List<Car__c> carList = [select Car_Model__c, isRent__c, currentRenter__c from Car__c];
        System.Debug(carList);
    }
    
    public static void unRentAllCars() {
        List<Car__c> carList = [select Car_Model__c from Car__c];
        for(Integer i = 0; i < carList.size(); i++) {
            carList[i].isRent__c = false;
            carList[i].currentRenter__c = null;
            update carList[i];
        }
    }
    
    public static void setCurrentUser(String login) {
        List<User__c> users = [select email__c, isCurrentUser__c from User__c];
        User__c currentUser;
        for(User__c user: users) {
            if(user.email__c == login) {
                currentUser = user;
            } else {
                user.isCurrentUser__c = false;
                update user;
            }
        }
        if(currentUser != null) {
            currentUser.isCurrentUser__c = true;
            update currentUser;
        }
    }
    
    public static User__c getCurrentUser() {
        return [select email__c from User__c where isCurrentUser__c = :true limit 1].get(0);
    }
    
    public static void createAdmin() {
        insert new User__c(email__c = 'admin@gmail.com', password__c = 'testtest', isAdmin__c = true);
    }
}