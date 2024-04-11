public class StringArrayTest {
    public StringArrayTest() {

    }

    public static List<String> generateStringArray(Integer n){
        List<String> testList = new List<String>();
        Integer count =0;
        while (count < n) {
            String temp ='Test '+count;
            testList.add(temp);
            count++;
        }
        return testList;

    }

}