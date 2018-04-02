import frames.timing.*;
import frames.primitives.*;
import frames.processing.*;

// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean colores = false; // variable para shading
// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(600, 600, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();
  //smooth(5);
  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it :)
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    public void execute() {
      spin();
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow( 2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.coordinatesOf converts from world to frame
  // here we convert v1 to illustrate the idea
  
    
  if (debug) {
    pushStyle();
    noStroke();
    fill(255, 255, 0);
    float[] valores_x={frame.coordinatesOf(v1).x(),frame.coordinatesOf(v2).x(),frame.coordinatesOf(v3).x()};
    float[] valores_y={frame.coordinatesOf(v1).y(),frame.coordinatesOf(v2).y(),frame.coordinatesOf(v3).y()};
    int min_x=round(min(valores_x));
    int max_x=round(max(valores_x));
    int min_y=round(min(valores_y));
    int max_y=round(max(valores_y));
    // vector auxiliar para recorrer los pixles
    Vector p;
    for(float i= min_x-0.5; i<=max_x;i++){
      for(float j= min_y-0.5; j<=max_y;j++){
        p = new Vector(i,j);
        //dado a,b,c, calular los puntos dentro del triangulo con coordenadas baricentricas
        //(c.x - a.x) * (b.y - a.y) - (c.y - a.y) * (b.x - a.x)
      
        //v0,v1,p 
        float a = (p.x() - valores_x[0]) * (valores_y[1]-valores_y[0]) - (p.y()-valores_y[0]) * (valores_x[1] - valores_x[0]);
        //v1,v2,p
        float t = (p.x() - valores_x[1]) * (valores_y[2]-valores_y[1]) - (p.y()-valores_y[1]) * (valores_x[2] - valores_x[1]);
        //v2,v0,p
        float g = (p.x() - valores_x[2]) * (valores_y[0]-valores_y[2]) - (p.y()-valores_y[2]) * (valores_x[0] - valores_x[2]);
        if ((a>=0 && g>=0 && t>=0) || (a<=0 && g<=0 && t<=0) ){
          //si esta dentro del triangulo pintar la grilla
          rect(i-0.5,j-0.5,1,1);
        }
      }
    }
    //point(round(frame.coordinatesOf(v1).x()), round(frame.coordinatesOf(v1).y()));
    popStyle();
  }
  if(colores){
    // se repite lo mismo de rasterizar con algunas nuevas variables como area para encontrar el color especifico del triangulo
    float[] valores_x={frame.coordinatesOf(v1).x(),frame.coordinatesOf(v2).x(),frame.coordinatesOf(v3).x()};
    float[] valores_y={frame.coordinatesOf(v1).y(),frame.coordinatesOf(v2).y(),frame.coordinatesOf(v3).y()};
    int min_x=round(min(valores_x));
    int max_x=round(max(valores_x));
    int min_y=round(min(valores_y));
    int max_y=round(max(valores_y));
    
    Vector p;
    for(float i= min_x-0.5; i<=max_x;i++){
      for(float j= min_y-0.5; j<=max_y;j++){
        p = new Vector(i,j);
        //dado a,b,c
        //(c.x - a.x) * (b.y - a.y) - (c.y - a.y) * (b.x - a.x)
        // v0,v1,v2
        float area =(valores_x[2] - valores_x[0]) * (valores_y[1]-valores_y[0]) - (valores_y[2]-valores_y[0]) * (valores_x[1] - valores_x[0]);;
        //v0,v1,p
        float a = (p.x() - valores_x[0]) * (valores_y[1]-valores_y[0]) - (p.y()-valores_y[0]) * (valores_x[1] - valores_x[0]);
        //v1,v2,p
        float t = (p.x() - valores_x[1]) * (valores_y[2]-valores_y[1]) - (p.y()-valores_y[1]) * (valores_x[2] - valores_x[1]);
        //v2,v0,p
        float g = (p.x() - valores_x[2]) * (valores_y[0]-valores_y[2]) - (p.y()-valores_y[2]) * (valores_x[0] - valores_x[2]);
        
        if ((a>=0 && g>=0 && t>=0) || (a<=0 && g<=0 && t<=0) ){
          pushStyle();
          colorMode(RGB,1);
          stroke(a/area,t/area,g/area);
          rect(i,j-0.5,0,1);
          popStyle();
        }
      }
    }
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void spin() {
  if (scene.is2D())
    scene.eye().rotate(new Quaternion(new Vector(0, 0, 1), PI / 100), scene.anchor());
  else
    scene.eye().rotate(new Quaternion(yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100), scene.anchor());
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 's')
    colores=!colores;
}
