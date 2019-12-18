Board theBoard;
BoardItem item1;
Mine theMine;
Mine[] mines;
ClickedSpace space;
Flag theFlag;

int[] mouseCoords;
int[][] mineData;
int[][] spaceData;
int[][] flagData;
int rowCount = 9;
int colCount = 9;
int mineCount = 10;
int positionMod = 3;
int positionMod2 = 8;
int spacesLeft;
boolean VALID;
boolean SPAWN_CHECK;
boolean CLICKED_MINE;
boolean FIRST_CLICK;
int rowCheck1;
int colCheck1;
int rowCheck2;
int colCheck2;
int mineProximity;
int mineX;
int mineY;
int time;
int timeStamp;
int flags;
int clickedRow;
int clickedCol;
int gameState;

void setup() {
  size(800,600);
  gameState = 0;
  FIRST_CLICK = true;
  spacesLeft = (rowCount*colCount) - mineCount;
  theBoard = new Board(width/positionMod,height/positionMod2,rowCount,colCount,25);
  mineData = new int[rowCount][colCount];
  spaceData = new int[rowCount][colCount];
  flagData = new int[rowCount][colCount];
  flags = 0;
  time = 0;
  timeStamp = millis();
  //Mine[] mines = new Mine[10];
  for (int i=0; i<rowCount; i++) {
    for (int j=0; j<colCount; j++) {
      mineData[i][j] = 0;
      spaceData[i][j] = 0;
      flagData[i][j] = 0;
    }
  }
  for (int i=0; i<mineCount; i++) {
    VALID = false;
    while (!VALID) {
      mineY = (int)random(rowCount);
      mineX = (int)random(colCount);
      if (mineData[mineY][mineX] == 0) {
        mineData[mineY][mineX] = 1;
        VALID = true;
      }
    }
  }
  for (int i=0; i<rowCount; i++) {
    for (int j=0; j<colCount; j++) {
      theMine = new Mine(i,j);
      if (mineData[i][j] == 1) {
        theBoard.addMine(theMine);
      }
    }
  }
}

void draw() {
  background(255);
  theBoard.show();
  if (spacesLeft == 0) {
    for (int i=0; i<rowCount; i++) {
      for (int j=0; j<colCount; j++) {
        if (flagData[i][j] != 1 && mineData[i][j] == 1) {
          theBoard.removeFlagAt(i,j);
          theFlag = new Flag(i,j,0);
          theBoard.flagSpace(theFlag);
          flags = mineCount;
        }
      }
    }
    gameState = 2;
  }
  if (gameState == 0 && !FIRST_CLICK) {
    if (millis() - timeStamp >= 1000 && time < 1000) {
      time++;
      timeStamp = millis();
    }
  }
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("E - Easy",width/2,500);
  text("M - Medium",width/2,525);
  text("H - Hard",width/2,550);
  text("Space - Restart (Same difficulty)", width/2,575);
  textSize(30);
  textAlign(LEFT);
  text("Mines: " + (mineCount - flags), 50, 520);
  textAlign(RIGHT);
  text("Time: "+time, width - 50, 520);
  if (gameState == 1) {
    textSize(30);
    textAlign(CENTER);
    text("Better luck next time!",width/2,450);
  } else if (gameState == 2) {
    textSize(30);
    textAlign(CENTER);
    text("Winner winner chicken dinner!",width/2,450);
  }
}

// Checks for any clicks with the mouse
void mousePressed() {
  mouseCoords = theBoard.getCoords(mouseX,mouseY);
  if (mouseButton == LEFT) {
    if (mouseX >= width/positionMod && mouseY >= height/positionMod2) {
      if (gameState == 0) {
        clickSpace(mouseCoords[0],mouseCoords[1]);
      }
    }
  } else if (mouseButton == RIGHT) {
    if (mouseX >= width/positionMod && mouseY >= height/positionMod2) {
      if (gameState == 0) {
        flagSpace(mouseCoords[0],mouseCoords[1]);
      }
    }
  }
}

