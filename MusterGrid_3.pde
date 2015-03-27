import java.util.Comparator;
import java.util.Iterator; 


GeoShape[][]grid;
GeoShape current;
ArrayList<GeoShape>shapes;
Hexagon initialHex;
Rectangle initialRect;
final int GRID_SIZE = 40;
final int FIELDS = 18;
final int OFFSET = 0;
float rotationAngle = PI/2;
boolean rotate = false;
boolean hex = true;
boolean hexFirst;
boolean debug = false;
InitialShapes initialShapes = new InitialShapes();

//************************************+

void setup() {
  size(FIELDS*GRID_SIZE, FIELDS*GRID_SIZE);
  grid = new GeoShape[FIELDS][FIELDS];
  shapes = new ArrayList<GeoShape>();
  noLoop();
}

//************************************+

void draw() {
  background(128);
  noFill();
  ellipse(width/2, height/2, 20, 20);  
  drawPattern();
  drawInitialShapes();
  noLoop();
}

//************************************+

void mouseReleased( ) {
  PVector pos = getCurrentPosition();  
  GeoShape shape = setUpShape(pos);
  initialShapes.addToList(shape);  
  //drawInitialShapes();
  redraw();
}

//************************************+

PVector getCurrentPosition() {

  int x = (int((mouseX+GRID_SIZE/2)/GRID_SIZE))*GRID_SIZE;
  int y =  (int((mouseY+GRID_SIZE/2)/GRID_SIZE))*GRID_SIZE;    
  return new PVector(x+OFFSET, y+OFFSET);
}

//************************************+

GeoShape setUpShape(PVector pos) {
  GeoShape shape;  
  if (hex) {      
    shape = new Hexagon(pos);
    if (initialHex == null) {
      initialHex  = new Hexagon(pos);
     // println("new initial hex at: "+pos.x+":"+pos.y);
      initialHex.setRotationAngle(rotationAngle);
    }
    if (initialRect != null && initialRect.position.equals(pos )) {
      initialRect = null;
    }
  } else {
    shape = new Rectangle(pos);
    if (initialRect == null) {
      initialRect = new Rectangle(pos);
      //      println("new initial rect at: "+pos.x+":"+pos.y);
      initialRect.setRotationAngle(rotationAngle);
    }
    if (initialHex != null && initialHex.position.equals(pos )) {
      initialHex = null;
    }
  }
  if (rotate) {
    shape.setRotationAngle(rotationAngle);
  }    
  return shape;
}

//************************************+
void drawPattern() {
  if (initialShapes.getShapes().size()==0) {
    return;
  }
  //  boolean drawChild = initialShapes.getShapes().size() > 2 ? true : false;
  println("draw pattern");
  int yDist = (int)initialShapes.getMaxDistances().y/GRID_SIZE;  
  int xDist = (int)initialShapes.getMaxDistances().x/GRID_SIZE;
  yDist += 1;
  xDist += 1;
  //if (yDist != 0 && xDist != 0) {
  if (yDist == 0) yDist = 1; 
  if (xDist == 0) xDist = 1; 

  for (int y = 0; y < FIELDS; ) {
    for (int x = 0; x < FIELDS; ) {
      println("drawing @ "+(x*GRID_SIZE)+", "+(y*GRID_SIZE));
      initialShapes.getShapes().get(0).draww(new PVector(x*GRID_SIZE, y*GRID_SIZE), true);
      x += xDist;
    }
    y+= yDist;
  }
}

void drawInitialShapes() {
  for (GeoShape s : initialShapes.getShapes ()) {
    stroke(240, 0, 230);
    s.drawAtInitialPos();
  }
  
  println("-------------------------------------------------");
}

//************************************+
void addToGrid(PVector pos, GeoShape shape) {

  int xIndex = (int)pos.x/GRID_SIZE;
  int yIndex = (int)pos.y/GRID_SIZE;
  GeoShape gridShape = grid[xIndex][yIndex];

  if (gridShape == null) {
    grid[xIndex][yIndex] = shape;
  } else if (gridShape.getClass() != shape.getClass() || gridShape.getRotationAngle() != shape.getRotationAngle()) {
    grid[xIndex][yIndex] = shape;
  }

  updateInitialShape(shape);
}
//*  ***********************************+

void updateInitialShape(GeoShape shape) {
  if (shape.getClass() == initialHex.getClass()) {
    initialHex.position = shape.getPosition();
  } else if (shape.getClass() == initialHex.getClass()) {
    initialRect.position = shape.getPosition();
  }
}

//************************************+

void createPattern() {
  if (shapes == null || shapes.isEmpty()) {
    return ;
  }
  if (shapes != null && !shapes.isEmpty()) {
    setShapeOrder();
  }
}

//************************************

private int getMaxXDistance()
{
  int maxXDistance = 0;

  if (debug)
    println("max x distance: "+maxXDistance);
  return maxXDistance;
}

//************************************+

private int getMaxYDistance()
{
  int maxYDistance = 0; 
  if (debug)
    println("max y distance: " +maxYDistance);
  return maxYDistance;
}

void setShapeOrder() {
}

public void testInitialShapes() {
  println();
  println("************************************************************");
  InitialShapes init = new InitialShapes();
  init.addToList(new Rectangle(new PVector(5, 10)));
  println("max x value "+init.getMaxDistances().x+" max y value "+init.getMaxDistances().y);
  init.addToList(new Rectangle(new PVector(3, 2)));
  println("max x value "+init.getMaxDistances().x+" max y value "+init.getMaxDistances().y);
  init.addToList(new Hexagon(new PVector(7, 1)));
  println("max x value "+init.getMaxDistances().x+" max y value "+init.getMaxDistances().y);
}


void keyPressed(){
  
  if(key == 'r' || key == 'R'){
   initialShapes.getShapes().clear();   
  }
}
