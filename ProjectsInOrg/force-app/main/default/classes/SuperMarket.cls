public class SuperMarket {
    public Map<String,ProductsDIY> products =  new Map<String, ProductsDIY>();
    public Decimal discounted_Bill=0.0, total_Bill=0.0;
    
    public void billing(Map<String, Integer> prdsPurchased)
    {    
        
        for(String prcode : prdsPurchased.keySet())
        {
            // Check if product is available and has sufficient stock
            if(products.containsKey(prcode)){
                if(products.get(prcode).stock>prdsPurchased.get(prcode))
                { 
                    returnBilling(prcode, prdsPurchased.get(prcode));                   
                }
                else{
                    // If not in stock, need to update the stock 
                    if(products.get(prcode) != null){
                        system.debug(prcode+' is currently not available. Please order them again once stock gets updated');
                    }
                }
            }
            else{
                system.debug(prcode+' is currently not available.');
            }
        }
        system.debug('Total Bill amount-->> '+discounted_Bill);
        system.debug('You have saved-->> '+(total_Bill-discounted_Bill));
    } 
    public string display(String prCode)
    {
        if(products.containsKey(prCode))
            return 'Product code: '+prCode+' Name -->'+products.get(prCode).pName ;
        else
            return 'Product '+prCode+' is not available';
    }
    public void updateStock(Integer stk_Quantity, String prcode)
    {
        // system.debug('Stock->'+stock);
        if(products.get(prcode) != null && products.get(prcode).stock<=0){
            products.get(prcode).stock = products.get(prcode).stock+stk_Quantity;
            system.debug('Your stock for product '+prcode+' is updated to '+stk_Quantity);
        }
        else
            system.debug(prcode+' is no more available with us.');
    }
    
    // helper method for calculating bill
    public void returnBilling(String p_Code, Integer purchasedQuantity)
    {
        total_Bill = total_Bill + (products.get(p_Code).price*purchasedQuantity);
        discounted_Bill = discounted_Bill + (total_Bill - total_Bill*(products.get(p_Code).discount/100));
        products.get(p_Code).stock = products.get(p_Code).stock - purchasedQuantity;
        system.debug(display(p_Code)+ ' - Purchase Quantity: '+ purchasedQuantity+' - Price : '+products.get(p_Code).price);
        
    }
    
    public void reOrderProducts()
    {
        for(ProductsDIY pr:products.values()){
            
            if(pr.stock<20){
                pr.stock = pr.stock + 20;
                system.debug('Stock for '+pr.pName+' is updated to '+pr.stock);
            }
            else
            {
               system.debug('Enough stock for product '+pr.pName+ ' is available ');  
            }
        }
    }
       /* if(products.containsKey(p_Code)){
            if(products.get(p_Code).stock<10){
                //   discounted_Bill = discounted_Bill + (total_Bill - total_Bill*(products.get(p_Code).discount/100));
                products.get(p_Code).stock = products.get(p_Code).stock + quantity;
                system.debug('Stock for '+p_Code+' has been updated to '+quantity);
            }
            else
                system.debug('Enough stock for product '+p_Code+ ' is available ');     
            // system.debug(display(p_Code)+ ' - Purchase Quantity: '+ quantity+' - Price : '+products.get(p_Code).price);
        }
        else
            system.debug('Product '+p_Code+' is not available with us');
        
    }*/
}