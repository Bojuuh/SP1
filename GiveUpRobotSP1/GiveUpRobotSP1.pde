Robot robot;
int robotSpeed = 5;
float gravity = 0.6;
float jumpStrength = -16; // How high the robot jumps
float jumpSpeed = 0; // How fast robot jumps - initially at 0
boolean leftArrowPressed = false;
boolean rightArrowPressed = false;
boolean upArrowPressed = false;
boolean onGround = false;
int currentLevel = 1;
boolean levelCompleted = false;
float finishX, finishY, finishW, finishH; // Level completed coordinates + width and height

ArrayList<Platform> platforms;

void setup() {
  size(1300, 760);
  textSize(24);

  robot = new Robot(width/15, height-50);
  loadLevel(currentLevel);
  // platforms = new ArrayList<Platform>();
  //platforms.add(new Platform(width/6, height-70, 100, 20));
  //platforms.add(new Platform(width/3, height - 270, 150, 10));
  //platforms.add(new Platform(width/2, height - 45, 100, 20));
  //platforms.add(new Platform(width/1.6, height - 100, 100, 10));
}

void loadLevel(int level){
  platforms = new ArrayList<Platform>();
  
  if (level == 1){
    text("Use left and right arrow key to move", 10, 55);
    text("Use up arrow key to jump!", 10, 80);
    platforms.add(new Platform(150, height-100, 100, 20));
    platforms.add(new Platform(width/3, height - 270, 150, 10));
    platforms.add(new Platform(width/2, height - 45, 100, 20));
    platforms.add(new Platform(width/1.6, height - 100, 100, 10));
    
    finishX = width - 50;
    finishY = height - 100;
    finishW = 30;
    finishH = 80;
  }
}

void draw() {
  background(0);
  robotMovement();
  robot.display();

  // Display platforms
  for (Platform p : platforms) {
    p.display();
  }
  
  fill(0, 255, 0);
  rect(finishX, finishY, finishW, finishH);
  text("Level " + currentLevel + ": reach the green finish line", 10, 30);
  
  checkFinishLine();
}
