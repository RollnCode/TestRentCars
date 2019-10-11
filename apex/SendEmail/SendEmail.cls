public class SendEmail {

	private static final String numberOfEmployeesAndLivesText = '<html><head>' +
        '<style>\n.highlight { background-color:#FFFF00;}\np {background-color:#FFFFFF;}\n</style></head><body>' +
        'Lorem ipsum lorel ipsum, lorel ipsum:<br>' +
		'<span class="highlight"><numberofEmployees></span> Employees and <span class="highlight"><numberofLives></span> Lives</body></html>';
    
    private static final String carRentText =
        '<html>' +
        '<head>' +
        '<style>' +
        '@import url("https://fonts.googleapis.com/css?family=Fjalla+One&display=swap");' +
        'body{font-family: "Open Sans", sans-serif; font-size: 16px;}'+
        '.highlight { background-color:#FFFF00;}\np {background-color:#FFFFFF;}' +
        '.congratulation { font-family: "Open Sans", sans-serif; font-weight: bold; color: green; }' +
        '</style>' +
        '</head>' +
        '<body>' +
        '<span class="congratulation">Congratulations!!!</span><br>' +
		'You have rent <span class="highlight"><carModel></span> for <span class="highlight"><cost></span>. Have a great ride</body></html>';
    
    public static void sendNumberOfEmployeesAndLives(List<String> toAddresses) {
         String finalText = numberOfEmployeesAndLivesText.replace('<numberofEmployees>', String.valueOf(CustomObjectsHelper.getNumberOfEmployees()))
            .replace('<numberofLives>', String.valueOf(CustomObjectsHelper.getNumberOfLives()));
        sendEmail(finalText, toAddresses);
    }
    
   	public static void sendRentCarMessage(Car__c car, List<String> toAddresses) {
        String finalText = carRentText.replace('<carModel>', car.Car_Make__c + car.Car_Model__c)
            .replace('<cost>', String.valueOf(car.List_Price__c) + car.Currency__c);
        sendEmail(finalText, toAddresses);
    }
		
	@future    
    private static void sendEmail(String text, List<String> toAddresses) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toaddresses = toAddresses;
        message.htmlbody = text;
        Messaging.sendEmail(new List<Messaging.Email>{message});
    }
}