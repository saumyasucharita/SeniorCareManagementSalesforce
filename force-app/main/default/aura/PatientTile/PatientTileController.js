({
	onPatientClick : function(component, event, helper) {
		var patient = component.get("v.patient");
        
        //component event
        var patientSelect = component.getEvent("PatientSelect");
        patientSelect.setParams({
            patient: patient
        });
        patientSelect.fire();
        console.log('Component event fired with patient', patient);
        
        //application event
        var patientSelected = $A.get("e.c:SelectedPatient");
        patientSelected.setParams({
            patient: patient
        });
        patientSelected.fire();
        console.log('Application event fired with patient', patient);
	}
})