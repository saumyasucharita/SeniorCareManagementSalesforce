trigger UpdateDiagnosisEndDate on Medication__c (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            Medication_Diagnosis_Trigger_Handler.updateDiagnosisEndDate(Trigger.newMap, Trigger.oldMap);
        }
    }
}