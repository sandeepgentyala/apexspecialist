public class ListDemo {
    
    public List<Integer> objListDemo;
    public final integer MULTIPLIER = 2;
    public final integer RANDOM_NUMBER_HELPER_1 = 100;
    public final integer RANDOM_NUMBER_HELPER_2 = 200;
    
//Contructor to initialize the List with random positive & negative numbers
    public ListDemo(integer lSize)
    {
        objListDemo = new List<Integer>();
        for(integer i=0;i<lSize;i++)
        {
            integer randNumb = Integer.valueOf(math.random()*RANDOM_NUMBER_HELPER_1);
            if(randNumb>80)
                objListDemo.add(randNumb-RANDOM_NUMBER_HELPER_2);
            else
                objListDemo.add(randNumb);
        }
    }
   
    // Find the biggest from the list
    public void findBiggest()
    {
        objListDemo.sort();
        integer biggest  = objListDemo[objListDemo.size()-1];

       /* for(integer x: obj_listDemo)
        {
            if(x>biggest)
                biggest = x;
        }*/
        system.debug('Biggest number from the list is: '+biggest);
    }
    
// Find the sum of odd & even numbers
    public void findSumOddEven()
    {
        Integer sum_Even=0, countEven=0;
        Integer sum_Odd=0, countOdd = 0;
        
        for(integer i:objListDemo)
        {
            if(math.mod(i,MULTIPLIER)==0)
            {
                sum_Even = sum_Even + i;
                countEven++; // = countEven+1;
            }
            else
            {
                sum_Odd = sum_Odd + i;
            	countOdd++; //= countOdd+1;
            }
        }
        system.debug('Sum of '+countEven+' Even numbers is-->'+sum_Even);
        system.debug('Sum of '+countOdd+' Odd numbers is-->'+sum_Odd);
    }
    
    // reverse the items in the list using the generic for loop and access items using index
    public void reversedList()
    {
        List<Integer> newList = new List<Integer>();
        
        for(integer n=objListDemo.size()-1;n>=0;n--)
        {
            newList.add(objListDemo[n]);
        }
        
        System.debug('Reversed List-->'+newList);
    }
    
    public void findNegatives()
    {
      
        integer countNegtives=0;
        for(integer n:objListDemo)
        {
            if(n<0)
            {
                system.debug(n+' is a negative number');
                countNegtives++;
            }
        }
        
        System.debug('Number of negetive numbers in the List is-->'+countNegtives);
    }
}