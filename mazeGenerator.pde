import java.util.*; 

int sizeX, sizeY;
Node[][]maze;
Stack<Node> stack = new Stack<Node>();
Node currentNode;
boolean started = false;
boolean saved = false;
int iterations = 20; // determines how many times search method recurse
int iterationsStartVal = iterations;

void setup () {
  size(500, 500); // change this if you want to control the size of the maze
  sizeX = width/10;
  sizeY = height/10;
  maze = new Node[sizeX][sizeY];
  strokeWeight(1);
  frameRate(60);
  for (int i = 0; i < sizeX; i++) {
    for (int j = 0; j < sizeY; j++) {
      maze[i][j] = new Node(i, j, null, null);
    }
  }
  currentNode = maze[0][0];
  started = true;
  background(255);
  fill(255, 0, 0);
  rect(0, 0, 10, 10);
  fill(0, 255, 0);
  rect(width-10, height-10, 10, 10);
}

void draw () {
  if (!stack.isEmpty() || started) { 
    started = false;
    search(currentNode);
  }
  if ((stack.isEmpty() && !started) && !saved) {
    saved = true;
    saveFrame("yourMaze.png");
  }
}

public void search (Node n) {
  boolean found = false;
  boolean added = false;
  boolean drawWhite = true;
  n.children = getChildren(n.x, n.y);
  Collections.shuffle(n.children);
  for (Node child : n.children) {
    if (!child.visited) {
      if (!added) {
        added = true;
        stack.push(child);
        child.visited = true;
        child.parent = n;
        currentNode = child;
        found = true;
      }
      stroke(0);
      n.x = n.x*10;
      n.y = n.y*10;
      child.x = child.x*10;
      child.y = child.y*10;
      if (n.x < child.x) {
        line(n.x+10, n.y, n.x+10, n.y+10);
      } else if (n.x > child.x) {
        line(n.x, n.y, n.x, n.y+10);
      } else if (n.y < child.y) {
        line(n.x, n.y+10, n.x+10, n.y+10);
      } else {
        line(n.x, n.y, n.x+10, n.y);
      }
      n.x = n.x/10;
      n.y = n.y/10;
      child.x = child.x/10;
      child.y = child.y/10;
    } else if (drawWhite) {
      drawWhite = false;
      stroke(255);
      n.x = n.x*10;
      n.y = n.y*10;
      n.parent.x = n.parent.x*10;
      n.parent.y = n.parent.y*10;
      if (n.x < n.parent.x) {
        line(n.x+10, n.y, n.x+10, n.y+10);
      } else if (n.x > n.parent.x) {
        line(n.x, n.y, n.x, n.y+10);
      } else if (n.y < n.parent.y) {
        line(n.x, n.y+10, n.x+10, n.y+10);
      } else {
        line(n.x, n.y, n.x+10, n.y);
      }
      n.x = n.x/10;
      n.y = n.y/10;
      n.parent.x = n.parent.x/10;
      n.parent.y = n.parent.y/10;
    }
  }
  if (!found && !stack.isEmpty()) {
    currentNode = stack.pop();
  }
  if (iterations == 0) {
    iterations = iterationsStartVal;
  } else {
    iterations --;
    search(currentNode);
  }
}

public ArrayList<Node> getChildren (int x, int y) {
  ArrayList<Node> result = new ArrayList<Node>();
  if (x-1 >= 0) {
    result.add(maze[x-1][y]);
  }
  if (y-1 >= 0) {
    result.add(maze[x][y-1]);
  }
  if (x+1 <= sizeX-1) {
    result.add(maze[x+1][y]);
  }
  if (y+1 <= sizeY-1) {
    result.add(maze[x][y+1]);
  }
  return result;
}
