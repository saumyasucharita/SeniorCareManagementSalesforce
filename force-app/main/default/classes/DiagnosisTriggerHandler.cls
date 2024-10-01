public class DiagnosisTriggerHandler {
    public static void managePrimaryDiagnosis(List<Diagnosis__c> newDiags){
        for(Diagnosis__c newDiag: newDiags){
            List<Diagnosis__c> diags_to_update = new List<Diagnosis__c>();
            if(newDiag.Primary_diagnosis__c){
                List<Diagnosis__c> existingPrimaryDiagnoses =
                    [
                        Select Id From Diagnosis__c
                        Where Patient_Id__c = :newDiag.Patient_Id__c
                        AND Primary_diagnosis__c = true
                    ];
                for(Diagnosis__c diag:existingPrimaryDiagnoses){
                    diag.Primary_diagnosis__c = false;
                    diags_to_update.add(diag);
                }
                update diags_to_update;
            }
        }
    }
}