// Checks if one of the restart keys is pressed
void keyPressed() {
  if (key == 'e' || key == 'E') {
    rowCount = 9;
    colCount = 9;
    mineCount = 10;
    positionMod = 3;
    positionMod2 = 8;
    setup();
  } else if (key == 'm' || key == 'M') {
    rowCount = 16;
    colCount = 16;
    mineCount = 40;
    positionMod = 4;
    positionMod2 = 30;
    setup();
  } else if (key == 'h' || key == 'H') {
    rowCount = 16;
    colCount = 30;
    mineCount = 99;
    positionMod = 32;
    positionMod2 = 30;
    setup();
  }
  if (keyCode == 32) {
    setup();
  }
}

// WHat the game does when a space is clicked
void clickSpace(int rowAt, int colAt) {
  rowAt = int(rowAt);
  colAt = int(colAt);
  if ((rowAt >= 0 && rowAt < rowCount) && (colAt >= 0 && colAt < colCount)) {
    if (spaceData[rowAt][colAt] == 0 && flagData[rowAt][colAt] != 1) {
      if (FIRST_CLICK) {
        FIRST_CLICK = false;
        timeStamp = millis();
      }
      spaceData[rowAt][colAt] = 1;
      flagData[rowAt][colAt] = 0;
      theBoard.removeFlagAt(rowAt,colAt);
      CLICKED_MINE = mineData[rowAt][colAt] == 1;
      mineProximity = 0;
      rowCheck1 = 1;
      rowCheck2 = 1;
      colCheck1 = 1;
      colCheck2 = 1;
      if (rowAt == 0)
        rowCheck1 = 0;
      if (rowAt == rowCount-1)
        rowCheck2 = 0;
      if (colAt == 0)
        colCheck1 = 0;
      if (colAt == colCount-1)
        colCheck2 = 0;
      for (int i=rowAt-rowCheck1; i<=rowAt+rowCheck2; i++) {
        for (int j=colAt-colCheck1; j<=colAt+colCheck2; j++) {
          if (mineData[i][j] == 1) {
            mineProximity++;
          }
        }
      }
      if (CLICKED_MINE) {
        gameState = 1;
        theBoard.showMines();
        checkFlags();
      } else {
        spacesLeft--;
      }
      space = new ClickedSpace(rowAt,colAt,mineProximity,CLICKED_MINE);
      theBoard.addSpace(space);
      if (mineProximity == 0) {
        clickSpace(rowAt-1,colAt-1);
        clickSpace(rowAt-1,colAt);
        clickSpace(rowAt-1,colAt+1);
        clickSpace(rowAt,colAt-1);
        clickSpace(rowAt,colAt+1);
        clickSpace(rowAt+1,colAt-1);
        clickSpace(rowAt+1,colAt);
        clickSpace(rowAt+1,colAt+1);
      }
    }
  }
}

// Places a flag on the space
void flagSpace(int rowAt, int colAt) {
  rowAt = int(rowAt);
  colAt = int(colAt);
  if ((rowAt >= 0 && rowAt < rowCount) && (colAt >= 0 && colAt < colCount)) {
    if (spaceData[rowAt][colAt] == 0) {
      if (FIRST_CLICK) {
        FIRST_CLICK = false;
        timeStamp = millis();
      }
      if (flagData[rowAt][colAt] == 0) {
        theFlag = new Flag(rowAt,colAt,0);
        flagData[rowAt][colAt] = 1;
        theBoard.flagSpace(theFlag);
        flags++;
      } else if (flagData[rowAt][colAt] == 1) {
        theFlag = new Flag(rowAt,colAt,1);
        theBoard.removeFlagAt(rowAt,colAt);
        theBoard.flagSpace(theFlag);
        flagData[rowAt][colAt] = 2;
        flags--;
      } else {
        theBoard.removeFlagAt(rowAt,colAt);
        flagData[rowAt][colAt] = 0;
      }
    }
  }
}

// Checks if a flag was placed properly if the player loses
void checkFlags() {
  for (int i=0; i<rowCount; i++) {
    for (int j=0; j<colCount; j++) {
      if (flagData[i][j] == 1 && mineData[i][j] == 0) {
        theBoard.removeFlagAt(i,j);
        theFlag = new Flag(i,j,2);
        theBoard.flagSpace(theFlag);
      }
      if (flagData[i][j] == 2 && mineData[i][j] == 1) {
        theBoard.removeFlagAt(i,j);
      }
    }
  }
}
