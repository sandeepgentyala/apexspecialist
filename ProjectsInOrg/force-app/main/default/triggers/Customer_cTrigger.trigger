trigger Customer_cTrigger on Customer__c (before insert, after insert, before update, after update, 
before delete, after delete, after undelete) 
{
    TriggerDispatcher.run(new Customer_cTriggerHandler());
}