public with sharing class Customer_ProjectTriggerHandler implements TriggerInterface {
    
    
    public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){
       List<Opportunity> oppList = new List<Opportunity>();
        for(ID id: newTriggerMap.keyset())
        {
            if(((Customer_Project__c)newTriggerMap.get(id)).Opportunity_Name__c != null && ((Customer_Project__c)newTriggerMap.get(id)).Status__c == 'Active')
            {
                Opportunity opp = new Opportunity();
                opp.id =((Customer_Project__c)newTriggerMap.get(id)).Opportunity_Name__c;
                opp.Active_Customer_Project__c = true;
                oppList.add(opp);
            }
        }

        if(oppList.size()>0)
        {
            update oppList;
        }
    }

    public void beforeInsert(List<sObject> newTriggerList){}
    public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
    public void afterUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){
        List<Opportunity> oppList = new List<Opportunity>();
        for(ID id: newTriggerMap.keyset())
        {
            if(((Customer_Project__c)newTriggerMap.get(id)).Opportunity_Name__c != null )
            {
                Opportunity opp = new Opportunity();
                opp.id =((Customer_Project__c)newTriggerMap.get(id)).Opportunity_Name__c;
               if (((Customer_Project__c)newTriggerMap.get(id)).Status__c == 'Active')
                {opp.Active_Customer_Project__c = true;}
                else {
                    opp.Active_Customer_Project__c = false; 
                }
                oppList.add(opp);
            }
        }

        if(oppList.size()>0)
        {
            update oppList;
        }
    }

    public void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
    public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}

    public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){}
}