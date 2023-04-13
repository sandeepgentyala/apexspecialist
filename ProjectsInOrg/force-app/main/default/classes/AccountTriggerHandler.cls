public with sharing class AccountTriggerHandler implements TriggerInterface{

    public void beforeInsert(List<sObject> newTriggerList)
    {
        for(Account ac:(List<Account>)newTriggerList)
        {
            if(ac.rating != null && ac.rating.equals('Hot'))
            {
            ac.AnnualRevenue = 20000;
            }
        }
    }
    public void beforeDelete(List<sObject> oldList, Map<id, sObject> oldMap)
    {
        List<Profile> p = [SELECT Name, Id FROM Profile where Name = 'System Administrator' limit 1];
        for(Account ac:(List<Account>)oldList)
            {
                if(ac.ParentId != null)
                {
                    ac.adderror('You cannot delete this account since it has Parent account associated');
                }
                else if(UserInfo.getProfileId() != p[0].Id)
                {
                    ac.adderror('You are not allowed to delete any account record');
                }
            }
    }

    public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){

        List<Contact> contList = new List<Contact>();
        for(Account ac: (List<Account>)newTriggerList)
        {
            if(ac.NumberofLocations__c != null && ac.NumberofLocations__c != 0)
            {
                system.debug('Inside if: '+ac.NumberofLocations__c);
                for(integer i=0;i<ac.NumberofLocations__c;i++){
                Contact cont = new Contact();
                cont.Lastname= ac.name+ ' Contact--'+i;
                cont.AccountID = ac.id;
                contList.add(cont);
                system.debug('Inside for');
                }

            }
        }
        try {
            system.debug('Contact List-->'+contList);
            if(contList.size()>0){
                insert contList;
            }
        } catch (Exception e) {
            system.debug('Exception-->'+e.getMessage());
            
        }
    }

   
    public void afterUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){

        Set<id> accIdsfromUpdate = newTriggerMap.keyset();
        List<Contact> contactsToUpdate = new List<Contact>();
        List<Contact> contactsToDelete = new List<Contact>();
        system.debug('--'+newTriggerMap+'--'+oldTriggerMap);
        //List<AggregateResult> acContAgr = [Select AccountId, count(id) TotalContacts from Contact 
        //                                    where AccountId in : accIdsfromUpdate group by AccountId];
        
        Map<id, Account> contactsFromAccount = new Map<id, Account>([Select id, name, (select id, AccountId from Contacts) from 
                                                                       Account where id in : accIdsfromUpdate]);
        system.debug('***'+contactsFromAccount);
       for(id accID : contactsFromAccount.keyset())
       {
        if(((Account)newTriggerMap.get(accID)).NumberofLocations__c >contactsFromAccount.get(accID).Contacts.size())
        {
            Integer diff = Integer.valueOf(((Account)newTriggerMap.get(accID)).NumberofLocations__c - contactsFromAccount.get(accID).Contacts.size());
            for(Integer i=0;i<diff;i++)
            {
                Contact nContToUpdate = new Contact();
                nContToUpdate.Lastname = ((Account)newTriggerMap.get(accID)).name + ' Update Contact--'+i;
                nContToUpdate.AccountId = accID;
               // nContToUpdate.id = 
                contactsToUpdate.add(nContToUpdate);
            }
        }
        else if(((Account)newTriggerMap.get(accID)).NumberofLocations__c < contactsFromAccount.get(accID).Contacts.size())
        {
            Integer diff =  Integer.valueOf(contactsFromAccount.get(accID).Contacts.size() - ((Account)newTriggerMap.get(accID)).NumberofLocations__c);
            system.debug('Diff in Delete->'+diff);
            for(integer i=diff;i>0;i--)
            {
                system.debug('Contacts to delete-->'+contactsFromAccount.get(accID).Contacts[i]);
                contactsToDelete.add(contactsFromAccount.get(accID).Contacts[i]);
            }
        }
       }
       system.debug('Update Recs-->'+contactsToUpdate+'/n Delete Recs-->'+contactsToDelete);
       if(contactsToUpdate.size()>0)
       {
        insert contactsToUpdate;
       }
       if(contactsToDelete.size()>0)
       {
        delete contactsToDelete;
       }
    }

    public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
    public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
    public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){}

}