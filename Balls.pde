class Balls{
  PVector pos, vel;
  float radius;
  color ballColor;
  Balls(){
    this.pos = new PVector(width/2, height-125);
    this.vel = new PVector(random(-4,4), random(-6,-2));
    this.radius = 7.5;
    this.ballColor = color(#EAEA85);
  }
  
  void move(){
    pos.add(vel);
  }
  
  void edge_detect(){
    if(pos.x < 0 || pos.x > width){
      vel.x *= -1;
    } else if(pos.y < 0){
      vel.y *= -1;
    }
  }

  
  void removeBricks(ArrayList<PVector> bricks, ArrayList<Integer> colorArray, float[] size){
    float w = size[0];
    float h = size[1];
    for(int i = 0; i < bricks.size(); i++){
      PVector brick = bricks.get(i);
      float collision = checkCollision(brick, w, h);
      if(collision != 0){
        bricks.remove(i);
        colorArray.remove(i);
        score += 100;
        if(collision == 1){
          vel.x *= -1.2;
          vel.y *= 1.1;
        } else if (collision == 2){
          vel.x *= 1.2;
          vel.y *= -1.1;
        } else if (collision == 3){
          vel.x *= -1.2;
          vel.y *= -1.1;
        }
        vel.limit(8.0);
      }
    }
  }

  
  void hitVaus(Vaus v) {
    float collision = checkCollision(v.pos, v.w, v.h);
    if(collision != 0){
      float ballBottom = pos.y + radius;
      float vausTop = v.pos.y - v.h / 2;
      if (ballBottom >= vausTop && pos.y <= vausTop) {
        vel.y *= -1;
      }
    }
  }
  // Original Issue
  //void hitVaus(Vaus v) {
  //  float collision = checkCollision(v.pos, v.w, v.h);
  //  if(collision != 0){
  //      vel.y *= -1;
  //    }
  //  }
  
  float checkCollision(PVector rect, float w, float h){
    float distance_x = abs(pos.x - rect.x);
    float distance_y = abs(pos.y - rect.y);
    float cornerDistance = sqrt(sq(distance_x) + sq(distance_y));
    if(distance_x > (w/2 + radius)){
      return 0;
    } else if(distance_y > (h/2 + radius)){
      return 0;
    } else if(distance_x <= w/2 + radius && distance_y < h/2){
      return 1;
    } else if(distance_y <= h/2 + radius){
      return 2;
    } else if (cornerDistance <= radius + sqrt(sq(w/2) +sq(h/2))){
      return 3;
    } else {
      return 0;
    }
  }
  
  void display(){
    fill(ballColor);
    ellipse(pos.x, pos.y, radius,radius);
  }
}
