class Brick{
  ArrayList<PVector> bricks = new ArrayList<>();
  ArrayList<Integer> colorArray = new ArrayList<>();
  float w, h, dfw;
  int rows, cols;
  color[] colors;
  Brick(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    this.dfw = 50; // Distance from the birck to the walls
    this.w = (width - dfw*2)/cols;
    this.h = 30;
    this.colors = new color[rows];
    for(int i = 0; i < rows; i++){
      colors[i] = color(random(255),random(255),random(255));
    }
    createBricks();
    createBricksColor();
  }
  
  void createBricks(){
    for(float i = 0; i < rows; i++){
      for(float j = 0; j < cols; j++){
        float x = dfw + j * w + w/2;
        float y = dfw + i * h; 
        bricks.add(new PVector(x,y));
      }
    }
  }
  
  void createBricksColor(){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        colorArray.add(colors[i]);
      }
    }
  }
  
  float[] getSize(){
    return new float[]{w, h};
  }
  
  ArrayList<PVector> getBricks(){
    return bricks;
  }
  
  ArrayList<Integer> getBricksColor(){
    return colorArray;
  }
  
  void display(){
    for(int i = 0; i < bricks.size(); i++) {
      PVector brick = bricks.get(i);
      int brickcolor = colorArray.get(i);
      fill(brickcolor);
      rect(brick.x, brick.y, w, h);
    }
  }
}
