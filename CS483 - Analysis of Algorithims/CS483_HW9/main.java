import java.math.BigInteger;
import java.util.LinkedHashMap;
import java.util.Map;

public class main{
    /***
     * DP Matrix for calculated Fib numbers
     */
    private static BigInteger dpMatrix[] = null;
    /***
     * Memo map for calculated Fib numbers
     */
    private static CalculationCache memos;

    /***
     * Calculate nth Fib with recursion
     * @param n
     * @return
     */
    private static double calcFib_recursive(int n){
        if(n <= 1){return n;}
        return calcFib_recursive(n-1) + calcFib_recursive(n-2);
    }

    /***
     * Calculate nth Fib with Dynamic Programming
     * @param n
     * @return
     */
    private static BigInteger calcFib_Dynamic(int n){
        if(n <= 2) {return BigInteger.ONE;} // Small Case
        int a = 0;
        if(dpMatrix == null){dpMatrix = new BigInteger[n+1];}      // Initialize dpMatrix if null
        else if(dpMatrix.length > n+1){return dpMatrix[n];} // Return if already computed
        else if(dpMatrix.length <= n){                      // Resize dpMatrix if too small
            BigInteger[] newMatrix = new BigInteger[n+1];
            System.arraycopy(dpMatrix, 0, newMatrix, 0, dpMatrix.length);
            a = dpMatrix.length;
            dpMatrix = newMatrix;
        }    
        if(a == 0){                                         // Set base cases if new dpMatrix
            dpMatrix[0] = BigInteger.ZERO;   
            dpMatrix[1] = BigInteger.ONE;
            a = 2;
        }

        for(int i = a; i<=n; i++){dpMatrix[i] = dpMatrix[i-1].add(dpMatrix[i-2]);} // Calculate Fib numbers iteratively (Would have stack overflow with recursion)

        return dpMatrix[n];                                 // Return result
    }


    /***
     * Calculate nth Fib with Memoization
     * @param n
     * @return
     */
    private static BigInteger calcFib_Memo(long n){
        if (n <= 1) return BigInteger.valueOf(n);

        if (memos == null) {                                    // Initialize memos if null 
            memos = new CalculationCache();
            memos.put(0L, BigInteger.ZERO);
            memos.put(1L, BigInteger.ONE);
        }

        if (memos.containsKey(n)){return memos.get(n);}          // Return if already computed

        for (long i = 2; i <= n; i++) {                         // Calculate Fib numbers iteratively
            if (!memos.containsKey(i)) {                        // Only calculate if not already in memos
                if(i== 2 && (memos.get(i-1) == null || memos.get(i-2) == null)){
                    memos.put(i-1, BigInteger.ZERO);
                    memos.put(i-2, BigInteger.ONE);
                }

                BigInteger temp = memos.get(i - 1).add(memos.get(i - 2));
                memos.put(i, temp);                             // Store in memos 
            }
        }
        return memos.get(n);                                    // Return result
    }
    


    public static void main(String[] args) {
        int nthFib;                 // nth Fibonacci number to calculate
        double result = 0;               // result
        long startTime;             // Start time
        long timeElapsed;           // Time elapsed
        BigInteger bigResult = BigInteger.ZERO;       // BigInteger result for large Fibonacci numbers

        if(args.length < 1){return;}
        for(int i=1; i<args.length; i++){
            nthFib = Integer.parseInt(args[i]);
            switch (args[0]) {
                case "FibRec" -> {                  // Recursive
                    startTime = System.currentTimeMillis();
                    result = calcFib_recursive(nthFib);
                    timeElapsed = System.currentTimeMillis() - startTime;
                    }

                    case "FibDP" -> {                  // Dynamic Programming   
                        startTime = System.currentTimeMillis();
                        bigResult = calcFib_Dynamic(nthFib);
                        timeElapsed = System.currentTimeMillis() - startTime;
                    }

                    case "FibMemo" -> {                 // Memoization  
                        startTime = System.currentTimeMillis();
                        bigResult = calcFib_Memo((long)nthFib);
                        timeElapsed = System.currentTimeMillis() - startTime;
                    }
                    
                default -> {return;}
                }
                if(result == 0){
                    System.out.printf("Fib number "+nthFib+" = %s ("+timeElapsed+")\n",bigResult.toString());
                }
                else{
                    System.out.printf("Fib number "+nthFib+" = %.1f ("+timeElapsed+")\n",result);
                }
            }
    }

    public static class CalculationCache extends LinkedHashMap<Long, BigInteger> {
        private static final int MAX_CACHE_SIZE = 15;
        
        
        public CalculationCache() {super(MAX_CACHE_SIZE+1, 0.75f, true);}
    
        @Override
        protected boolean removeEldestEntry(Map.Entry<Long, BigInteger> eldest) {return size() > MAX_CACHE_SIZE;}
    }
}

 
