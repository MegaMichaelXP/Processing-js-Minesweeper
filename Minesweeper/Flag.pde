public class Flag extends BoardItem {
  protected int type;
  
  Flag (int rowAt, int colAt, int type) {
    super(rowAt,colAt);
    this.type = type;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    translate(xAt,yAt);
    rectMode(CORNER);
    textSize(cellSize/1.4);
    strokeWeight(1);
    stroke(0);
    fill(0,100,0);
    rect(0,0,cellSize,cellSize);
    noStroke();
    if (type == 0) {
      fill(50);
      rect(0.3*cellSize,0.1*cellSize,0.1*cellSize,0.833*cellSize);
      fill(255,0,0);
      beginShape();
      vertex(0.4*cellSize,0.1*cellSize);
      vertex(0.4*cellSize,0.5*cellSize);
      vertex(0.8*cellSize,0.3*cellSize);
      endShape();
    } else if (type == 1) {
      fill(0);
      rectMode(CENTER);
      textAlign(CENTER);
      text("?",cellSize/1.9,cellSize/1.3);
    } else {
      fill(180);
      stroke(0);
      strokeWeight(1);
      rect(0,0,cellSize,cellSize);
      noStroke();
      fill(0);
      ellipseMode(CORNER);
      ellipse(4,4,cellSize-7,cellSize-7);
      stroke(255,0,0);
      strokeWeight(3);
      line(4,4,cellSize-4,cellSize-4);
      line(cellSize-4,4,4,cellSize-4);
    }
    rectMode(CORNER);
    popMatrix();
  }
  
}
