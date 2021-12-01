public class ExampleDynamicApex {

    
    public void NonDynamic (Integer numToMake){
        
        List<Case> caseList = new List<case>();
        
        for(Integer i=0; i<numTomake; i++) {
            
            Case newCase = new Case();
            
            newCase.Origin = 'Web';
            integer status = 3;
            if(status == 1){
                newCase.status = 'New';
                caseList.add(newCase);
                status=2;
            } else if (status ==2) {
                newCase.status = 'Working';
                caseList.add(newCase);
                status = 3;
            } else if (status == 3) {
                newCase.status = 'Escalted';
                caseList.add(newCase);
                status=4;
            } else if (status == 4) {
                newCase.status = 'Closed';
                caseList.add(newCase);
                status=1;
            }
        }
        insert caseList;
    }
    
    
    public void dynamic(Integer num){
        
        List<Case> caseList = new List<Case>();
        
        Schema.DescribeFieldResult fieldResult = case.status.getdescribe();
        List<Schema.PicklistEntry> pickListValues = fieldResult.getPicklistValues();
        
        for(integer i = 0; i < num; i++){
            
            
            for(Schema.PicklistEntry value : picklistValues) {
                Case newCase = new Case();
            	newCase.status = value.getValue();
                newCase.Origin = 'Web';
                caseList.add(newCase);
            }
        }
        insert caseList;
        
    }
}