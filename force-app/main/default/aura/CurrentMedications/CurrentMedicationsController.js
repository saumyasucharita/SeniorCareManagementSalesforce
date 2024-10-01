({
	doInit : function(component, event, helper) {
        console.log('In Init of JS');
        var init_action = component.get("c.getContactId");
    	init_action.setCallback(this, function(Response){
        	var recordId =Response.getReturnValue();
            component.set("v.recordId", recordId);
            //component.set("v.recordId","003ak000005n24DAAQ");
            helper.medicationsHelperMethod(component);
        });
    	console.log('The record id set is: '+component.get("v.recordId"));
       $A.enqueueAction(init_action);
		
	}
})