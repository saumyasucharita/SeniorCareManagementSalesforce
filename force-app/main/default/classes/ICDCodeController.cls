//Example: https://help.salesforce.com/s/articleView?id=000385214&type=1
public class ICDCodeController {
    public String diagnosisCode {get; set; }
    public Diagnosis__c diagnosisRecord {get; set; }
    
    public ICDCodeController(ApexPages.StandardController controller){
        this.diagnosisRecord = (Diagnosis__c) controller.getRecord();
    }
    public PageReference getICDCode() {
        System.debug('In VF Page controller');
        String diagnosisName = diagnosisRecord.Name;

        // Call ICD API logic
        diagnosisCode = ICDCodeService.getICDCode(diagnosisName);
		System.debug('The ICD for '+diagnosisName+' is '+diagnosisCode);
        // Update the Diagnosis record with the ICD Code
        diagnosisRecord.Diagnosis_Code__c = diagnosisCode;
        update diagnosisRecord;

        // Redirect back to the record page
        PageReference pageRef = new PageReference('/' + diagnosisRecord.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}