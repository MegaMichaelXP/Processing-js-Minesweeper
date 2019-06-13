public class Mine extends BoardItem {
  
  Mine (int rowAt, int colAt) {
    super(rowAt,colAt);
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    translate(xAt,yAt);
    fill(180);
    stroke(0);
    strokeWeight(1);
    rect(0,0,cellSize,cellSize);
    fill(0);
    noStroke();
    ellipseMode(CORNER);
    ellipse(2,2,cellSize-3,cellSize-3);
    popMatrix();
  }
  
}
