global class RemoveCarRent implements Database.Batchable<Car__c> {
    
    private String id;
    
    public RemoveCarRent(String id) {
        this.id = id;
    }
    
    global Iterable<Car__c> start(Database.BatchableContext bc) {
        return [select Id, isRent__c, rentTimes__c, currentRenter__c from Car__c where Id = :id limit 1];
    }
    global void execute(Database.BatchableContext bc, List<Car__c> records){
        Car__c car = records.get(0);
        if(car.rentTimes__c == null) {
            car.rentTimes__c = 0;
        } else {
         	car.rentTimes__c++;   
        }
        car.isRent__c = false;
        car.currentRenter__c = null;
        update car;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}