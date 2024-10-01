public class GetContactDetailsFromWhoId{
    public class Request{
        @InvocableVariable(required=true)
        public Id whoId;
    }

    public class Response{
        @InvocableVariable
        public String firstName;

        @InvocableVariable
        public String email;
    }

    @InvocableMethod(label='Get Contact Details' description='Retrieves Name and Email of Contact based on WhoId')
    public static List<Response> getContactDetails(List<Request> requests){
        List<Response> responses = new List<Response>();

        Set<Id> whoIds = new Set<Id>();
        for(Request req:requests){
            if(req.whoId != null){
                whoIds.add(req.whoId);
            }
        }

        if(!whoIds.isEmpty()){
            List<Contact> contacts = [
                Select Id, FirstName, Email
                From Contact
                Where Id IN:whoIds
            ];

            for(Contact con:contacts){
                Response res=new Response();
                res.firstName = con.FirstName;
                res.email = con.Email;
                responses.add(res);
            }
        }
        return responses;
    }
}