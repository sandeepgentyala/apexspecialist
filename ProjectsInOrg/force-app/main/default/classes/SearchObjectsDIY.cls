public class SearchObjectsDIY {
    
    public static List<sObject> searchRecs(String objectS, List<String> fields)
    {
        String qry = buildPreciseQuery(objectS, fields,  null,  null,  null);
        return  Database.query(qry);
    }
    
    public static List<sObject> searchRecs(String objectS, List<String> obfields, String searchField, String oprtr, String value)
    {
      //  String fields_String = buildQuery(objectS, obfields, null, null, null);
                
       String fields_String = buildPreciseQuery(objectS, obfields,  searchField,  oprtr,  value);
          
        system.debug('Query-->'+fields_String);
      
         return Database.query(fields_String);
      // return null;
    }
    
    public static string buildPreciseQuery(String objectS, List<String> fields, String searchField, String oprtr, String value)
    {
         String fields_String = '';
        for(String fld: fields)
        {
            fields_String = fields_String+fld+',';
        }
        fields_String = 'select '+fields_String.substring(0,fields_String.length()-1)+' from '+objectS;
        
        if(searchField != null || searchField != ''){
        Map<String, Schema.sObjectType> sobjType= Schema.getGlobalDescribe();        
        Schema.SObjectType sobj = sobjType.get(objectS);
        Map<String, Schema.SObjectField> objFields = sobj.getDescribe().fields.getMap();
        Schema.SOAPType dType=objFields.get(searchField).getDescribe().getsoaptype();
        
        String dataType = String.valueof(dType); 
               
        Switch on dataType{
           
            When 'STRING'{
                value = '\''+value+'\'';
            }
            When else{
                value = value;
            }
        }  
            fields_String = fields_String + ' where ' +searchField+oprtr+value;
        }
          return fields_String;
     
    }
}