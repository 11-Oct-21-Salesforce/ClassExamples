public with sharing class asyncApex {
    
    /*
    @future
    public void ... ()


    Executing queable: 
    System.enqueueJob(new QueableClassName());

    

    */


    /*   --batchable example--

    public class BatchableDemo implements Database.Batchable<sObject> {
        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator('SELECT ClosedDate FROM Case WHERE Status = \'Closed\'');
        }
        
        public void execute(Database.BatchableContext bc, List<sObject> generics) {
            List<Case> cases = new List<Case>();
            for(sObject generic : generics) {
                Case caseRecord = (Case) generic;
                if(caseRecord.ClosedDate <= Date.today().addMonths(-6)) {
                    caseRecord.Ready_to_Archive__c = true;
                    cases.add(caseRecord);
                }
            }
            
            update cases;
        }
        
        public void finish(Database.BatchableContext bc){}
    }

                            Instance of class, batch size
    Database.executeBatch(BatchableDemo, 2000);



    public/global class ClassName implements Schedulable {

        public/global void execute(SchedulableContext sc){
            logic here to run at the set time
        }
    }

    System.schedule(nameOfJob, CRON expression, instanceOfSchedClass);

    seconds, minute, hour, dayOfMonth, month, dayOfWeek, (optional) year
    0-59      0-59    0-24     1-31      1-12    1-7         YYYY

    , -- chooose more than one month,day,year
    -  -- denotes a range
    * -- all
    ? -- No value specified, Used when dictating dayOfMonth<>dayOfWeek
    / -- specifies an increment
    L -- last day of period; either last day of month or last day of week (saturday)
    # -- specifies particular day of month when choosing day of week

    0 0 13 * * ? -- every day at 1 pm
    0 0 22 ? * 6L -- last friday every month at 10 pm
    0 0 20 * * ? 2010 -- runs every day at 8 pm during the year 2010


    CronTrigger and CronJobDetial objects
    CronJobDetail
     - JobType = 7 <-----its scheduled apex


     System.abortJob()

     Id cronTriggerId = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name='Mark Contacts for Archiving'].id;
     System.abortJob(cronTriggerId);

     AsyncApexJob class available to programatically interact with queued/scheduled jobs.
     

    */


}
