({ 
	medicationsHelperMethod : function(component) {
        //console.log("In helper JS method");
		component.set("v.columns",[
            {label: "Medication Name", fieldName: 'linkid', type: 'url',  typeAttributes: {label: { fieldName: 'Medication_Name__c' }, target: '_blank'}},
            {label: "Dosage", fieldName: 'Dosage__c', type: 'String'},
            {label: "Intake Start Date", fieldName: 'Intake_Start_Date__c', type: 'Date'},
            {label: "Intake End Date", fieldName: 'Intake_End_Date__c', cellAttributes: { iconName: { fieldName: 'TrendIcon' }, iconLabel: { fieldName: 'IconLabel' }, class: { fieldName: 'endDateClass' },iconPosition: 'right'}, type: 'Date'},
            {label: "Instructions", fieldName: 'Specific_Instructions__c', type: 'String'},
        ]);
        var action = component.get("c.fetchCurrentMedications");
        action.setParams({
            patientId: component.get("v.recordId")
        });
        console.log("Patient Id passed in medications controller: "+component.get("v.recordId"));
        //https://salesforce.stackexchange.com/questions/358160/how-to-find-different-between-two-dates-in-aura-component
        //https://trailhead.salesforce.com/trailblazer-community/feed/0D54V00007T4F4JSAV
        action.setCallback(this, function(Response){
            var records =Response.getReturnValue();
            //console.log('Records: '+records);
                records.forEach(function(record){
                    record.linkid = '/'+record.Id;
            		console.log('End date'+record.Intake_End_Date__c);
                    //console.log('Today'+new Date());
            		var rightNow = new Date();
            		rightNow.setMinutes(new Date().getMinutes() - new Date().getTimezoneOffset());
            		//console.log('Date time of end date'+Date.parse(record.Intake_End_Date__c));
            		var endTime = Date.parse(record.Intake_End_Date__c);
            		var diff = endTime - rightNow;
            		//console.log('Time Diff'+diff);
          
            		var daysDiff = Math.ceil(diff / (1000 * 3600 * 24));
            		console.log('Days Diff'+daysDiff);
            		//Show custom label when Refill required is true and medication supply is ending in 7 days
            		if(record.Refill_required__c){
            			if (daysDiff <= 7 && daysDiff > 0) {
            			console.log('Refill soon yes');
                        record.TrendIcon = 'utility:down';
            			record.endDateClass = 'slds-text-color_error slds-text-title_bold';
            			record.IconLabel = 'Refill Soon!!!';
                        } else {
                            //console.log('Refill soon no');
                            /*record.TrendIcon = 'utility:down';
                            record.IconLabel = 'Refill late';
                            record.endDateClass = '';
                            console.log('Updated table');*/
                        }
            
            		}
                });
            component.set("v.currentMedications", records);
        });
        
        $A.enqueueAction(action);
        
        //Fetch Past medications
        var actionPast = component.get("c.fetchPastMedications");
        actionPast.setParams({
            patientId: component.get("v.recordId")
        });
        actionPast.setCallback(this, function(Response){
            var records =Response.getReturnValue();
            //console.log('Records: '+records);
                records.forEach(function(record){
                    record.linkid = '/'+record.Id;
            });
            component.set("v.pastMedications", records);
		});   
        
        $A.enqueueAction(actionPast);
   }    
              
})