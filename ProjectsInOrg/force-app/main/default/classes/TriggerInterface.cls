public interface TriggerInterface {

     void beforeInsert(List<sObject> newTriggerList);
     void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap);

     void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap);
     void afterUpdate(Map<id, sObject> newTriigerMap, Map<id, sObject> oldTriggerMap);

     void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap);
     void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap);

     void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap);
}