/** Game Name: SpaceStar
 * Developer: Rye
 **/

/****************************************
 ****
 Main Class
 ****
 ***************************************/

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Global Variables
 ***
 **************************************/

/** Images in the Game **/
PImage home; // home screen image
PImage playerSpaceship; // player's spaceship
PImage backgroundPic; // background image
PImage[] bulletPics; // bullet pictures
PImage enemySpaceship; // enemy's spaceship

/** X and Y Coordinates of the Player Spaceship **/
int playerSpaceshipX;
int playerSpaceshipY;

/** Y Coordinates of the Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game

/** Player Bullet Variables **/
int playerBulletX; // x position of the bullet (player)
int playerBulletY; // y position of the bullet (player)
int playerBulletSpeed; // speed of the bullet (player)
int currentPlayerBullet = 0; // current player bullet
Bullet playerBullet; // bullet object (player)
boolean playerShot; // player has shot or not

/** Enemy Object **/
Enemy enemy; // enemy object

/** X and Y Coordinates of the Enemy Spaceship **/
float enemySpaceshipX;
float enemySpaceshipY;

/** Enemy Bullet Variables **/
int enemyBulletX; // x position of the bullet (enemy)
int enemyBulletY; // y position of the bullet (enemy)
int enemyBulletSpeed; // speed of the bullet (enemy)
Bullet enemyBullet; // bullet object (enemy)

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Setup of the Game
 ***
 **************************************/

void setup() {

  size(870, 680); // size of the window
  background(0); // color of the background

  /** Player's Spaceship **/
  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(380, 260); // resizes the player's spaceship

  /** Enemy Object Initialization **/
  enemy = new Enemy(); // initializes the enemy object

  /** Enemy's Spaceship **/
  enemySpaceship = loadImage("enemy.png"); // loads the enemy's spaceship
  enemySpaceship.resize(250, 200); // resizes the enemy's spaceship
  initEnemySpaceshipPos(); // initial enemy spaceship position

  /** Initial Coordinates of the Player's Spaceship **/
  playerSpaceshipX = width-600;
  playerSpaceshipY = height-250;

  /** Background of the Game **/
  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background

  /** Home Screen **/
  home = loadImage("home.png"); // loads the home screen image

  /** Bullet **/
  playerBullet = new Bullet(); // initializes the bullet object
  playerInitalBulletPos(); // sets initial bullet position
  bulletPics = new PImage[5]; // 5 bullets given to the player at a time
  createBullets(); // creates the bullets

  /** Game Screens **/
  screens = "Home"; // sets the game state to the home screen
  chapters = "Start"; // first chapter is set to "The Start"
}

/************************************
 ***
 Main Draw Loop of the Game
 ***
 **************************************/

void draw() {

  backgroundStars(); // calls the background game screen function

  if (screens == "Home") {
    image(home, 0, 0); // loads home screen image

    /** Current Chapter Display **/
    textSize(20);
    text("Current Chapter: " + chapters, 5, 25);
  } // home screen ends
  else if (screens == "Play") {

    playScreen(); // calls play screen function

    speedBullet(); // bullet speed function
    playerBulletY += playerBulletSpeed; // moves the bullet forward

    image(bulletPics[currentPlayerBullet], playerBulletX, playerBulletY); // places bullet image on screen
    print(playerBulletY + " ");
  } // play screen ends
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 In game Screens Functions
 ***
 **************************************/


void backgroundStars() {

  /****************************************
   Background of the Game
   ***************************************/

  /** Background Image **/
  image(backgroundPic, 0, backgroundY);  // draws first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places second background image on screen

  backgroundY+=3; // scrolls through the background

  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  } // resets background once first image is fully moved through
}

