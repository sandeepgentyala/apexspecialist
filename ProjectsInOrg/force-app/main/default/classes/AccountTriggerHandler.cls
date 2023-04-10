public with sharing class AccountTriggerHandler {

public static void run() {

    List<Account> accListFromTrigger = trigger.new;

    switch on Trigger.operationType {

        when BEFORE_INSERT {

            for(Account ac:accListFromTrigger)
            {
                if(ac.rating.equals('Hot'))
                {
                ac.AnnualRevenue = 20000;
                }
            }
        }
        when BEFORE_DELETE {
            for(Account ac:accListFromTrigger)
            {
                if(ac.ParentId != null)
                {
                    ac.adderror('You cannot delete this account since it has Parent account associated');
                }
            }
        }
        when else {
            system.debug('Else block');
            
        }
        }

    }
}