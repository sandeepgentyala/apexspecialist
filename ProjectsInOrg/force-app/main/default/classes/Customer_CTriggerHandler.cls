public class Customer_CTriggerHandler implements TriggerInterface
{
    public void beforeInsert(List<sObject> newTriggerList){


    }
    public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){

        List<AccountTeamMember> acTeamMemberList = new List<AccountTeamMember>();
        for(Customer__C cust: (List<Customer__C>)newTriggerMap.values())
        {
            acTeamMemberList.add(new AccountTeamMember(
            AccountId = cust.Account__c,
            UserId = cust.Account_Manager__c,
            TeamMemberRole = 'Account Manager'));
        }

        if(acTeamMemberList.size()>0)
        {
           insert acTeamMemberList;
        }
    }

    public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
    public void afterUpdate(Map<id, sObject> newTriigerMap, Map<id, sObject> oldTriggerMap){}

    public void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
    public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}

    public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){}
}