void playScreen() {

  /****************************************
   Play Screen
   ***************************************/

  image(playerSpaceship, playerSpaceshipX, playerSpaceshipY); // draws the player's spaceship
  image(enemySpaceship, enemySpaceshipX, enemySpaceshipY); // draws the enemy's spaceship

  moveEnemySpaceship(); // moves the enemy spaceship

  /** Current Chapter Display **/
  textSize(20);
  text("Current Chapter: " + chapters, 5, 25);
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Key Press/Mouse Press Functions
 ***
 **************************************/

void keyPressed() {

  /****************************************
   Performs Action Based on a Key Press
   ***************************************/

  if (key == 32 && screens == "Home") {
    screens = "Play";
  } // sets the screen to play with spacebar press from the home screen

  /** Reaches the Extreme End Flags **/

  boolean atRightEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atLeftEndFlag = false; // flag if the player's spaceship reaches off the the screen

  /** Detect if the Player's Spaceship is Moving Extremely Right or Left **/

  if (playerSpaceshipX >= width-380) {
    atRightEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the right off the screen
  else if (playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the left off the screen

  /** Makes sure the Player's Spaceship doesn't go off the screen **/

  if (atRightEndFlag) {
    if (key == 'd' || key == 'D') {
      playerSpaceshipX +=0;
    } else if (key == 'a' || key == 'A') {
      playerSpaceshipX -=10;
    }
  } else if (atLeftEndFlag) {
    if (key == 'a' || key == 'A') {
      playerSpaceshipX -= 0;
    } else if (key == 'd' || key == 'D') {
      playerSpaceshipX +=10;
    }
  }

  /** ONLY If the Player's Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/

  if (playerSpaceshipX < width-380 && playerSpaceshipX > 10 && atRightEndFlag == false && atRightEndFlag == false) {
    if (key == 'a' || key == 'A') {
      playerSpaceshipX -=10;
    } else if (key == 'd' || key == 'D') {
      playerSpaceshipX += 10;
    }
  }
}

void mouseReleased() {

  /****************************************
   Performs Action Based on Mouse Release
   ***************************************/

  if (screens == "Play") {
    playerShootBullet(); // function to shoot the bullet
    playerShot = true; // player shot is set to true
  } // shoots the bullet, only with mouse press, and in one of the play screens (or chapters)
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Bullet Functions
 ***
 **************************************/

void createBullets() {

  /**********************************************
   Creates Bullets for the Player to Use
   **********************************************/

  for (int s = 0; s < 5; s++) {
    bulletPics[s] = loadImage("bullet.png"); // loads the bullet images
    bulletPics[s].resize(15, 40); // resizes the bullet images
  } // creates bullets
}


void playerInitalBulletPos() {

  /**********************************************
   Initial Bullet Coordinates of the Player
   **********************************************/

  playerBullet.playerInitBulletPos(); // calls initial bullet position function

  /** Sets the X and Y Initial Coordinates of the Bullet **/
  playerBulletX =  playerBullet.playerBulletPosX;
  playerBulletY =  playerBullet.playerBulletPosY;

  /** Sets the Initial Bullet's Speed **/
  playerBulletSpeed = playerBullet.playerBulletSpeed;
}

void speedBullet() {

  /**********************************************
   Moves the Bullet Forward
   **********************************************/

  playerBulletSpeed--; // moves the bullet forward

  if (playerShot && screens == "Play") {
    playerBulletSpeed = playerBullet.playerBulletSpeed; // player's bullet speed is given the value 1
    playerShot = false; // player shot is set to false
  } // resets the speed of the bullet when a new one is shot
  else if (playerBulletY <= -1) {
    playerBulletSpeed = 0; // sets the player's bullet speed to 0
  } // stop the player's bullet speed from moving once it goes off the screen
}

void playerShootBullet() {

  /**********************************************
   Shoots the Bullet from the Player's Spaceship
   **********************************************/

  playerBullet.playerShoot(); // calls the place x bullet function

  /** Sets the X and Y Coordinates of the Updated Position to Shoot the Bullet **/
  playerBulletX =  playerBullet.playerBulletPosX; // updates the bullet x position to the new one
  playerBulletY =  playerBullet.playerBulletPosY; // updates the bullet y position to the new one

  currentPlayerBullet++; // increments the current bullet being used to the next one
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Enemy's Functions
 ***
 **************************************/


void initEnemySpaceshipPos() {

  /**********************************************
   Initial Coordinates of the Enemy's Spaceship
   **********************************************/

  enemy.initEnemyPos(); // calls the function to set the initial X and Y

  /** Sets the X and Y Coordinates in This Class **/
  enemySpaceshipX = enemy.enemySpaceshipPosX;
  enemySpaceshipY = enemy.enemySpaceshipPosY;
}

void moveEnemySpaceship() {

  /**********************************************
   Moves the Enemy's Spaceship
   **********************************************/

  enemy.moveEnemySpaceship(); // calls the function to move the enemy spaceship
  enemySpaceshipX = enemy.enemySpaceshipPosX; // sets the new x coordinate
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
