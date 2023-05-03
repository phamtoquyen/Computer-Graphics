// Object Modeling Example Code
float time = 0;   // time is used to move objects from one frame to another
boolean generateImages = false; // For instructors. Automatically generate images (and create a video manually).
PImage bg;
float changeX = 0;

void setup() {
  size(1422, 800, P3D); // If 3D mode is not working on your mac, download the latest version of Processing with a proper version: "Apple Silicon" or "Intel 64-bit".
  bg = loadImage("hatched egg shell.jpg");
  frameRate(30);      // this seems to be needed to make sure the scene draws properly
  perspective(60 * PI / 180, 1, 0.1, 1000); // 60-degree field of view
}

void draw() {
  time += 0.05;
  // You are tasked to modify this function to design your own character.
  // You can focus on object modeling, while leaving background/lighting/camera as-is. Feel free to modify anything if needed!
  // For the requirements for object modeling, please refer to the project description on canvas.
  // Don't forget to display the name of the character.

if(time >= 6 && time < 7) changeX = -time * 10;
       
  camera (changeX, 0, 100, 0, 0, 0, 0, 1, 0); // position of the virtual camera
  
  
  background (bg);  // clear screen and set background to light blue

  // set up the lights
  ambientLight(50, 50, 50);
  lightSpecular(255, 255, 255);
  directionalLight (100, 100, 100, -0.3, 0.5, -1);
  
  spotLight(255, 255, 109, 0, 40, 200,
            0, -0.5, -0.5,
            PI / 2, 2);

  // set some of the surface properties
  noStroke();
  specular (180, 180, 180);
  shininess (15.0);
  if(time > 10) exit();

  // Rotate everything together
  cloud(1);
  cloud(2);
  sun();
  pushMatrix();
  translate(0 , 20, 0);
  if (time > 1.9) translate((time*5) , 0, 0);
  scale(.3,.3,1);
  //rotateY(time); // Rotate around the vertical axis
  if (time > 1.5)  rotateY(45);
  

  // ==============================
  // Object modeling begins
  // ==============================  
  // a red box
  //fill (255, 0, 0);
  //pushMatrix();
  //translate (-30, 0, 0);
  //box(20);
  //popMatrix();

  // a green sphere
  //fill (0, 250, 0);
  //pushMatrix();
  //translate(-10, 5, 0);
  //sphereDetail(60); // this controls how many polygons make up each sphere
  //sphere(10);
  //popMatrix();

  // a blue cylinder
  //fill (0, 0, 255);
  //pushMatrix();
  //translate (10, 0, 0);  
  //scale (10, 10, 10);
  //cylinder();
  //popMatrix();
  
  //Head
  fill (250, 250, 15);
  pushMatrix();
  translate(-10, -7, 0);
  scale(1.4,1.2,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(20);
  popMatrix();
  
  
  //Body
  pushMatrix();
  translate(-10, 18, 0);
  scale(1.5,1.1,1.2);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(12);
  popMatrix();
  

  //lefteye
  fill (0, 0, 0);
  pushMatrix();
  translate(-20, -10, 17);
  scale(2.0,1.5,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(4);
  popMatrix();
  
  
  //left-eyeball
  fill (255, 255, 255);
  pushMatrix();
  translate(-20, -10, 20);
  scale(1.2,1.2,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(2);
  popMatrix();
  
  //right eye
  fill (0, 0, 0);
  pushMatrix();
  translate(5, -10, 17);
  scale(2.0,1.5,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(4);
  popMatrix();
  
  //right-eyeball
  fill (255, 255, 255);
  pushMatrix();
  translate(5, -10, 20);
  scale(1.2,1.2,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(2);
  popMatrix();

  //nose
  fill(250, 250, 250);
  pushMatrix();
  translate(-8.5, -10, 20);
  scale(1,1.2,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(2);
  popMatrix();
  
  //beak
  fill (250, 0, 0);
  pushMatrix();
  translate(-8, -8, 20);
  scale(1.5,1,1);
  sphereDetail(60); // this controls how many polygons make up each sphere
  sphere(2);
  popMatrix();
  
  //leg1
  fill (255, 165, 0);
  pushMatrix();
  translate (-15, 30, 0);
  rotateY(45);
  rotateX(-10);
  scale (1, 5, 1);
  cylinder();
  popMatrix();
  
  //leg2
  fill (255, 165, 0);
  pushMatrix();
  translate (-5, 30, 0);
  rotateY(45);
  rotateX(10);
  scale (1, 5, 1);
  cylinder();
  popMatrix();

  //hand
  fill (255, 165, 0);
  pushMatrix();
  translate (-27, 20, 0);
  rotateY(45);
  rotateX(-10);
  scale (1, 5, 1);
  cylinder();
  popMatrix();
  //hand2
  fill (255, 165, 0);
  pushMatrix();
  translate (7, 20, 0);
  rotateY(45);
  rotateX(10);
  scale (1, 5, 1);
  cylinder();
  popMatrix();
  // ==============================
  // Object modeling ends
  // ==============================  
  // pop the rotation matrix
  
  popMatrix(); 
  pushMatrix();
  translate(-10, 40, 0);
  scale(0.1, 0.1, 0.1);
  fill(0);
  textAlign(CENTER);
  textSize(48); 
  text("Tweety Bird", 0, 0);
  popMatrix();
  
  // Single frame capture with 'c' key
  if (keyPressed && key == 'c') {
    saveFrame("p2-######.png");
  }
  if (generateImages && frameCount < 300) {
    saveFrame("p2-######.png");
  }
}


void cylinder() {
  // Helper function to draw a cylinder radius = 1, z range in [-1, 1]
  cylinder(50);
}

void cylinder(int sides) {
  // Helper function to draw a cylinder with the given number of sides.
  // first endcap
  beginShape();
  for (int i = 0; i < sides; i++) {
    float theta = i * 2 * PI / sides;
    float x = cos(theta);
    float y = sin(theta);
    vertex(x, y, -1);
  }
  endShape(CLOSE);

  // second endcap
  beginShape();
  for (int i = 0; i < sides; i++) {
    float theta = i * 2 * PI / sides;
    float x = cos(theta);
    float y = sin(theta);
    vertex(x, y, 1);
  }
  endShape(CLOSE);
  

  // round main body
  float x1 = 1;
  float y1 = 0;
  for (int i = 0; i < sides; i++) {
    float theta = (i + 1) * 2 * PI / sides;
    float x2 = cos(theta);
    float y2 = sin(theta);
    beginShape();
    normal (x1, y1, 0);
    vertex (x1, y1, 1);
    vertex (x1, y1, -1);
    normal (x2, y2, 0);
    vertex (x2, y2, -1);
    vertex (x2, y2, 1);
    endShape(CLOSE);
    x1 = x2;
    y1 = y2;
  }
}


void cloud(int x){
  pushMatrix();
  translate(-50+x*10, -50+x*10, 0);
  scale(2.0,1.0,1);
  fill (255, 255, 255);
  sphere(5);
  popMatrix();
  pushMatrix();
  translate(-50+x*10, -50, 0);
  scale(2.0,1.0,1);
  fill (255, 255, 255);
  sphere(5);
  popMatrix();
}


void sun(){
  pushMatrix();
  translate(30, -40, 0);
  rotateZ(time/2);
  scale(1.5,1.3,1);
  
  System.out.println(time);
  fill (255, 255, 0);
  sphere(10);
  popMatrix();
}
