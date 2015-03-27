class Hexagon extends GeoShape {

  public Hexagon(PVector pos) {
    super.setPosition( pos);
  }

  public Hexagon( ) {
  }

  void drawShape() {
//    println("entering draw hexagon method");
    //stroke(0, 0, 255);
    //strokeWeight(13 );
      beginShape( );
      vertex(-20, 0);
      vertex(-10, 20);
      vertex(10, 20);
      vertex(20, 0);
      vertex(10, -20);
      vertex(-10, -20);
      vertex(-20, 0);
      endShape();
  }


  void setRotationAngle(float angle) {
    rotationAngle = angle;
  }  
}
