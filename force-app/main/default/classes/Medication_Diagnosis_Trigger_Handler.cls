public class Medication_Diagnosis_Trigger_Handler {
    public static void updateDiagnosisEndDate(Map<Id, Medication__c> newMeds, Map<Id, Medication__c> oldMeds){
        List<Diagnosis__c> diagsToUpdate = new List<Diagnosis__c>();
        
        for(Medication__c newMed:newMeds.values()){
            if(newMed.Diagnosis__c != NULL){
                if(!newMed.Refill_required__c && oldMeds.get(newMed.Id).Refill_required__c){
                //System.debug('Refill is now not required');
                Diagnosis__c diag = [Select Id, Name, End_date__c From Diagnosis__c Where Id = :newMed.Diagnosis__c];
                System.debug('Diagnosis Name'+diag.Name);
                diag.End_date__c = Date.today();
                System.debug('End date updated to: '+Date.today());
                diagsToUpdate.add(diag);
            }
          }   
        }
        if(!diagsToUpdate.isEmpty()){
            update diagsToUpdate;
        }
    }

}