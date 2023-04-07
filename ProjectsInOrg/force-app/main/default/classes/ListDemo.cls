public class ListDemo {
    
    public List<Integer> obj_listDemo;
    public final integer MULTIPLIER = 2;
    public final integer RANDOM_NUMBER_HELPER_1 = 100;
    public final integer RANDOM_NUMBER_HELPER_2 = 200;
    
//Contructor to initialize the List with random positive & negative numbers
    public ListDemo(integer lSize)
    {
        obj_listDemo = new List<Integer>();
        for(integer i=0;i<lSize;i++)
        {
            integer rand_Numb = Integer.valueOf(math.random()*RANDOM_NUMBER_HELPER_1);
            if(rand_Numb>80)
                obj_listDemo.add(rand_Numb-RANDOM_NUMBER_HELPER_2);
            else
            	obj_listDemo.add(rand_Numb);
        }
    }
   
    // Find the biggest from the list
    public void findBiggest()
    {
        integer biggest = 0;
        for(integer x: obj_listDemo)
        {
            if(x>biggest)
                biggest = x;
        }
        system.debug('Biggest number from the list is: '+biggest);
    }
    
// Find the sum of odd & even numbers
    public void findSum_odd_Even()
    {
        Integer sum_Even=0, countEven=0;
        Integer sum_Odd=0, countOdd = 0;
        
        for(integer i:obj_listDemo)
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
    public void reversed_List()
    {
        List<Integer> newList = new List<Integer>();
        
        for(integer n=obj_listDemo.size()-1;n>=0;n--)
        {
            newList.add(obj_listDemo[n]);
        }
        
        System.debug('Reversed List-->'+newList);
    }
    
    public void findNegatives()
    {
      
        integer countNegtives=0;
        for(integer n:obj_listDemo)
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