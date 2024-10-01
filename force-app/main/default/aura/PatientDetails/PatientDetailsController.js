({
	onPatientSelected : function(component, event, helper) {
        //console.log('In patient details component');
		let patient = event.getParam("patient");
        console.log('Patient received from application event: '+patient.Id);
        if(patient){
            component.set("v.showTabs", true);
            let action = component.get("c.getCaregivingDetails");
            component.set("v.patient", patient);
            
            action.setParams({ patientId: patient.Id });
            action.setCallback(this, function(response) {
                if (response.getState() === "SUCCESS") {
                    let caregivingDetails = response.getReturnValue();
                    component.set("v.caregivingDetails", caregivingDetails);
                    component.set("v.medicationsAccess", caregivingDetails.MedicationInfoAccess__c);
                    component.set("v.diagnosisAccess", caregivingDetails.DiagnosisInfoAccess__c);
                }
            });
            $A.enqueueAction(action); 
            
        }
        
	}
})