public class PatientAgeExpController {
	@AuraEnabled
    public static Contact getContactDetails() {
        // Get the ContactId of the logged-in user
        Id contactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1].ContactId;

        // Fetch the Contact record with Age and Caregiver_for_Patient__c fields
        Contact con = [SELECT Id, Name, Age__c, Caregiver_for_Patient__c FROM Contact WHERE Id = :contactId LIMIT 1];
        System.debug('Contact Age: '+con.Age__c);
        return con;
    }

}