trigger ContactTrigger on Contact (before insert) {
    
    for(contact c : Trigger.New){
        c.Description = 'This is for Before Trigger';
        c.Salutation = 'Mr.';
    }

}