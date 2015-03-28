abstract class GeoShape implements Comparable<GeoShape> {

  protected PVector distanceToParent ;
  protected GeoShape child;
  protected PVector position;
  protected float rotationAngle;

  public void setPosition(PVector pos) {
    position = pos;
  }

  public PVector getPosition() {
    return position;
  }

  public PVector getDistanceToParent() {
    return distanceToParent;
  }

  public void setRotationAngle(float angle) {
    rotationAngle = angle;
  }

  public void setChild(GeoShape _child) {
    child = _child;
  }  

  public void determineDistanceToParent(GeoShape parent) {       
    distanceToParent = new PVector();
    distanceToParent.x = abs(parent.position.x - position.x);
    distanceToParent.y = abs(parent.position.y - position.y);
    //println("---");
    //println("distanceToParent: "+distanceToParent.x +", "+distanceToParent.y);
    //println("parent: "+parent.position.x +", "+parent.position.y);
    //println("child: "+position.x +", "+position.y);
    //println("---");
  }

  @Override
    public int compareTo(GeoShape other) {

    if (other.position.x > position.x && other.position.y >= other.position.y) {
      return -1;
    } else if (other.position.x == position.x && other.position.y == other.position.y) {
      return 0;
    } else {
      return 1;
    }
  }

  public void draww(PVector parentPos, boolean drawChild) {
    println("drawwing shape @ "+parentPos.x+", "+parentPos.y);
    if (position!=null) {      
      int x = (int)(parentPos.x + (distanceToParent != null ? distanceToParent.x : 0));
      int y = (int)(parentPos.y + (distanceToParent != null ? distanceToParent.y : 0));
      stroke(0, 0, 255);
      transformAndDraw(x, y);
      if (drawChild)
        drawChild(new PVector(x, y));
    }
  }

  void transformAndDraw(int x, int y) {      
    pushMatrix();
    translate(x, y);      
    drawShape( );
    popMatrix();
  }

  public void drawAtInitialPos() {
    //println("draw initial at "+position.x+", "+position.y);
    transformAndDraw((int)position.x, (int)position.y);
  }

  abstract void drawShape() ;

  protected void drawChild(PVector parentPos) { 
    println("drawChild: "+child);
    if (child != null) {
      stroke(255, 255, 0);

      child.draww(parentPos, true);
    }
  }

  protected float getRotationAngle() {
    return rotationAngle;
  }
}
