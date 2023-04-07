public class EmployeeDIY {
    public String employeeId;
    public String eMail;
    public String employeempName;
    public String gender;
    public String position;
    public Decimal salary;
    public List<Department__c> deptList;
    public List<String> deptNames ;
    public List<Id> deptIds;
    public List<String> DEFAULT_GENDER_LIST = new List<String>{'M', 'F', 'Others'};
    List<Employee__C> eList = new List<Employee__c>();   
  
    public EmployeeDIY()
    {
        deptList = [Select Department_Name__c, Employees__c, Head_Quarters__c from Department__c ];
        for(Department__c dlist: deptList)
        {
            deptNames.add(dlist.Department_Name__c);
            deptIds.add(dlist.Id);
        }
    }
    
    public void search(string empName)
    {
        // Check if there any matching records exist
        eList = [Select Employee_Name__c FROM Employee__C WHERE Employee_Name__c = :empName ];
        
        if(eList != null){
            for(Employee__C e : eList)
                System.debug(e);
        }
        else{
            system.debug('Employee '+empName+' is not found in the system. Please try changing your search creteria');
        }
        
    }
    public void insertRecords(string empName, String position, Decimal Salary, String department)        
    {
        this.position = (position == null||position =='')? 'Other': position;
        if(position != 'Technical Lead' && salary >80000)
        {
            System.debug('Salary should not be greaterthan 80000 for position '+position);   
            this.position = position;
            this.salary = null;
        }
        else 
        {
            this.position = position;
            this.salary = salary;
        }
        
        eList = [Select Employee_Name__c FROM Employee__C WHERE Employee_Name__c = :empName];   
        if(eList != null && eList.size() != 0)
            System.debug('Record already exists with name '+empName);
        else
        {
            Employee__C emp = new Employee__C();
            emp.Employee_Name__c = empName;
            emp.Position__c = this.position;
            emp.Salary__c = this.salary;
            if(deptNames.contains(department)){
                emp.Department_Name__c = deptIds[deptNames.indexOf(department)];
            }
            System.debug('Record Inserted');
            insert emp;
        }    
    }
    public void updateRecords(String findInDepartment, Integer valueToBeUpdated, String email, String gendr)
    {
        integer recordsUpdated=0;
        String search = findInDepartment+'%';
        eList = [Select Employee_Name__c FROM Employee__C WHERE Employee_Name__c LIKE :search ];
        
        if(DEFAULT_GENDER_LIST.contains(gendr))
        {
            this.gender = gendr;
        }
        else
            this.gender = 'Others';
        List<Employee__C> updateList = new List<Employee__c>();
        for(Employee__c e : eList)
        {
            e.Salary__c = valueToBeUpdated;
         	e.Employee_email__c = email;
            e.Gender__c = gender;
            updateList.add(e); 
            recordsUpdated+=1;
        }
        update updateList;
        if(updateList.size()>0)
        {
            System.debug(recordsUpdated+' records are updated');
            display(updateList);
        }
        else
            System.debug('Match not found to update records');
    }
    public void deleteRecords(string empName)
    {
        List<Employee__C> deleteList = new List<Employee__c>();
        eList = [Select Employee_Name__c FROM Employee__C]; 
        integer recordsDeleted=0;
        for(Employee__c e : eList)
        {
            if(e.Employee_Name__c == empName )     
            {
                deleteList.add(e);      
                recordsDeleted+=1;
            }
        }
        delete deleteList;
        if(recordsDeleted>0)        
            System.debug(recordsDeleted+' records are Deleted');            
        else
            System.debug('There are no records to delete for employee name : '+empName);        
    }
    
    public void display(List<Employee__C> employee)
    {
        for(Employee__C e : employee)
        {
            System.debug('Id ---'+e.Id);
            System.debug('Employee Name ---'+e.Employee_Name__c);
            System.debug('Position ---'+e.Position__c);
            System.debug('Salary ---'+e.Salary__c);
            System.debug('---------------------------------------------');
        }
    }
    public void maxSalForPosition(String position)
    {
        AggregateResult agr = [Select 
                               Max(Salary__c) MaxSalary, Position__c 
                               FROM Employee__c 
                               Group By Position__C                             
                               Having Position__c = 'Software Engineer'];
        System.debug('Maximun salary for position '+ position+' is '+agr.get('MaxSalary'));
    }
    public void maxAndMinSalaries()
    {
        List<AggregateResult> salaries = [Select 
                                          Max(Salary__c) MaxSalary, Min(Salary__c) MinSalary ,Position__c 
                                          FROM Employee__c 
                                          Group By Position__C];        
        for(AggregateResult agr : salaries)
        {
            System.debug('Position-----'+agr.get('Position__c'));
            System.debug('Maximum Salary-----'+agr.get('MaxSalary'));
            System.debug('Minimum Salary-----'+agr.get('MinSalary')); 
            System.debug('------------------------------------------------');
        }       
    }    
    
}