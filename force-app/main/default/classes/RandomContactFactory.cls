public with sharing class RandomContactFactory {
    public RandomContactFactory() {

    }

    public static List<Contact> generateRandomContacts(Integer n, String lastName){

        List<Contact> conList = new List<Contact>();
        
        for (Integer i = 0; i < n; i++) {
            Contact con = new Contact(LastName = lastName, FirstName = 'Test '+ i);
            conList.add(con);
        }

        if (!conList.isEmpty()) {
            return conList;
        }
        return null;
    }
}