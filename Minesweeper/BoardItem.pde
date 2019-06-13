public class BoardItem {
  protected int colId, rowId;
  protected int[][] glyphData;
  protected int fillColor;
  
  public BoardItem(int rowAt, int colAt) {
    this.rowId = rowAt;
    this.colId = colAt;
  }
  
  public void show(int xAt, int yAt, int cellSize) {
    strokeWeight(2.5);
    for(int row=0; row<glyphData.length; row++) {
      for(int col=0; col<glyphData[row].length; col++) {
        fillColor = glyphData[row][col];
        fill(fillColor);
        int x = xAt + col*cellSize;
        int y = yAt + row*cellSize;
        rect(x,y,cellSize,cellSize);
      }
    }
  }
  
  public void setData(int[][] data) {
    glyphData = data;
  }
  
  public Cell[] getVanguard(char direction) {
    ArrayList<Cell> result = new ArrayList<Cell>();
    
    if (direction == 'u') {
      for (int i=0; i<glyphData[0].length; i++) {
        if (glyphData[0][i] > -1) {
          int colVal = i + colId;
          int rowVal = rowId - 1;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    } else if (direction == 'd') {
      for (int i=0; i<glyphData[0].length; i++) {
        if (glyphData[0][i] > -1) {
          int colVal = i + colId;
          int rowVal = rowId + 1;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    } else if (direction == 'r') {
      for (int i=0; i<glyphData.length; i++) {
        if (glyphData[i][0] > -1) {
          int colVal = colId + 1;
          int rowVal = i + rowId;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    } else if (direction == 'l') {
      for (int i=0; i<glyphData.length; i++) {
        if (glyphData[i][0] > -1) {
          int colVal = colId - 1;
          int rowVal = i + rowId;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    }
    
    return result.toArray(new Cell[0]);
  }
  
  public int row() {return rowId;}
  public int col() {return colId;}
  
  
}
