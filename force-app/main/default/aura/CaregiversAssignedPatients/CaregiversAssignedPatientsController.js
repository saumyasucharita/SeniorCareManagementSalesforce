({
	doInit : function(component, event, helper) {
         var init_action = component.get("c.getContactId");
         init_action.setCallback(this, function(Response){
            var recordId =Response.getReturnValue();
            component.set("v.recordId", recordId);
            //component.set("v.recordId","003ak000005n24DAAQ");
            //console.log('The record id set is: '+component.get("v.recordId"));
            
             let action = component.get("c.getAssignedPatients");
             console.log('Caregiver Id'+component.get("v.recordId"));
             action.setParams({
                caregiverId: component.get("v.recordId")
             });
        
            action.setCallback(this, function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    console.log("Patients: "+response.getReturnValue());
                    component.set("v.patients", response.getReturnValue()); 
                    
                }
                                        
       		});
    		$A.enqueueAction(action);
        });
    	
        $A.enqueueAction(init_action);
		/*let action = component.get("c.getAssignedPatients");
        console.log('Caregiver Id'+component.get("v.recordId"));
        action.setParams({
            caregiverId: component.get("v.recordId")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("Patients: "+response.getReturnValue());
                component.set("v.patients", response.getReturnValue()); 
                
            }
                                        
       });
    $A.enqueueAction(action); */
	},
    onPatientSelect: function (component, event, helper) {
        var patient = event.getParam("patient");
        console.log('Patient selected: '+patient.Id);
        component.set("v.selectedPatientId", patient.Id);
    }
})