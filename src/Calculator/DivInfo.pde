import java.math.*;
import java.util.*;
class DivInfo {
  int num;
  ArrayList<Integer> primeList;
  private int[] catalan;
  private int[] bell;
  String nextPrime = "";
  String prevPrime = "";


  DivInfo(int num) {
    this.num = num;
    allPrimesLessThanN(8000);
    catalan = new int[10];
    bell = new int[10]; 
    catalan = makeCatalan();
    bellGenerator();
  }

  // Returns divisors
  String getDivs(int num) {
    String result = "";
    for (int i=1; i<=num; i++) {
      if (num%i==0) {
        result+=i+" ";
      }
    }
    return result;
  }

  // Returns factors
  String getFactors(int num) {
    String result = "";
    for (int f = 2; f*f <= num; f++) {
      while (num % f == 0) {
        result+=f + " "; 
        num/=f;
      }
    }
    return result = result  + num;
  }

  // Returns sum of divisors (traditional)
  int divSum(int num) {
    int result = 0;
    for (int i=2; i<=sqrt(num); i++) {
      if (num%i==0) {
        if (i==(num/i))
          result += i;
        else
          result += (i + num/i);
      }
    }
    return (result + 1);
  }

  // returns divisor sum with itself
  int divSum2(int num) {
    int result = 0;
    for (int i=2; i<=sqrt(num); i++) {
      if (num%i==0) {
        if (i==(num/i))
          result += i;
        else
          result += (i + num/i);
      }
    }
    return (result + 1 + num);
  }

  // Returns prime 
  boolean isPrime(int num) { 
    int squarert = int(sqrt(num)) + 1; 
    for (int i = 2; i < squarert; i++) { 
      if (num % i == 0) {
        return false;
      }
    } 
    return true;
  }

  // Returns a customizable base number equivilant
  public String convert ( int number, int base )
  {
    return convert(number, base, 0, "" );
  }

  private String convert ( int number, int base, int position, String result )
  {
    char symbols[] = new char[] { '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T' };

    if ( number < Math.pow(base, position + 1) )
    {
      return symbols[(number / (int)Math.pow(base, position))] + result;
    } else
    {
      int remainder = (number % (int)Math.pow(base, position + 1));
      return convert (  number - remainder, base, position + 1, symbols[remainder / (int)( Math.pow(base, position) )] + result );
    }
  }
  //String convert(int num, int base) {
  //  int q = num / base;
  //  int rem = num % base;

  //  if (q == 0) {
  //    return Integer.toString(rem);
  //  } else {
  //    return convert(q, base) + Integer.toString(rem);
  //  }
  //}

  // Fibonacci Numbers
  boolean isFibonacci(int num) {
    int fib1 = 0;
    int fib2 = 1;
    do {
      int saveFib1 = fib1;
      fib1 = fib2;
      fib2 = saveFib1 + fib2;
    } while (fib2 < num);

    if (fib2 == num)
      return true;
    else
      return false;
  }

  // Catalan Numbers
  /**Generates a list of the first 10 Catalan numbers
   * 
   * @return Array of first 10 Catalan numbers
   */
  public int[] makeCatalan() {
    int[] returnVal = new int[10];

    for (int i=1; i<11; i++) {
      returnVal[i-1]= Integer.valueOf(factorial(2*i).divide(factorial(i+1).multiply(factorial(i))).toString());
    }

    return returnVal;
  }
  /**Tests to see if a number is a Catalan Number
   * Definition here : https://en.wikipedia.org/wiki/Catalan_number
   * 
   * @param n Number to test if Catalan
   * @return Whether or not a number is a Catalan #
   */
  public boolean isCatalan(int n) {
    for (int i : catalan) {
      if (i==n) return true;
    }
    return false;
  }

  /**Tests to see if a given paramater is a Hamming number
   * Hamming number if the only prime factors of that number are 2, 3, or 5
   * 
   * @param n Number to test if a Hamming Number
   * @return if the Number is a Hamming Number
   */
  public boolean isHamming(int n) {
    int num = n;
    while (num%5==0) {
      num=num/5;
    }
    while (num%3==0) {
      num=num/3;
    }

    while (num % 2==0) {
      num=num/2;
    }
    if (num==1) {
      return true;
    } else {
      return false;
    }
  }

  // Returns the instance of the prime that is looked up
  void allPrimesLessThanN(int n) {
    primeList = new ArrayList();
    for (int i = 1; i <= n; i ++) {
      if (isPrime(i))
        primeList.add(i);
    }
  }

  public BigInteger factorial(int n) {
    BigInteger convertToRet = new BigInteger("1");
    for (int i=1; i<=n; i++) {
      convertToRet = convertToRet.multiply(new BigInteger(String.valueOf(i)));
    }
    return convertToRet;
  }

  public void bellGenerator() {
    bell[0] = 1;
    bell[1] = 1;
    for (int i=2; i<bell.length; i++) {
      bell[i] = recurrBell(i);
    }
  }

  public int nComb(int n, int k) {
    BigInteger result;
    result = factorial(n).divide(factorial(k).multiply(factorial(n-k)));

    return result.intValue();
  }

  public int recurrBell(int n) {
    int sum = 0;
    for (int i=0; i<n; i++) {
      sum += nComb(n-1, i)*bell[i];
    }
    return sum;
  }

  public boolean isBell(int n) {
    for (int i : bell) {
      if (i==n) return true;
    }
    return false;
  }

  // Returns the previous prime
  int nextPrime(int num) {
    int retval = 0;
    if (isPrime(num)) {
      retval=primeList.get(num);
      return retval;
    } else {
      retval=primeList.get(num-1);
      return retval;
    }
  }
}
