public with sharing class AccountHandler {
    public AccountHandler() {

    }

    public static Account insertNewAccount(String accName){
       
            try {
                Account temp =new Account(Name =accName);
                insert temp;
                return temp; 
            } catch (DmlException dme) {
                return null;
            }
                
        
    }

    public static void insertAccount(Integer n){

        List<Account> addAccounts = new List<Account>();
        Integer count =1; 
        while(count <= n){
            Account temp = new Account();
            temp.Name = 'Acme Inc '+ count;
            temp.AccountNumber = 'A000'+ count;

            addAccounts.add(temp);
            count++;
        }
        insert addAccounts;
        
    }
}