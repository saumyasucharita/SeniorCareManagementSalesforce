trigger ManagePrimaryDiagnosis on Diagnosis__c (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        DiagnosisTriggerHandler.managePrimaryDiagnosis(Trigger.New);
    }
}