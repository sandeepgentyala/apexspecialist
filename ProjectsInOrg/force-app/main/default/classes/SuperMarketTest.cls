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


static void runTest()
{
    SuperMarket sMarket = new SuperMarket();
    Map<String,Integer> billedItems = 
    new Map<String,Integer>();
		billedItems.put('PRD0010', 5);
		billedItems.put('PRD001', 15);
		billedItems.put('PRD004', 5);
		billedItems.put('PRD0060', 500);
    sMarket.billing(billedItems);

   // system.assertEquals();
}

}