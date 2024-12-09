/*
*********************************************************************************************************
*                  Calculate the potential of a number of charges in a CUBE
*********************************************************************************************************
*/

int Sstart, Mstart, Hstart, Tstart;
int Send, Mend, Hend, Tend;

int sb = second();
int mb = minute();
int hb = hour();

float a = 80;          // Size of CUBE [mm]
int Nx = 1000;
int Ny = 1000;
int Nz = 1000;
int N = Nx * Ny * Nz;   // Number of ions in the CUBE
int STEP = 8;           // (STEP+1) points across the cube to determine the potential
float DELTA = a/STEP;

float SCALE = 4;

double ke = 8.9875517873681764; // Coulomb's constant (N·m²·C-²)
double q = 1.602176487 * 1e-10; // Elementary charge scaled
double[] pot = new double[STEP + 1];

void setup() {
  size(800, 800);
  background(255);
  startTimer();
  
  calculatePotential(N);
  
  stopTimer();
} // End of setup()

double[] calculatePotential(int n) {
  for (int i = 1; i <= n; i++) {
    // Random position of an ion in [mm]
    float Xi = random(0, a);
    float Yi = random(0, a);
    float Zi = random(0, a);
    
    for (int k = 0; k <= STEP; k++) {
      float Xk = a/2;
      float Yk = a/2;
      float Zk = k * DELTA;

      double D = 0.001 * distance(Xi, Yi, Zi, Xk, Yk, Zk);
      pot[k] += ke * q/D;
    }
    // Uncomment this line to print results periodically
    // if (i % 100000 == 0) { printResult(); }
  }
  
  printResult();
  return pot;
}

void printResult() {
  println(N + " charges put in a CUBE with a side " + a + " [mm]"); 
  println("--------------");
  println("[mm]  [V]");
  println("--------------");
  for (int l = 0; l <= STEP; l++) {
    println((l * DELTA) - 40 + "\t" + String.format("%.3f", pot[l]));
  }
}

// Calculate distance between point (x, y, z) and point (a, b, c) in [mm]
double distance(float x, float y, float z, float a, float b, float c) {
  return sqrt((x - a) * (x - a) + (y - b) * (y - b) + (z - c) * (z - c));
}

//**************************************************************************************************
// Auxiliary Functions
//**************************************************************************************************

void draw() { 
  fill(0); 
  stroke(180);
  strokeWeight(1);
  
  for (int i = 1; i <= Ny * Ny/100; i++) {
    point(200 + SCALE * random(0, a), 200 + SCALE * random(0, a));
  }  
  
  stop();
}

// Start timer
public void startTimer() {
  Sstart = second();  
  Mstart = minute();  
  Hstart = hour();
  Tstart = millis();
  
  println("The task started at " + Hstart + ":" + Mstart + ":" + Sstart); 
}

// Stop timer
public void stopTimer() {
  Send = second();  
  Mend = minute();  
  Hend = hour();
  Tend = millis();
  
  println("The task ended at " + Hend + ":" + Mend + ":" + Send);
  println("It took " + ((Tend - Tstart)/3600000) + ":" + ((Tend - Tstart)/60000) + ":" + (((Tend - Tstart)/1000) - 60));
}
