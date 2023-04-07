public class DepartmentDIY {
    public String dept_ID;
    public String dept_Name;
    public String head_Quarters;
    public integer no_Of_Employees;
    List<Department__C> deptList = new List<Department__c>();   
    
    public void display(List<Department__C> department)
    {
        for(Department__C d : department)
            System.debug(d.Id+'---'+ d.Department_Name__c+'---'+d.Head_Quarters__c);
    }
    public void search(string dName)
    {
        deptList = [Select Department_Name__c FROM Department__C WHERE Department_Name__c = :dName ];
        display(deptList);
    }
    public void insertRecords(List<string> dNames)
    {   
        integer recordsInserted=0;
        deptList = [Select Department_Name__c FROM Department__C]; 
        List<String> names = new List<String>();
        
        for(integer i=0;i<deptList.size();i++)
            names.add(deptList.get(i).Department_Name__c);    
        
        List<Department__C> insertList = new List<Department__c>();        
        for(String name : dNames)
        {
            if(names.contains(name))
                System.debug('Record already exists with name '+name);
            else
            {
                Department__C d = new Department__C();
                d.Department_Name__c = name;
                insertList.add(d);
                recordsInserted+=1;
            }
        }
        if(insertList.size()>0)
        {
            System.debug(recordsInserted+' records are inserted');
            display(insertList);
            insert insertList;  
        }
        
    }
    public void updateRecords(String findInDepartment, String valueToBeUpdated)
    {
        integer recordsUpdated=0;
        String search = findInDepartment+'%';
        deptList = [Select Department_Name__c FROM Department__C WHERE Department_Name__c LIKE :search ];
        List<Department__C> updateList = new List<Department__c>();
        for(Department__c d : deptList)
        {
            d.Head_Quarters__c = valueToBeUpdated;
            updateList.add(d); 
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
    public void deleteRecords(string dName)
    {
        List<Department__C> deleteList = new List<Department__c>();
        deptList = [Select Department_Name__c FROM Department__C]; 
        integer recordsDeleted=0;
        for(Department__c d : deptList)
        {
            if(d.Department_Name__c == dName )     
            {
                deleteList.add(d);      
                recordsDeleted+=1;
            }
        }
        delete deleteList;
        if(recordsDeleted>0)        
            System.debug(recordsDeleted+' records are Deleted');            
        else
            System.debug('Match not found to delete records');        
    }
    public void minEmployees()
    {
        List<AggregateResult> count = [Select 
                                       Min(Employees__c) NoOfEmployees,Department_Name__c 
                                       FROM Department__C 
                                       Group By Department_Name__c];       
        count.sort();                     
        for(AggregateResult agr: count)
        {
            if(agr.get('NoOfEmployees')!=null)
                System.debug(agr.get('NoOfEmployees')+'---'+agr.get('Department_Name__c'));
            break;
        }        
    }
}