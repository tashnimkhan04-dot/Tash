global class AsyncBatchApexAccountUpdate implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id,Name,Description FROM Account';
       
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
        for(Account a : scope)
        {
            a.Description = 'Updated by Batch Apex';
        }
        update scope;
    }
    global void finish(Database.BatchableContext BC) {
    }
    

}