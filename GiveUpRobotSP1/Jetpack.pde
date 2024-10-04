class Jetpack {
  float x, y, w, h;

  
  Jetpack(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(255, 255, 0, 90);
    rect(x, y, w, h);
  }

  boolean isActivated(Robot robot) {
    return (robot.x > x && robot.x < x + w && robot.y > y && robot.y < y + h);
  }
}
