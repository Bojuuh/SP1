// Define the Robot class
class Robot {
  float x, y; // Position of the robot

  // Constructor to initialize the position
  Robot(float x, float y) {
    this.x = x;
    this.y = y;
  }

  // Method to display the robot
  void display() {
    rectMode(CENTER);
    
    // Draw Robot's head
    if (facingRight){
      noStroke();
      fill(250, 215, 237);
      rect(x, y, 30, 25); // Head
      rect(x - 3, y - 15, 3, 7); // Antenna 
      fill(141, 255, 116);
      rect(x - 6, y - 20, 5, 5); // Green square by antenna
      fill(229, 167, 206);
      rect(x, y, 23, 18); // Face
      fill(141, 255, 116);
      rect(x + 10, y - 2, 20, 15); // Visor
  
      // Draw Robot's body
      fill(229, 167, 206);
      rect(x, y + 26, 30, 20); // Body
      rect(x - 5, y + 14, 5, 5); // Left pixel on neck
      rect(x + 5, y + 14, 5, 5); // Right pixel on neck
      rect(x - 17, y + 27, 5, 10); // Left arm
      rect(x + 17, y + 27, 5, 10); // Right arm
      rect(x, y + 38, 20, 5); // Lower body rect
      rect(x, y + 42, 10, 5); // Feet
      fill(250, 215, 237);
      rect(x, y + 20, 7, 18); // Neck
    }
    else{
        noStroke();
            fill(250, 215, 237);
            rect(x, y, 30, 25); // Head
            rect(x + 3, y - 15, 3, 7); // Antenna
            fill(141, 255, 116);
            rect(x + 6, y - 20, 5, 5); // Green square by antenna
            fill(229, 167, 206);
            rect(x, y, 23, 18); // Face
            fill(141, 255, 116);
            rect(x - 10, y - 2, 20, 15); // Visor
            fill(229, 167, 206);
            rect(x, y + 26, 30, 20); // Body
            rect(x + 5, y + 14, 5, 5); // Right pixel on neck
            rect(x - 5, y + 14, 5, 5); // Left pixel on neck
            rect(x + 17, y + 27, 5, 10); // Right arm
            rect(x - 17, y + 27, 5, 10); // Left arm
            rect(x, y + 38, 20, 5); // Lower body rect
            rect(x, y + 42, 10, 5); // Feet
            fill(250, 215, 237);
            rect(x, y + 20, 7, 18); // Neck
    }
  }
}

  void keyPressed() {
    if (keyCode == LEFT) {
        leftArrowPressed = true;
    }
    if (keyCode == RIGHT) {
        rightArrowPressed = true;
    }
    if (keyCode == UP && onGround){
        upArrowPressed = true; 
    }
}

void keyReleased() {
    if (keyCode == LEFT) {
        leftArrowPressed = false;
    }
    if (keyCode == RIGHT) {
        rightArrowPressed = false;
    }
    if (keyCode == UP){
        upArrowPressed = false; 
    }
}
boolean facingRight = true;
void robotMovement() {
    // Horizontal movement
    if (leftArrowPressed && !rightArrowPressed) {
        robot.x -= robotSpeed; 
        facingRight = false;
    }
    else if (rightArrowPressed && !leftArrowPressed) {
        robot.x += robotSpeed;
        facingRight = true;
    }
    
     // Jump
    if (upArrowPressed){
        jumpSpeed = jumpStrength;
        onGround = false;
        upArrowPressed = false;
    }
    
    
    // Applies gravity to jumpSpeed
    jumpSpeed += gravity;
    robot.y += jumpSpeed;
    
    checkCollision();
    
    // Checking if robot is on the ground
    if (robot.y >= height - 45){
     robot.y = height - 45;
     jumpSpeed = 0;
     onGround = true;
    }
}


void checkFinishLine(){
   if (robot.x > finishX && robot.x < finishX + finishW && robot.y > finishY 
       && robot.y < finishY + finishH){
      currentLevel++;
      loadLevel(currentLevel);
  }
}
void checkCollision(){
  onGround = false;

  for (Platform p : platforms){
    // Check overlaps with platform p
    if (robot.x < 20 + p.x + p.w && robot.x + 20 > p.x && // Check horizontal overlap
        robot.y < p.y + p.h*2 && robot.y + 45 > p.y) {  // Check vertical overlap
      // Calculate overlaps
      float overlapX = min(robot.x + 20 - p.x, p.x + p.w - robot.x);
      float overlapY = min(robot.y + 45 - p.y, p.y + p.h*2 - robot.y);

      if (overlapX < overlapY) {
        // Horizontal collision: stop horizontal movement
        if (robot.x < 20 + p.x + p.w / 2) {
          // Robot is hitting the left side of the platform
          robot.x = p.x - 20;  // Move robot outside the platform (left)
        } else {
          // Robot is hitting the right side of the platform
          robot.x = p.x + p.w + 20;  // Move robot outside the platform (right)
        }
      } else {
        // Vertical collision: stop vertical movement
        if (robot.y < p.y) {
          // Robot is landing on top of the platform
          robot.y = p.y - 45;  // Correct position to sit exactly on top of the platform
          jumpSpeed = 0;       // Stop downward movement
          onGround = true;     // Robot is now on the ground (on a platform)
        } else {
          // Robot is hitting the bottom of the platform
          robot.y = p.y + p.h*2;  // Move robot below the platform
        }
      }
    }
  println("Robot X: " + robot.x + "Platform X : " + p.x);
  }
}
