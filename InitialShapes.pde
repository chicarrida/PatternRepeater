import java.util.Collections;

public class InitialShapes {
  private ArrayList<GeoShape>shapes = new ArrayList<GeoShape>();
  private PVector maxDistances = new PVector(-1, -1);


  public ArrayList<GeoShape>getShapes() {
    return shapes;
  }

  public void addToList(GeoShape shape) {
    shapes.add(shape);
    sortShapes();
    determineDistances();
    setMaxDistances();
  }

  public void clearList() {
    shapes.clear();
  }

  public PVector getMaxDistances() {
    return maxDistances;
  }

  private void sortShapes() {
    Collections.sort(shapes, new Comparator<GeoShape>() {
      @Override
        public int compare(GeoShape s1, GeoShape s2) {
        return s1.compareTo(s2);
      }
    }
    );
    println(shapes.toString());
  }

  private void determineDistances() {
    for (int i = 0; i < shapes.size (); i++) {
      if (i > 0)
        shapes.get(i).determineDistanceToParent(shapes.get(i-1 ));
      if (i != shapes.size()-1) {
        shapes.get(i).setChild(shapes.get(i+1));
      }
    }
  }

  private void setMaxDistances() {
    ArrayList<GeoShape>tmpShapes = new ArrayList<GeoShape>(shapes);
    println("number of shapes: " + tmpShapes.size());
    Collections.sort(tmpShapes, new Comparator<GeoShape>() {
      public int compare(GeoShape o1, GeoShape o2) {        

        return Integer.compare((int)o1.getPosition().x, (int)o2.getPosition().x);
      }
    }
    );

    maxDistances.x = (int)(tmpShapes.get(tmpShapes.size()-1).getPosition().x- tmpShapes.get(0).getPosition().x);


    Collections.sort(tmpShapes, new Comparator<GeoShape>() {
      public int compare(GeoShape o1, GeoShape o2) {

        return Integer.compare((int)o1.getPosition().y, (int)o2.getPosition().y);
      }
    }
    );

    maxDistances.y = (int)(tmpShapes.get(tmpShapes.size()-1).getPosition().y- tmpShapes.get(0).getPosition().y);
  }
}
