public without sharing class PublicHolidayWrapper {

    // Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(myJsonResponse);
   public class Country
    {
        public string id { get; set; }
        public string name { get; set; }
    }
    public class Dates
    {
        public string iso { get; set; }
        public Datestime datestime { get; set; }
    }
    public class Datestime
    {
        public integer year { get; set; }
        public integer month { get; set; }
        public integer day { get; set; }
        public integer hour { get; set; }
        public integer minute { get; set; }
        public integer second { get; set; }
    }
    public class Holiday
    {
        public string name { get; set; }
        public string description { get; set; }
        public Country country { get; set; }
        public Dates dates { get; set; }
        public List<string> type { get; set; }
        public string urlid { get; set; }
        public string locations { get; set; }
        public string states { get; set; }
    }
    public class Timezone
    {
        public string offset { get; set; }
        public string zoneabb { get; set; }
        public integer zoneoffset { get; set; }
        public integer zonedst { get; set; }
        public integer zonetotaloffset { get; set; }
    }
    public class Meta
    {
        public integer code { get; set; }
    }
    public class Response
    {
        public List<Holiday> holidays { get; set; }
    	//public List<Map<object,object>> holidays { get; set; }
    }
    public class Root
    {
        public Meta meta { get; set; }
        public Response response { get; set; }
    }
    

    
}