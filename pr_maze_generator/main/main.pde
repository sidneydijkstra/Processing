
int gridSize = 900;
Cell[] grid;

Cell current;
ArrayList<Cell> genStack;
ArrayList<Cell> serStack;
ArrayList<Cell> path;

Boolean doneGenerating = false;

void setup() {
  size(800, 800);

  grid = new Cell[gridSize*gridSize];

  for (int i = 0; i < grid.length; i++) {
    grid[i] = new Cell(i % gridSize, (i / gridSize)%gridSize);
  }
  grid[grid.length - 1].end = true;
  grid[0].start = true;

  genStack = new ArrayList<Cell>();
  serStack = new ArrayList<Cell>();
  path = new ArrayList<Cell>();

  current = grid[0];
  current.visited = true;
}

void draw() {
  background(200);
  frameRate(1000);

  if (!doneGenerating) { // generate maze
    while (!doneGenerating) {
      current.highlight();

      Cell next = getNeighbour(current);
      if (next != null) {
        current.openWalls(next);
        genStack.add(current);
        next.visited = true;
        current = next;
      } else {
        if (genStack.size()-2 <= 0) {
          current = genStack.get(0);

          // clear visited
          for (int i = 0; i < grid.length; i++) {
            grid[i].visited = false;
          }

          // add start solve node
          serStack.add(current);

          // stop generating maze
          doneGenerating = true;
          print("Generated Maze!");
        } else {
          current = genStack.get(genStack.size()-2);
          genStack.remove(genStack.size()-1);
        }
      }
    }
  } else { // solve maze
    for (int i = 0; i < grid.length; i++) { 
      grid[i].show();
    }

    if (path.size() > 0) {
      for (int i = 0; i < path.size(); i++) {
        Cell c = path.get(i);
        c.path();
        grid[0].path();
      }
      return;
    }

    while (path.size() <= 0) {

      ArrayList<Cell> tempStack = new ArrayList<Cell>();
      for (int i = 0; i < serStack.size(); i++) {
        Cell c = serStack.get(i);
        c.visited = true;

        ArrayList<Cell> next = getNeighbours(c);

        if (next == null) {
          continue;
        }

        for (int j = 0; j < next.size(); j++) {
          Cell n = next.get(j);
          n.parent = c;
          tempStack.add(n);

          if (n.end) {
            Cell s = n;
            while (!s.start) {
              path.add(s);
              s = s.parent;
            }
  
            print("\nSolved Maze!");
  
            for (int x = 0; x < grid.length; x++) {
              grid[x].visited = true;
            }

            return;
          }
        }
      }
      for (int i = 0; i < serStack.size(); i++) { 
        Cell c = serStack.get(i);
        c.highlight();
      }
      serStack = tempStack;
    }
  }
}

int index(int x, int y) {
  if (x < 0 || x > gridSize-1 || y < 0 || y > gridSize-1) {
    return -1;
  }

  int id = x + y * gridSize;
  return id;
}

// get random neighbour
Cell getNeighbour(Cell _cell) {
  ArrayList<Cell> neighbour = new ArrayList<Cell>();

  int top = index(_cell.x, _cell.y - 1);
  if (top != -1 && !grid[top].visited) {
    neighbour.add(grid[top]);
  }

  int right = index(_cell.x + 1, _cell.y);
  if (right != -1 && !grid[right].visited) {
    neighbour.add(grid[right]);
  }

  int bottom = index(_cell.x, _cell.y + 1);
  if (bottom != -1 && !grid[bottom].visited) {
    neighbour.add(grid[bottom]);
  }

  int left = index(_cell.x - 1, _cell.y);
  if (left != -1 && !grid[left].visited) {
    neighbour.add(grid[left]);
  }

  if (neighbour.size() <= 0) {
    return null;
  } else {
    return neighbour.get(floor(random(0, neighbour.size())));
  }
}

// get all neighbours
ArrayList<Cell> getNeighbours(Cell _cell) {
  ArrayList<Cell> neighbour = new ArrayList<Cell>();

  int top = index(_cell.x, _cell.y - 1);
  if (top != -1 && !grid[top].wBottom && !grid[top].visited) {
    neighbour.add(grid[top]);
  }

  int right = index(_cell.x + 1, _cell.y);
  if (right != -1 && !grid[right].wLeft && !grid[right].visited) {
    neighbour.add(grid[right]);
  }

  int bottom = index(_cell.x, _cell.y + 1);
  if (bottom != -1 && !grid[bottom].wTop && !grid[bottom].visited) {
    neighbour.add(grid[bottom]);
  }

  int left = index(_cell.x - 1, _cell.y);
  if (left != -1 && !grid[left].wRight && !grid[left].visited) {
    neighbour.add(grid[left]);
  }

  if (neighbour.size() <= 0) {
    return null;
  } else {
    return neighbour;
  }
}