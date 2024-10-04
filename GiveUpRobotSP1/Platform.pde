class Platform {
  float x, y, w, h;
  
  Platform(float x, float y, float w, float h){
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
   
  }
  void display() {
     fill(255, 150, 0); // Platform color
     rectMode(CORNER);
     rect(x, y, w, h); // Draws the platform
    }
}
