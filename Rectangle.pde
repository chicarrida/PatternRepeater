class Rectangle extends GeoShape {

  public Rectangle(PVector pos) {
    super.setPosition( pos);
  }
  //FIXME mel das kann vielleicht auch anders???
  public Rectangle() {
    super.setPosition(new PVector(0, 0));
  }

  void drawShape() {  
  //println("entering draw rectangle method");  
    rectMode(CENTER);    
    rect(0, 0, 40, 40);
  }
  void setRotationAngle(float angle) {
    rotationAngle = angle;
  }
  //muss das sein?
  @Override
    public int compareTo(GeoShape other) {
    return super.compareTo(other);
  }
}
