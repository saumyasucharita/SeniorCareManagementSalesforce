public class ICDCodeService {
    public static String getICDCode(String searchTerm){
        // Prepare the API URL
        String url = 'https://clinicaltables.nlm.nih.gov/api/icd10cm/v3/search?terms=' + EncodingUtil.urlEncode(searchTerm, 'UTF-8') + '&sf=code,name';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        
        // Send the request
        String icdCode = '';
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
           
            String responseBody = response.getBody();
            List<Object> responseList = (List<Object>) JSON.deserializeUntyped(responseBody);
            
            // Accessing the list of codes (at index 1)
            List<Object> icdCodes = (List<Object>) responseList[1];
            icdCode = (String)icdCodes[0];
            // Accessing the list of code-description pairs (at index 3)
            List<Object> icdDetailsRaw = (List<Object>) responseList[3];
            
            // Casting each element to a List<Object> manually
            for (Object detailRaw : icdDetailsRaw) {
                List<Object> detail = (List<Object>) detailRaw;
                String code = (String) detail[0];
                String description = (String) detail[1];
                System.debug('ICD Code: ' + code + ' - Description: ' + description); 
            }
          }
        return icdCode;
    }
}