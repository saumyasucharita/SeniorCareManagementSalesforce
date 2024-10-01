({
	doInit : function(component, event, helper) {
        var init_action = component.get("c.getContactId");
    	init_action.setCallback(this, function(Response){
        	var recordId =Response.getReturnValue();
            component.set("v.recordId", recordId);
            //component.set("v.recordId","003ak000005n24DAAQ");
            //console.log('The record id set is: '+component.get("v.recordId"));
            
            var action = component.get("c.fetchCurrentDiagnoses");
            action.setParams({
                patientId: component.get("v.recordId")
            });
            console.log("Patient Id passed in Diagnoses Controller: "+component.get("v.recordId"));
            
            action.setCallback(this, function(response){
                var diagnoses =response.getReturnValue();
                diagnoses.forEach(function(diagnosis){
                    //console.log('Diagnosed by : '+diagnosis.Diagnosed_by_Physician__r.FirstName);
                    if(diagnosis.Primary_diagnosis__c){
                        //List of icons: https://www.lightningdesignsystem.com/icons/
                        diagnosis.primaryDiagnosisIcon = 'custom:custom1';
                        diagnosis.primaryDiagnosisLabel = 'Primary Diagnosis';
                        diagnosis.primaryDiagnosisClass = 'slds-text-color_error slds-text-title_bold';
                    }
                });
                component.set("v.currentDiagnoses",diagnoses);
            });
            $A.enqueueAction(action);
        });
    	
        $A.enqueueAction(init_action);
	}
})