trigger AccountTrigger on Account (before insert) {
    
    for(Account ac:trigger.new)
    {
        if(ac.rating == 'Hot')
        {
            ac.AnnualRevenue = 20000;
        }
    }

}