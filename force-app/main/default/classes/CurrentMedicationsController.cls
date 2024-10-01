public class CurrentMedicationsController {
	@AuraEnabled
    public static List<Medication__c> fetchCurrentMedications(Id patientId){
       // System.debug('In Apex controller');
        System.debug('Patient Id: '+patientId);
        List<Medication__c> meds = [
            Select Id, Medication_Name__c, Dosage__c, Intake_Start_Date__c, Intake_End_Date__c, Refill_required__c, Specific_Instructions__c
            From Medication__c
            Where Active__c = true and Patient_Id__c = :patientId
        ];
        return meds;
    }
    @AuraEnabled
    public static List<Medication__c> fetchPastMedications(Id patientId){
        //System.debug('Patient Id: '+patientId);
        List<Medication__c> pastMeds = [
            Select Id, Medication_Name__c, Dosage__c, Intake_Start_Date__c, Intake_End_Date__c, Refill_required__c, Specific_Instructions__c
            From Medication__c
            Where Active__c = false and Patient_Id__c = :patientId
        ];
        return pastMeds;
    }
    @AuraEnabled
    public static Id getContactId() {
        Id contactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1].ContactId;
        System.debug('User Id passed from experience site: '+UserInfo.getUserId());
        System.debug('Contact Id in apex: '+contactId);
        return [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1].ContactId;
    }
}