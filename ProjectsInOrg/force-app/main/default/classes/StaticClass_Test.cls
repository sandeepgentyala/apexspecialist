public class StaticClass_Test {

    public static integer x=200;
    public static boolean isExecuted = false;
    
  /*  public StaticClass_Test()
    {
        this.x = 200;
    }*/
    
    public static void display(integer y){
       x=y;
        system.debug('X value is -> '+x+ 'Y value is -> '+y);
        if(isExecuted){
            system.debug('This method is executed already');
            isExecuted = false;
           system.debug('Inside If-->isExecuted: '+isExecuted); 
        }
        isExecuted = true;
    }
}