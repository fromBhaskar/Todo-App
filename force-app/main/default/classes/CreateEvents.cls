public with sharing class CreateEvents {
    public CreateEvents() {

    }

    public static void createEvents(Integer n ){
        List<Event> eventList = new List<Event>();
        for(Integer i = 0; i < n; i++) {
            Event e = new Event();
            e.WhoId = '0035g00001A5il1AAB';
            e.Subject = 'testfromapex '+i;
            e.OwnerId = '0055g00000K4OkG';
            e.StartDateTime = Datetime.now();
            e.EndDateTime  = Datetime.now();
            eventList.add(e);
    
        }

        if (!eventList.isEmpty()) {
            insert eventList;
        }

    }

    
}