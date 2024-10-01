public class CurrentDiagnosesController {
	@AuraEnabled
    public static List<Diagnosis__c> fetchCurrentDiagnoses(Id patientId){
        System.debug('Patient Id in CurrentDiagnosesController Apex: '+patientId);
        List<Diagnosis__c> diags=[
            Select Id, Name, Effective_Date__c , Primary_diagnosis__c, Diagnosed_by_Physician__r.Name
            From Diagnosis__c
            Where Patient_Id__c = :patientId
        ];
        for(Diagnosis__c diag:diags){
            //System.debug('First'+diag.Diagnosed_by_Physician__r.FirstName);
            System.debug('Diagnosis Name'+diag.Name);
            System.debug('Diagnosed by Physician'+diag.Diagnosed_by_Physician__r.Name);
        } 
        return diags;
    }
    @AuraEnabled
    public static Id getContactId() {
        return [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1].ContactId;
    }
}