({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContactDetails");
        
        action.setCallback(this, function(Response) {
                var contact = Response.getReturnValue();
            	console.log('Contact returned'+contact);
                component.set("v.contact", contact);
        });
        
        $A.enqueueAction(action);
    }
})