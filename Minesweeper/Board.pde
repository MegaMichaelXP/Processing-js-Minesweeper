public class Board {
  
  int x_pos, y_pos;
  int xAt, yAt;
  int cellSize;
  int rows, cols;
  int[][] layer;
  boolean mines_shown;
  ArrayList<BoardItem> mines;
  ArrayList<BoardItem> spaces;
  ArrayList<Flag> flags;
  ArrayList<BoardItem> questions;
  
  public Board(int x, int y, int numRows, int numCols, int cellSize) {
    x_pos = x;
    y_pos = y;
    rows = numRows;
    cols = numCols;
    this.cellSize = cellSize;
    layer = null;
    mines_shown = false;
    mines = new ArrayList<BoardItem>();
    spaces = new ArrayList<BoardItem>();
    flags = new ArrayList<Flag>();
  }
  
  public void show() {
    pushMatrix();
    translate(x_pos,y_pos);
    for (int j=0; j<rows; j++) {
      for (int i=0; i<cols; i++) {
        xAt = i*cellSize;
        yAt = j*cellSize;
        strokeWeight(1);
        stroke(0);
        fill(0,100,0);
        rect(xAt,yAt,cellSize,cellSize);
        
        drawLayerCell(j,i,xAt,yAt);
        
      }
    }
    if (mines_shown) {
      for (BoardItem mine: mines) {
        xAt = mine.col()*cellSize;
        yAt = mine.row()*cellSize;
        mine.show(xAt,yAt,cellSize);
      }
    }
    for (BoardItem space: spaces) {
      xAt = space.col()*cellSize;
      yAt = space.row()*cellSize;
      space.show(xAt,yAt,cellSize);
    }
    for (BoardItem flag: flags) {
      xAt = flag.col()*cellSize;
      yAt = flag.row()*cellSize;
      flag.show(xAt,yAt,cellSize);
    }
    popMatrix();
  }
  
  public void addMine(BoardItem mine) {
    mines.add(mine);
  }
  
  public void addSpace(BoardItem space) {
    spaces.add(space);
  }
  
  public void flagSpace(Flag flag) {
    flags.add(flag);
  }
  
  public void removeFlagAt(int row, int col) {
    for (int i=0; i<flags.size(); i++) {
      BoardItem checkedFlag = flags.get(i);
      if (checkedFlag.row() == row && checkedFlag.col() == col) {
        flags.remove(i);
      }
    }
  }
  
  protected void drawLayerCell(int rowId, int colId, int xPos, int yPos) {
    if (layer != null) {
      if (layer.length > rowId) {
        if (layer[rowId].length > colId) {
          int cellColor = layer[rowId][colId];
          fill(cellColor);
          rect(xPos,yPos,cellSize,cellSize);
        }
      }
    }
  }
  
  public void addLayer(int[][] theLayer) {
    this.layer = theLayer;
  }
  
  public void showMines() {
    mines_shown = true;
  }
  
  public void hideMines() {
    mines_shown = false;
  }
  
  public Cell getCell(int xClicked, int yClicked) {
    xClicked -= x_pos;
    yClicked -= y_pos;
    int xAt = xClicked/cellSize;
    int yAt = yClicked/cellSize;
    
    return new Cell(yAt,xAt);
  }
  
  public int[] getCoords(int xClicked, int yClicked) {
    int[] coords = new int[2];
    xClicked -= x_pos;
    yClicked -= y_pos;
    coords[0] = yClicked/cellSize;
    coords[1] = xClicked/cellSize;
    return coords;
  }
  
  public int getRowId(int yClicked) {
    yClicked -= y_pos;
    int theRow = yClicked/cellSize;
    return theRow;
  }
  
  public int getColId(int xClicked) {
    xClicked -= x_pos;
    int theCol = xClicked/cellSize;
    return theCol;
  }
  
  public int getRows() {return rows;}
  public int getCols() {return cols;}
  
}
