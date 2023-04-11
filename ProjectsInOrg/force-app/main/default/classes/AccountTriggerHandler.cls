public with sharing class AccountTriggerHandler implements TriggerInterface{

    public void beforeInsert(List<sObject> newTriggerList)
    {
        for(Account ac:(List<Account>)newTriggerList)
        {
            if(ac.rating.equals('Hot'))
            {
            ac.AnnualRevenue = 20000;
            }
        }
    }
    public void beforeDelete(List<sObject> oldList, Map<id, sObject> oldMap)
    {
        for(Account ac:(List<Account>)oldList)
            {
                if(ac.ParentId != null)
                {
                    ac.adderror('You cannot delete this account since it has Parent account associated');
                }
                else {
                    ac.adderror('NoYou are not allowed to delete any account record');
                }
            }
    }

    public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){

        List<Contact> contList = new List<Contact>();
        for(Account ac: (List<Account>)newTriggerList)
        {
            if(ac.NumberofLocations__c != null || ac.NumberofLocations__c != 0)
            {
                for(integer i=0;i<ac.NumberofLocations__c;i++){
                Contact cont = new Contact();
                cont.Lastname= ac.name+ ' Contact--'+i;
                cont.AccountID = ac.id;
                contList.add(cont);
                }

            }
        }
    }

    public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
    public void afterUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}

    public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
    public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){}

}