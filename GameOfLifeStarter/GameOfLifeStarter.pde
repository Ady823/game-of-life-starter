final int SPACING = 10; // each cell's width/height //<>// //<>//
final float DENSITY = 0.3; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() { //this runs once
  size(600, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  populateGrid();
  showGrid();
}

void draw() {
  // this operates at framerate
  showGrid();
  // grid is a global variable
  grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      // TODO: currently set to borders just never being set
     // if ((i == 0) /*|| (j == 0)*/) {
      //  nextGrid[i][j] = 0;
     // }
      if (grid[i][j] == 1) {
        if (countNeighbors(i, j) <= 3 && countNeighbors(i, j) >= 2) {
          nextGrid[i][j] = 1;
        } else {
          nextGrid[i][j] = 0;
        }
      } else {
        if ( countNeighbors (i, j) == 3) {
          nextGrid[i][j] = 1;
        } else {
          nextGrid[i][j] = 0;
        }
      }
    }
  }
  return nextGrid;
}

int countNeighbors(int y, int x) {
  int count = 0;

  //counting edge conditions
  /*if ((x == 0) && (y >= 1 && y < grid.length - 1)) {
    //count = above(count, y, x);
    //count = below(count, y, x);
    //count = right(count, y, x);
  }
  if ((x == grid.length - 1) && (y >= 1 && y < grid.length - 1)) {
  }

  if ((y == 0) && ((x >= 1 && x < grid.length - 1))) {
    count = sides(count, y, x);
    count = below(count, y, x);
  }
  if ((y == grid.length - 1) && (x >= 1 && x < grid.length - 1)) {
    count = sides(count, y, x);
    count = above(count, y, x);
  } */

  //for everything that is not an edge
  if ((y >= 1 && y < grid.length - 1) && (x >= 1 && x < grid.length - 1)) {
    count = sides(count, y, x);
    count = above(count, y, x);
    count = below(count, y, x);
  }
  return count;
}

void showGrid() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (grid[i][j] == 1) {
        fill(204, 153, 0);
      } else {
        fill(155, 0, 0);
      }
      square((i * SPACING), (j * SPACING), SPACING);
    }
  }
}

void populateGrid() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (Math.random() <= DENSITY) {
        grid[i][j] = 1;
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

int sides(int counted, int y, int x) {
  counted = left(counted, y, x);
  counted = left(counted, y, x);
  return counted;
}
int left(int counted, int y, int x) {
  if (grid[y][x - 1] == 1) {
    counted++;
  }
  return counted;
}
int right(int counted, int y, int x) {
  if (grid[y][x + 1] == 1) {
    counted++;
  }
  return counted;
}

int above(int counted, int y, int x) {
  for (int i = x - 1; i <= x + 1; i++) {
    if (grid[y - 1][i] == 1) {
      counted++;
    }
  }
  return counted;
}

int below(int counted, int y, int x) {
  for (int i = x - 1; i <= x + 1; i++) {
    if (grid[y + 1][i] == 1) {
      counted++;
    }
  }
  return counted;
}
