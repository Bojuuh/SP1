Robot robot;
Portal portal;
ExitGate exitGate;
Jetpack jetpack;

int robotSpeed = 5;
float gravity = 0.6;
float jumpStrength = -16; // How high the robot jumps
float jumpSpeed = 0; // How fast robot jumps - initially at 0
boolean leftArrowPressed = false;
boolean rightArrowPressed = false;
boolean upArrowPressed = false;
boolean onGround = false;
int currentLevel = 3;
boolean levelCompleted = false;

ArrayList<Platform> platforms;

void setup() {
  size(1300, 760);
  textSize(24);

  robot = new Robot(width/15, height-50);
  loadLevel(currentLevel);
}

void loadLevel(int level){
  platforms = new ArrayList<Platform>();
  
  if (level == 1){
    platforms.add(new Platform(150, height - 100, 100, 20));
    platforms.add(new Platform(300, height - 280, 150, 280));
    platforms.add(new Platform(600, height - 280, 100, 280));
    platforms.add(new Platform(900, height - 360, 100, 360));
    
    exitGate = new ExitGate(width - 50, height - 100, 30, 80);
  }
  else if (level == 2){
    robot.x = width/15;
    robot.y = height - 50;
    platforms.add(new Platform(150, height - 100, 100, 20));
    platforms.add(new Platform(300, height - 280, 150, 280));
    platforms.add(new Platform(1070, height - 620, 330, 700));
    
    portal = new Portal(800, height-80, 45, 80, 1100, height - 700);
    
    exitGate = new ExitGate(width - 45, height - 700, 45, 80);
  }
  else if (level == 3){
    robot.x = width/15;
    robot.y = height - 645;
    platforms.add(new Platform(0, height-600, 200, 600));
    platforms.add(new Platform(350, -300, 200, 900));
    platforms.add(new Platform(700, height-600, 200, 600));
    platforms.add(new Platform(1050, -300, 300, 900));
    exitGate = new ExitGate(width - 50, height - 100, 30, 80);
    jetpack = new Jetpack(350, 0, width, height);
    
  }
}

void draw() {
  background(0);
  robotMovement();
  robot.display();
  //checkJetpack();

  // Display platforms
  for (Platform p : platforms) {
    p.display();
  }
  if (portal != null){
    portal.display();
  }
  
  if (exitGate != null) exitGate.display();
    fill(0, 255, 0);
    text("Level " + currentLevel + ": reach the green finish line", 10, 30);
  
  if (currentLevel == 1){
    text("Use left and right arrow key to move", 10, 55);
    text("Use up arrow key to jump!", 10, 80);
  }
  if (currentLevel == 2){
    text("Walk through the blue portal to teleport", 10, 55);
  }
  if (currentLevel == 3){
     text("Yellow area allows you to jetpack!", 10, 55);
     jetpack.display();
  }
  
  checkExitGate();
  checkPortal();
}

void checkExitGate() {
  if (exitGate != null && exitGate.isCrossed(robot)) {
    currentLevel++;
    loadLevel(currentLevel);
  }
}

void checkPortal() {
  if (portal != null && robot.x > portal.x && robot.x < portal.x + portal.w
      && robot.y > portal.y && robot.y < portal.y + portal.h) {
        robot.x = portal.targetLocationX;
        robot.y = portal.targetLocationY;
  }
}

void checkJetpack(){
   if (jetpack.isActivated(robot)){
      if (upArrowPressed){
         jumpSpeed = jumpSpeed-1;
         onGround = true;
      }
      else {
         jumpSpeed += gravity * 0.2; 
      }
      onGround = false;
   }
}
