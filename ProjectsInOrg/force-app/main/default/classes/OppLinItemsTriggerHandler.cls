public with sharing class OppLinItemsTriggerHandler implements TriggerInterface{

public void beforeInsert(List<sObject> newTriggerList){}
public void afterInsert(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap)
    {
        system.debug('afterInsert');
    oppLineItemChange(newTriggerMap);
    }

public void beforeUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap){}
public void afterUpdate(Map<id, sObject> newTriggerMap, Map<id, sObject> oldTriggerMap)
    {

    system.debug('afterUpdate');
    oppLineItemChange(newTriggerMap);

    }

public void beforeDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap)
    {
        system.debug('beforeDelete');
    oppLineItemChange(oldTriggerMap);
    }
public void afterDelete(List<sObject> oldTriggerList, Map<id, sObject> oldTriggerMap){}
public void afterUnDelete(List<sObject> newTriggerList, Map<id, sObject> newTriggerMap){}

public void oppLineItemChange(Map<id,sObject> newTriggerMap)
    {
    Set<ID> oppLinItems= new Set<id>();

    List<opportunity> listOpps = new List<opportunity>();
    Map<id,String> prodNames = new Map<id,String>();

    String Oppr_LineItems_Product_Code = '';

    for(id ids:newTriggerMap.keyset())
        {
            oppLinItems.add(((OpportunityLineItem)newTriggerMap.get(ids)).OpportunityId);
        }
    system.debug('--->'+oppLinItems);

try {
    
    List<OpportunityLineItem> oppLineItems =[SELECT Id, OpportunityId, Product2.Name 
                                                    FROM OpportunityLineItem 
                                                    where OpportunityId in :oppLinItems];
    system.debug('--->'+oppLineItems);

        for(OpportunityLineItem oppLineItem : oppLineItems)
            {
                //  system.debug(' --->'+ oppLineItem.Product2.name);
            /* if(prodNames.containsKey(oppLineItem.OpportunityId))
            {
                Oppr_LineItems_Product_Code = Oppr_LineItems_Product_Code+oppLineItem.Product2.Name+' , ';        
                prodNames.put(oppLineItem.OpportunityId, Oppr_LineItems_Product_Code);
                system.debug('Inside IF-->'+Oppr_LineItems_Product_Code);
            }
            else{        
                Oppr_LineItems_Product_Code = Oppr_LineItems_Product_Code + oppLineItem.Product2.Name+' , ';
                prodNames.put(oppLineItem.OpportunityId, Oppr_LineItems_Product_Code);
                system.debug('Inside ELSE-->'+Oppr_LineItems_Product_Code);
            }*/
            Oppr_LineItems_Product_Code = Oppr_LineItems_Product_Code+oppLineItem.Product2.Name+' , ';       
            prodNames.put(oppLineItem.OpportunityId, Oppr_LineItems_Product_Code);
            // system.debug('Inside for -->'+prodNames);

            }

} catch (Exception e) {

    system.debug('Error:-->'+e.getMessage());
    
        }


system.debug('====>'+prodNames);
if(prodNames.size()>0){
        for(id tempId:prodNames.keyset())
            {
                Opportunity opplnItm = new Opportunity();
                opplnItm.Id = tempId;
                opplnItm.Oppr_LineItems_Product_Code__c = prodNames.get(tempId)
                                                                .substring(0,prodNames.get(tempId).length() -1);
                listOpps.add(opplnItm);

            }
    }
else
    {
        for(id tempId:oppLinItems)
            {
                Opportunity opplnItm = new Opportunity();
                opplnItm.Id = tempId;
                opplnItm.Oppr_LineItems_Product_Code__c = '';
                listOpps.add(opplnItm);

            }
}

        system.debug('====>'+listOpps);
            if(listOpps.size()>0)
                {
                update listOpps;
                }
        }

}