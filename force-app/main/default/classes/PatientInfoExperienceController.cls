public class PatientInfoExperienceController {
	@AuraEnabled
    public static Id getContactId() {
        return [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()].ContactId;
    }
}