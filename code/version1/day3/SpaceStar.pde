/** Game Name: SpaceStar
 * Developer: Rye
 **/

/***********************
 Global Variables 
 ***********************/

/** Images in the Game **/
PImage playerSpaceship; // player's spaceship
PImage backgroundPic; // background image

/** X and Y Coordinates of the Player Spaceship **/
int playerSpaceshipX;
int playerSpaceshipY;

/** Y Coordinates of the Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game

/** Bullet Variables **/
int bulletX; // x position of the bullet
int bulletY; // y position of the bullet
Bullet bullet = new Bullet(); // bullet object
PImage bulletPic; // bullet image

void setup() {

  /*******************
   Setup of the Game
   *******************/

  size(700, 700); // size of the window
  background(0); // color of the background

  /** Player's Spaceship **/

  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(380, 260); // resizes the player's spaceship

  /** Initial Coordinates of the Player's Spaceship **/

  playerSpaceshipX = width-530;
  playerSpaceshipY = height-300;

  /** Background of the Game **/

  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background

  /** Bullet Images **/

  bulletPic = loadImage("bullet.png"); // loads the bullets image
  bulletPic.resize(15, 40); // resizes the bullet image

  screens = "Home"; // sets the game state to the home screen
}

void draw() {

  /******************************
   Main Draw Loop of the Game
   ******************************/

  backgroundStars(); // calls the background game screen function

  if (screens == "Home") {
    home();
  } // home screen ends
  else if (screens == "Play") {

    playScreen(); // calls play screen function  

    initalBulletPos(); // sets initial bullet position
    moveBullet(); // moves the bullet

    /*
    if (mousePressed) {
     bulletSpaceshipX(); // places the bullet at spaceship's x coordinate
     } // works only on mouse press
     */

    image(bulletPic, bulletX, bulletY); // places bullet image on screen
    print(bulletY + " ");

    /** Current Chapter Display **/
    textSize(20);
    text("Current Chapter: " + chapters, 5, 25);
  } // play screen ends
}

void backgroundStars() {

  /****************************************
   Background of the Game
   ***************************************/

  image(backgroundPic, 0, backgroundY);  // draws first background image on screen
  image(backgroundPic, 0, backgroundY-backgroundPic.height); // places second background image on screen

  backgroundY+=3; // scrolls through the background

  if (backgroundY >= backgroundPic.height) {
    backgroundY = 0;
  } // resets background once first image is fully moved through
}


void home() {

  /****************************************
   Home Screen
   ***************************************/

  if (mousePressed) {
    screens = "Play";
  }
}

void playScreen() {

  /****************************************
   Play Screen
   ***************************************/

  image(playerSpaceship, playerSpaceshipX, playerSpaceshipY); // draws the player's spaceship
  chapters = "The Start"; // the first chapter
}

void keyPressed() {

  /****************************************
   Performs Action Based on a Key Pressed
   ***************************************/

  /** Reaches the Extreme End Flags **/

  boolean atRightEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atLeftEndFlag = false; // flag if the player's spaceship reaches off the the screen

  /** Detect if the Spaceship is Moving Extremely Right or Left */

  if (playerSpaceshipX >= width-380) {
    atRightEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the right off the screen
  else if (playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the left off the screen

  /** Makes sure the Spaceship doesn't go off the screen **/

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

  /** If the Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/

  if (playerSpaceshipX < width-380 && playerSpaceshipX > 10 && atRightEndFlag == false && atRightEndFlag == false) {
    if (key == 'a' || key == 'A') {
      playerSpaceshipX -=10;
    } else if (key == 'd' || key == 'D') {
      playerSpaceshipX += 10;
    }
  }
}

void initalBulletPos() {

  /**********************************************
   Initial Bullet Coordinates
   **********************************************/

  bullet.initBulletPos(); // calls initial bullet position function

  /** Sets the X and Y Initial Coordinates **/
  bulletX = bullet.bulletPosX;
  bulletY = bullet.bulletPosY;
}

void moveBullet() {

  /**********************************************
   Moves the Bullet
   **********************************************/

  bulletY -= 5; // moves the bullet forward
}

void bulletSpaceshipX() {

  /**********************************************
   Places the Bullet at the Spaceship X Coordinate
   **********************************************/

  bullet.placeX(); // calls the place function
}
