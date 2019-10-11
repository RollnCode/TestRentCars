public class LoginController {
    
    public String login{ get; set; }
    public String password{ get; set; }
    
    public PageReference submitLogin() {
        List<User__c> users = [select email__c, isAdmin__c from User__c where email__c = :login];
        PageReference reference;
        if(users.size() == 0) {
            User__c user = new User__c(email__c = login, password__c = password);
            insert user;
        } else {
            User__c user = users.get(0);
            if(user.isAdmin__c) {
                reference = new PageReference('/apex/ReportPage');
            } else {
                CustomObjectsHelper.setCurrentUser(login);   
                reference = new PageReference('/apex/ChooseCarPage');
            }
        }
        return reference;
    }
    
    public static void getUsers() {
        List<User__c> users = [select email__c, password__c from User__c];
        System.Debug(users);
    }
    
}