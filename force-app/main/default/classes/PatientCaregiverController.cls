public class PatientCaregiverController {
    @AuraEnabled
    public static List<Contact> getAssignedPatients(Id caregiverId){
        return [
            Select Id, Name, Profile_Pic__c
            FROM Contact
            Where Id IN (Select Patient_Id__c FROM Patient_Caregiver__c Where Caregiver_id__c = :caregiverId)
        ];
    }
	@AuraEnabled
    public static Patient_Caregiver__c getCaregivingDetails(Id patientId) {
        return [SELECT Id, Patient_Id__c, Caregiving_Start_Date__c, Primary_Caregiver__c, 
                       Relationship_with_patient__c, DiagnosisInfoAccess__c, MedicationInfoAccess__c, Patient_Id__r.Name
                FROM Patient_Caregiver__c
                WHERE Patient_Id__c = :patientId
                LIMIT 1];
    }
    @AuraEnabled
    public static Id getContactId() {
        Id contactId = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1].ContactId;
        System.debug('Contact Id in apex: '+contactId);
        return contactId;
    }
}