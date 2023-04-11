public class TriggerDispatcher {
    
    public static void run(TriggerInterface handler) {
    
        // List<Account> accListFromTrigger = trigger.new;
     
         switch on Trigger.operationType {
     
             when BEFORE_INSERT {
     
                handler.beforeInsert(trigger.new);
                 
             }
             when AFTER_INSERT {
     
                handler.afterInsert(trigger.new, trigger.newMap);
                 
             }
             when BEFORE_UPDATE {
     
                handler.beforeUpdate(trigger.newMap, Trigger.oldMap);
                 
             }
             when AFTER_UPDATE {
     
                handler.afterUpdate(trigger.newMap, Trigger.oldMap);
                 
             }
             when BEFORE_DELETE {
     
                handler.beforeDelete(trigger.old, Trigger.oldMap);
                 
             }
             when AFTER_DELETE {
     
                handler.beforeDelete(trigger.old, Trigger.oldMap);
                 
             }

             when AFTER_UNDELETE {
     
                handler.afterUnDelete(trigger.new, Trigger.newMap);
                 
             }
             
        }
     }
}