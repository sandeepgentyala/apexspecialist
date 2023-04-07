trigger OpportunityTrigger on Opportunity (after insert) {

    Set<id> accSet = new Set<id>();

    for(ID oppID: trigger.newMap.keyset())
    {
       system.debug('-->'+ trigger.newMap.get(oppId).AccountId);
       accSet.add(trigger.newMap.get(oppId).AccountId);
    }

    List<Account> oppAccountList = [Select id, Highest_Opportunity__c from 
                                    Account where ID in : accSet];
        //for()

}