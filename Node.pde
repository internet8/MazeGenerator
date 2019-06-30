class Node {
  public int x;
  public int y;
  public boolean visited = false;
  public Node parent;
  public ArrayList<Node> children = new ArrayList<Node>();
  
  public Node (int x, int y, Node parent, ArrayList<Node> children) {
    this.x = x;
    this.y = y;
    this.parent = parent;
    this.children = children;
  }
}
