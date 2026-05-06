trigger Set_Industry on Account (before insert , before update) {
    
    for (Account acc : Trigger.New){
        if(acc.Industry == 'Technology'){
            acc.Rating = 'Hot';
        }
    }
}