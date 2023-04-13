@isTest
public class SuperMarketTest {
    
//@TestSetup
/*static void makeData(){
    
    SuperMarket sMarket = new SuperMarket();
    
      system.debug(sMarket);  
}*/

@isTest
static void runTest()
{
    SuperMarket sMarket = new SuperMarket();
    
    final integer NO_OF_PRODUCTS=10;
        for(integer i=1;i<=NO_OF_PRODUCTS;i++)
            {
                ProductsDIY prd = new ProductsDIY(
                    'PRD00'+i,'PRDNAME'+i,(i+ i*0.1), 5+i, i*10 );
                
                sMarket.products.put('PRD00'+i, prd);
            }
    
    Map<String,Integer> billedItems = 
    new Map<String,Integer>();
		billedItems.put('PRD0010', 5);
		billedItems.put('PRD001', 50);
		billedItems.put('PRD004', 5);
		billedItems.put('PRD006', 5);
	sMarket.billing(billedItems);
     
	sMarket.display('PRD001200');
    sMarket.display('PRD0010');
    sMarket.reOrderProducts();
    
    sMarket.updateStock(25, 'PRD001');
     sMarket.updateStock(25, 'PRD00200');
   // system.assertEquals();
}

}