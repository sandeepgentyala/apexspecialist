public class ContactTriggerHandler implements TriggerInterface{

    public void beforeInsert(List<sObject> newTriggerList){}

    public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){
        Set<id> accIds = new Set<Id>();
        Set<id> contIds = newTriggerMap.keyset();
        List<Contact_Relationship__c> crList= new List<Contact_Relationship__c>();
        for(Contact ct: (List<Contact>)newTriggerMap.values())
        {
            if(ct.AccountID != null)
           {accIds.add(ct.AccountID);   }

           if(ct.Contact_Relationship__c)
           {
            Contact_Relationship__c cr = new Contact_Relationship__c();
            cr.Contact_Relationship__c = ct.id;
            crList.add(cr);

           }
        }

    if(crList.size()>0)
            {
                insert crList;
            }
      //  List<Account> accRecs = [Select id, name, (select id from Contacts) from Account 
      //                                                              where id in :accIDs];
        List<Account> updateAcc =  new List<Account>();
        
    List<AggregateResult> lstAgr = [Select count(id)  totalContacts, accountid 
                                        from Contact 
                                        where accountid in : accIds 
                                        group by Accountid];

        system.debug('lstAgr-->'+lstAgr);
            for(AggregateResult agr:lstAgr)
                {
                    Account acc = new Account();
                    acc.id = (ID)agr.get('accountid');
                    acc.Count_of_Contacts__c = (Decimal)agr.get('totalContacts');
                    updateAcc.add(acc);
                }

            if(updateAcc.size()>0)
                {
                    update updateAcc;
                }

            
     }

public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
public void afterUpdate(Map<id, sObject> newTriigerMap, Map<id, sObject> oldTriggerMap){}

public void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap)
    {
        Set<ID> ids = oldTriggerMap.keyset();
        //system.debug('IDS-->'+ids);
        List<Contact_Relationship__c> crList = [Select id from Contact_Relationship__c 
                                                where Contact_Relationship__c in :ids];
        system.debug(crList);
        
        if(crList.size()>0)
        {
            delete crList;
        }
    }
    //public void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}

public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap)
    {
       List<Contact_Relationship__c> crList = [Select id from Contact_Relationship__c 
                                                where Contact_Relationship__c in :newTriggerList 
                                                ALL ROWS];

       if(crList.size()>0)
        {
            undelete crList; 
        }
    }
    
}