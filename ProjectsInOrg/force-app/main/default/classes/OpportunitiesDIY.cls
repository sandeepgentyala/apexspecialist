public class OpportunitiesDIY {
    
    public void displayAllOpps()
    {
      List<Opportunity> allOpps = [Select id, name from Opportunity];
       if(allOpps != null && allOpps.size()>0)  
       	 system.debug(allOpps);
    }
    public void displayOpps(integer n)
    {
        List<Opportunity> allOpps = [Select id, name from Opportunity
                                    Where amount > :n];
         if(allOpps != null && allOpps.size()>0)  
        	system.debug(allOpps);
    }
    
    public void count_Opps_per_Stage(String stage)
    {
        AggregateResult allOpps_per_Stage = [Select Count(id)total_Opps, stagename from Opportunity
                                    where stagename=: stage group by stagename];
        
            
        system.debug('Opportunities per Stage : '+allOpps_per_Stage.get('total_Opps')
                     +'-- Stage Name: '+allOpps_per_Stage.get('stagename'));
       
    }
    public void find_Opps_Stage_Source(String stage, String source)
    {
      //  String searchString = '%'+name+'%';
        List<Opportunity> allOpps_lik_Name = [Select id, name, stagename, leadsource from Opportunity
                                    where stagename =: stage AND leadsource = : source];
        for(Opportunity allOpps:allOpps_lik_Name){
            
        system.debug('Opportunity is : '+allOpps);
        }
    }

    public void find_Opps_like_Name(String name)
    {
        String searchString = '%'+name+'%';
        List<Opportunity> allOpps_lik_Name = [Select id, name, stagename from Opportunity
                                    where name like : searchString];
        for(Opportunity allOpps:allOpps_lik_Name){
            
        system.debug('Opportunity like:'+name+' are : '+allOpps);
        }
    }

    public void sum_OppsAmount_per_Stage(String stage)
    {
        AggregateResult allOpps_per_Stage = [Select sum(Amount)totalAmount, stagename from Opportunity
                                    where stagename=: stage group by stagename];
        
            
        system.debug('Total amount : '+allOpps_per_Stage.get('totalAmount')
                     +'-- Stage Name: '+allOpps_per_Stage.get('stagename'));
       
    }
}