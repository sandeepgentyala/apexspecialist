public class StringTokenizerDIY {
    
    public void manipString(String str)
    {
       List<String> strList = str.split(' ');
       Set<String> strSet = new Set<String>();
        for(String st:strList)
        {
            if(strSet == null || !strSet.contains(st)){
            system.debug(st+' appears ('+str.countMatches(st)+') times');
              strSet.add(st);  
            }
        }
    }

}