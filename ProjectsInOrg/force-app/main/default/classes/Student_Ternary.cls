public class Student_Ternary {
    
    private integer x;
    private integer y;
    private integer z;
    
    public Student_Ternary(Integer a, integer b, integer c){
        this.x = a;
        this.y = b;
        this.z = c;
    }
    
    public void result()
    {
        String str = (x>50 && y>50 && z>50)?'Pass':'Fail';
        system.debug('Your result is '+str);
        
        Integer d = (x+y+z)/3;
        if(str.equalsIgnoreCase('Pass'))
        {
            if( d>=90) 
                system.debug('Your grade is : '+ 'S');
            
            else if (d>=80 && d<90)      
                system.debug('Your grade is : '+ 'A');
            
            else if (d>=70 && d<80)       
                system.debug('Your grade is : '+ 'B');
            
            else       
                system.debug('Your grade is : '+ 'C');
        }
        else
            system.debug('Sorry.!! You Fail the exam');
        
    }
}