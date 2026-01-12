import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;



public class AlgorithmComparison_code{


    public static void main(String[] args){
        // load data
        final int NUMCASES = 4;
        long starttime, endtime, time;
        int rand_index;
        String pth = null;
        ArrayList<Integer>[] arrs = new ArrayList[NUMCASES];
        

        for (int i=0; i<NUMCASES; i++){
            int fnum = 100 * (int)Math.pow(10, i);
            arrs[i] = new ArrayList<>();
            try {
                
            pth = "DataSets/"+Integer.toString((fnum))+"_term_case.txt";
            File file = new File(pth);
            Scanner reader = new Scanner(file);
            while (reader.hasNext()) {
                arrs[i].add(reader.nextInt());
            }


            reader.close();
            }catch (FileNotFoundException e) {System.err.println("file: "+pth+" Not Found");}
            

        }

        // clear prev results
        File results = new File("results.txt");
        if(results.delete()){System.out.println("Cleared Previous Results");}
        else {System.out.println("Could Not Clear Previous Results");}

        // prep for new results
        results = new File("results.txt");
        try{results.createNewFile();}
        catch(IOException e){
            System.out.println("Error when creating file");
            return;
        }
        
        // Linear Search
        try{
            FileWriter writer = new FileWriter(results);

        
        writer.write("==== Linear Search ====\n");
        

        for (int i = 0; i < arrs.length; i++) {
            rand_index = (int)(Math.random() * arrs[i].size());
            starttime = System.nanoTime();
            linear_search(arrs[i], arrs[i].get(rand_index));
            endtime = System.nanoTime();
            time = endtime - starttime;
            writer.write(arrs[i].size() + " term\tstart: "+starttime+"\tend: "+endtime+"\t elapsed: "+time+"\n");

        }
        
        
        // Selection Sort
        writer.write("==== Selection Sort ====\n");
        

        for (int i = 0; i < arrs.length; i++) {
            starttime = System.nanoTime();
            selection_sort(arrs[i]);
            endtime = System.nanoTime();
            time = endtime - starttime;
            writer.write(arrs[i].size() + " term\tstart: "+starttime+"\tend: "+endtime+"\t elapsed: "+time+"\n");

        }
        // Binary Search
        writer.write("==== Binary Search ====\n");
        

        for (int i = 0; i < arrs.length; i++) {
            rand_index = (int)(Math.random() * arrs[i].size());
            starttime = System.nanoTime();
            binary_search(arrs[i], arrs[i].get(rand_index));
            endtime = System.nanoTime();
            time = endtime - starttime;
            writer.write(arrs[i].size() + " term\tstart: "+starttime+"\tend: "+endtime+"\t elapsed: "+time+"\n");

        }
        writer.close();
        }catch(Exception e){return;}

    }

    private static int linear_search(ArrayList<Integer> arr, int item){
        for(int i=0; i<arr.size(); i++){

            if(arr.get(i) == item){return i;}
        }
        return -1;
    }

    private static int binary_search(ArrayList<Integer> arr, int item){
        int left = 0;
        int right = arr.size();
        while(left < right){
            int mid = (left + right)/2;

            if(arr.get(mid) == item){return mid;}
            else if(arr.get(mid) > item){right = mid;}
            else if(arr.get(mid) < item){left = mid;}
        }
        
        return -1;
    }
    
    private static ArrayList<Integer> selection_sort( ArrayList<Integer> arr){
        for(int i=0; i<arr.size(); i++){
            int min = i;
            for (int j=i; j<arr.size(); j++){
                if(arr.get(j) < arr.get(min)){min = j;}
            }
            

            int temp = arr.get(min);
            arr.set(min, arr.get(i));
            arr.set(i, temp);
        }

        return arr;
    }

}