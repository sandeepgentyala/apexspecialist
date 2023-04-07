trigger OpportunityTrigger on Opportunity (after insert) {
    
    Set<id> accSet = new Set<id>();
    List<Account> accUpdateList = new List<Account>();
    List<Opportunity> oppsListFromTrigr = trigger.newMap.values();
    for(ID oppID: trigger.newMap.keyset())
    {
     //  system.debug('-->'+ trigger.newMap.get(oppId).AccountId);
       accSet.add(trigger.newMap.get(oppId).AccountId);
    }
    
   Decimal highAmount = 0.0;

    Map<ID, Account> oppAccountList = new Map<ID,Account>([Select ID, Highest_Opportunity__c , 
                                                           (select Amount from Opportunities) from Account Where ID in : accSet]);

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
        else{
            oppAccountList.get(accID).Highest_Opportunity__c = highAmount;
        }
            
        accUpdateList.add( oppAccountList.get(accID));
    }

    update accUpdateList; 

  /*
    Set<Id> sId = new Set<Id>();
   // Set<Id> accountId = new Set<Id>();
	List<Account> updateAccount = new List<Account>();
    for(Opportunity opp : Trigger.new)
        sId.add(opp.AccountId);    
    List<AggregateResult> agr = [Select Max(Amount) maxAmount, AccountId
                              FROM Opportunity 
                               GROUP BY AccountId
                              Having AccountId = :sId];      
  /*  For(AggregateResult a : agr)
    {
        accountId.add((Id)a.get('AccountId'));         
    } */  

    /*
    Map<ID,Account> aList = new Map<id,Account>([Select Highest_Opportunity__c, Id
                           From Account 
                          WHERE Id in :sId]);   
    for(AggregateResult a1 : agr)
    {   
        alist.get((id)a1.get('AccountId'))
                .Highest_Opportunity__c = (Decimal)a1.get('maxAmount');
        updateAccount.add(alist.get((id)a1.get('AccountId')));
        
       for(Account acc : aList.values())
       {
          // System.debug('Second forloop');
        	if((id)a1.get('AccountId') == acc.id )
            {
                System.debug(a1.get('maxAmount'));
                acc.Highest_Opportunity__c = (Decimal)a1.get('maxAmount');
            	updateAccount.add(acc);                
            }
       }
   } 
    System.debug(updateAccount.size());
    if(updateAccount.size()>0)
        update updateAccount;   */
    
  
}