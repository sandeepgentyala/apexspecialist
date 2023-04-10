public with sharing class OpportunityTriggerHandler {

public static void run()
{
    Switch on Trigger.OperationType
    {
        When BEFORE_INSERT
        {
            runBeforeInsert();
        }
        When AFTER_INSERT
        {
            runAfterInsert();
        }
    }
}

private static void runBeforeInsert()
{
    system.debug('Inside Before Insert');
}

private static void runAfterInsert()
{
    Set<Id> sId = new Set<Id>();
   List<Opportunity> triggerOpp = (List<Opportunity>)Trigger.new;
	List<Account> updateAccount = new List<Account>();
    for(Opportunity opp : triggerOpp){
        sId.add(opp.AccountId);    
    }
   try {
    
   
    List<AggregateResult> agr = [Select Max(Amount) maxAmount, AccountId
                              FROM Opportunity WHERE ID in : Trigger.new
                               GROUP BY AccountId
                              Having AccountId = :sId];      
  
     
    for(AggregateResult a1 : agr)
    {   
        Account updateAcc = new Account();
        updateAcc.id = (ID)a1.get('AccountId');
        updateAcc.Highest_Opportunity__c = (Decimal)a1.get('maxAmount');
        updateAccount.add(updateAcc);
    }
    System.debug('Aggregate : '+ agr);
   
  
    System.debug(''+updateAccount.size());
    if(updateAccount.size()>0)
      {  update updateAccount;   }

}
catch(Exception e)
{
    system.debug('Exception: -->'+e.getMessage());
}
    }
}