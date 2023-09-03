// Vaus - game paddle
class Vaus{
  PVector pos, vel;
  float w,h;
  
  Vaus(){
    this.pos = new PVector(width/2, height-100);
    this.vel = new PVector(5,2);
    this.w = 70;
    this.h = 15;
  }
  
  void move(){
    if(keyPressed){
      if(keyCode == LEFT && pos.x - vel.x >= 0){
        pos.x -= vel.x;
      } else if(keyCode == RIGHT && pos.x + vel.x <= width){
        pos.x += vel.x;
      } else if(keyCode == UP && pos.y - vel.y >= height - 110){
        pos.y -= vel.y;
      } else if(keyCode == DOWN && pos.y + vel.y <= height - 90){
        pos.y += vel.y;
      }
    }
  }
  
  void display(){
    fill(245,146,89);
    ellipse(pos.x-33,pos.y,h/2,h/2);
    ellipse(pos.x+33,pos.y,h/2,h/2);
    fill(198,196,196);
    rect(pos.x,pos.y, w,h);
  }
}
