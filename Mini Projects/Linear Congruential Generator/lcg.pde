//Pseudo Random Number Generator

//LCG (Linear Congruential Generator)

/*

M - Modulus
A - Multiplier
C - Increment

X(n+1) = (A * X(n) + C) % M
X(0) = SEED

*/

class LCG {
  
  long M = 4294967296L;
  long A = 1664525;
  long C = 1;
  long seed;
  
  LCG(int seed) {
    if(seed < 0) {
      abs(seed);
    }
    this.seed = seed;
  }
  
  LCG() {
    seed = 0;
  }
  
  float getRand() {
    long num = (A * seed + C) % M;
    seed = num;
    return (float)num/M;
  }
  
};

LCG generator;

void setup()  {

  size(640, 360);
  generator = new LCG();  

}

void draw() {
 float rand = generator.getRand(); 
 print(rand + "\n");
}
   
  




