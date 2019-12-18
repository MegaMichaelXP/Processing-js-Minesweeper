public class ClickedSpace extends BoardItem {
  protected int mines;
  protected boolean mineClicked;
  
  ClickedSpace (int rowAt, int colAt, int mines, boolean mineClicked) {
    super(rowAt,colAt);
    this.mines = mines;
    this.mineClicked = mineClicked;
  }
  
  public void show (int xAt, int yAt, int cellSize) {
    pushMatrix();
    fill(180);
    stroke(0);
    strokeWeight(1);
    translate(xAt,yAt);
    rectMode(CORNER);
    if (mineClicked) {
      fill(255,0,0);
      rect(0,0,cellSize,cellSize);
      noStroke();
      fill(0);
      ellipseMode(CORNER);
      ellipse(4,4,cellSize-7,cellSize-7);
    } else {
      rect(0,0,cellSize,cellSize);
      switch (mines) {
        case 1:
          fill(0,0,255);
          break;
        case 2:
          fill(0,120,0);
          break;
        case 3:
          fill(255,0,0);
          break;
        case 4:
          fill(30,0,128);
          break;
        case 5:
          fill(178,34,34);
          break;
        case 6:
          fill(2,119,114);
          break;
        case 7:
          fill(0);
          break;
        case 8:
          fill(80);
          break;
      }
      if (mines > 0) {
        rectMode(CENTER);
        textAlign(CENTER);
        textSize(cellSize/1.05);
        text(mines,cellSize/1.92,cellSize/1.15);
      }
    }
    rectMode(CORNER);
    popMatrix();
  }
  
}
