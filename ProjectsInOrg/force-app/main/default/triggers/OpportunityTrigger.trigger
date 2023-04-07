trigger OpportunityTrigger on Opportunity (after insert) {

    Set<id> accSet = new Set<id>();
    List<Opportunity> oppsListFromTrigr = trigger.newMap.values();
    for(ID oppID: trigger.newMap.keyset())
    {
    //   system.debug('-->'+ trigger.newMap.get(oppId).AccountId);
       accSet.add(trigger.newMap.get(oppId).AccountId);
    }

    Map<id,Account> oppAccountList = new Map<id,Account>([Select id, Highest_Opportunity__c (select amount from Opportunities) from 
                                    Account where ID in : accSet]);
    Decimal highAmount = 0.0;
    for(Id accID:oppAccountList.keyset())
    {
        for(Opportunity opp:oppAccountList.get(accID).Opportunities)
        {
            if(opp.amount>highAmount)
                highAmount = opp.amount;
        }

        if(highAmount != 0.0)
        {
            oppAccountList.get(accID).Highest_Opportunity__c = highAmount;
        }
    }

    update oppAccountList;

  /*  Set<Id> sId = new Set<Id>();
   // Set<Id> accountId = new Set<Id>();
	List<Account> updateAccount = new List<Account>();
    for(Opportunity opp : Trigger.new)
     {   sId.add(opp.AccountId);   } 
    List<AggregateResult> agr = [Select Max(Amount) maxAmount, AccountId
                              FROM Opportunity 
                               GROUP BY AccountId
                              Having AccountId = :sId];      
  /*  For(AggregateResult a : agr)
    {
        accountId.add((Id)a.get('AccountId'));         
    }*/    
 /*   Map<ID,Account> aList = new Map<id,Account>([Select Highest_Opportunity__c, Id
                           From Account 
                          WHERE Id in :sId]);   
    for(AggregateResult a1 : agr)
    {   
        alist.get((id)a1.get('AccountId'))
                .Highest_Opportunity__c = (Decimal)a1.get('maxAmount');
        updateAccount.add(alist.get((id)a1.get('AccountId')));
        
       /*for(Account acc : aList)
       {
           System.debug('Second forloop');
        	if((id)a1.get('AccountId') == acc.id )
            {
                System.debug(a1.get('maxAmount'));
                acc.HighValueOpportunity__c = (Decimal)a1.get('maxAmount');
            	updateAccount.add(acc);                
            }
       }*/
    /*} 
    System.debug(updateAccount.size());
    if(updateAccount.size()>0)
        update updateAccount;      */

        

}