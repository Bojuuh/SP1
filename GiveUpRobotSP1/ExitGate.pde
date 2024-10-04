class ExitGate{
   float x, y, w, h;
 
   ExitGate(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  
 }
   void display(){
     fill(0, 255, 0);
     rect(x, y, w, h);
   }
    boolean isCrossed(Robot robot){
     return (robot.x > x && robot.x < x + w && robot.y > y && robot.y < y + h); 
    }
}
