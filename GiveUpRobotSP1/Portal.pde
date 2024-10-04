class Portal{
 float x, y, w, h;
 float targetLocationX, targetLocationY;
 
 Portal(float x, float y, float w, float h, float targetLocationX, float targetLocationY){
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   this.targetLocationX = targetLocationX;
   this.targetLocationY = targetLocationY;
 }
 void display(){
   fill(38, 162, 237, 150);
   rectMode(CORNER);
   rect(x, y, w, h);
   rect(targetLocationX, targetLocationY, w, h);
 }
 boolean isCrossed(Robot robot){
   return (robot.x > x && robot.x < x + w && robot.y > y && robot.y < y + h); 
 }
}
