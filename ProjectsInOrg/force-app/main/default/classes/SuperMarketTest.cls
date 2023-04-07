@isTest
public class SuperMarketTest {

@TestSetup
static void makeData(){

SuperMarket sMarket = new SuperMarket();
final integer NO_OF_PRODUCTS=10;
for(integer i=1;i<=NO_OF_PRODUCTS;i++)
{
    ProductsDIY prd = new ProductsDIY(
        'PRD00'+i,'PRDNAME'+i,(i+ i*0.1), 5+i, i*10 );
    
    sMarket.products.put('PRD00'+i, prd);
}
    
}

@isTest
static void runTest()
{
    SuperMarket sMarket = new SuperMarket();
    
    Map<String,Integer> billedItems = 
    new Map<String,Integer>();
		billedItems.put('PRD0010', 5);
		billedItems.put('PRD001', 15);
		billedItems.put('PRD004', 5);
		billedItems.put('PRD006', 5);
	sMarket.billing(billedItems);
    
   // system.assertEquals(132.00, sMarket.discounted_Bill, 'Error: Values did not match.');
    
  /*  Map<String,Integer> billedItems1 = 
    new Map<String,Integer>();
		billedItems1.put('PRD0010', 5);
     sMarket.billing(billedItems1);
    
    Map<String,Integer> billedItems2 = 
     new Map<String,Integer>();
		billedItems2.put('PRD00100', 50);
     sMarket.billing(billedItems2);
    
    Map<String,Integer> billedItems3 = 
     new Map<String,Integer>();
		billedItems3.put('PRD004', 25);
     sMarket.billing(billedItems3);*/
   
	//sMarket.display('PRD001200');
    sMarket.display('PRD0010');
    sMarket.reOrderProducts();
    
    sMarket.updateStock(25, 'PRD001');
   // system.assertEquals();
}

}