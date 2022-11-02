public without sharing class PublicHolidayCheckerCntrl {

    @AuraEnabled
    public static list<holidaysWrapper> getHolidays(string numberId){
        string year = string.valueOf(getDOB(numberId));
        calendarific_setting__mdt APIconfig = calendarific_setting__mdt.getInstance('Calendarific_Holidays');
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(APIconfig.Endpoint__c+'?&api_key='+APIconfig.API_Key__c+'&country='+APIconfig.Country__c+'&year='+year.substring(0, 4));
        req.setHeader('Content-Length', '0');
        req.setMethod('GET');
        req.setTimeout(12000);
        HttpResponse res = h.send(req);
        string jsonString = res.getBody();
        jsonString = jsonString.replace('"date"','"dates"');
        jsonString = jsonString.replace('"datetime"','"datestime"');
        
        PublicHolidayWrapper.Root wrapper = (PublicHolidayWrapper.Root)JSON.deserialize(jsonString, PublicHolidayWrapper.Root.class);
        list<PublicHolidayWrapper.Holiday> obj = wrapper.response.holidays;
        list<holidaysWrapper> holidayList = new list<holidaysWrapper>();
        for(PublicHolidayWrapper.Holiday hol : obj)
        {
            holidaysWrapper holidayVal = new holidaysWrapper();
            holidayVal.holidayName = hol.name;
            holidayVal.description = hol.description;
            holidayVal.holidayDate = hol.Dates.iso.substring(0,10);
            holidayList.add(holidayVal);
        }
        checkUser(numberId);
        return holidayList;
        
    }
    
    @AuraEnabled
    public static void checkUser(string numberId){
        long numbId = long.valueOf(numberId);
        Visitors__c[] visitors = [Select id,ID_Number__c,number_of_visits__c from Visitors__c where ID_Number__c =: numbId];
        
        if(visitors.size() > 0)
        {
            visitors[0].Number_of_Visits__c = visitors[0].Number_of_Visits__c + 1; 
            Update visitors;
        }
        else{
            visitors__c visitor = new visitors__c();
            visitor.ID_Number__c = numbId;
            visitor.Number_of_Visits__c = 1; 
            if(integer.valueOf(numberId.substring(6, 10)) > 4999 )
            {
                visitor.Gender__c = 'Male';
            }
            else{
                visitor.Gender__c = 'Female';
            }
            if(integer.valueOf(numberId.substring(10, 11)) == 1)
            {
                visitor.ZA_Citizen__c = true;
            }
            visitor.Date_Of_Birth__c = getDOB(numberId);
            Insert visitor;
        }  
 
    }
    
      public static Date getDOB(string numberId){
            string DOByear = '20'+ numberId.substring(0, 2);
            integer DOBmonth = integer.valueOf(numberId.substring(2, 4));
            integer DOBday = integer.valueOf(numberId.substring(4, 6));
            Date DOBDate = date.newInstance(integer.valueOf(DOByear), DOBmonth , DOBday);
          //  if(DOBDate < system.today() == true){
                return DOBDate;
            
          /*  else{
                DOByear = '19'+ numberId.substring(0, 2);
                DOBDate = date.newInstance(integer.valueOf(DOByear), DOBmonth , DOBday);
                return DOBDate;
            } */
        }
     	
    
    public class holidaysWrapper{
        @AuraEnabled
        public string holidayName  { get; set; }
        @AuraEnabled
        public string description  { get; set; }
        @AuraEnabled
        public string holidayDate  { get; set; }

        
    }
}