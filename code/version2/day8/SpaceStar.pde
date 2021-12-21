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
PImage blurredHome; // blurred home screen
PImage playerSpaceship; // player's spaceship
PImage enemySpaceship; // enemy's spaceship
PImage backgroundPic; // background image
PImage[] playerBullets; // bullet image array (player)
PImage[] enemyBullets; // bullet image array (enemy)
PImage playButton; // play button image

/** Home **/
boolean blurredHomeWanted; // checks to see if the blurred home screen is wanted or not

/** Player **/
Player player; // player object

/** Background **/
int backgroundY; // y axis of the background image

/** Screens and Chapters of the Game **/
String screens; // screens of the game
String chapters; // chapters of the game
boolean chapterChange; // chapter change is seen or not

/** Player's Bullet **/
Bullet playerBullet; // bullet object (player)
int currentPlayerBullet; // current bullet being used by the player
int minPosPlayerBulletY; // minimum position the player's bullet must reach in order to fire the next one
int playerShootTime; // player shoot time after the play button is clicked

/** Enemy **/
Enemy enemy; // enemy object

/** Enemy's Bullet **/
Bullet enemyBullet; // bullet object (enemy)
int currentEnemyBullet; // current bullet being used by the enemy
int minPosEnemyBulletY; // minimum position the enemy's bullet must reach in order to fire the next one
int enemyCurShootTime; // current time to determine when to shoot the enemy bullet
boolean enemyReduceLife; // reduce life of enemy or not

/** Asteroid **/
Asteroid asteroidObj; // asteroid object
int minAsteroidPos; // minimum position asteroid has to reach before re-generating

/** Play Button **/
int playButtonX; // x coordinate of the button
int playButtonY; // y coordinate of the button
int playButtonW; // width of the button
int playButtonH; // height of the button

/** Name Input **/
ArrayList<TextBox> textboxes = new ArrayList<TextBox>(); // array list of text boxes
boolean send;
String name = ""; // name of the player
public String finalName = ""; // final saved name

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 Setup of the Game
 ***
 **************************************/

void setup() {

  size(870, 680); // size of the window

  /** Home Screen **/
  home = loadImage("home.png"); // loads the home screen image
  blurredHome = loadImage("blurredHome.png"); // loads the blurred home screen image
  blurredHomeWanted = true; // blurred home is wanted

  /** Background of the Game **/
  backgroundPic = loadImage("background.png"); // loads the background image
  backgroundY = 0; // y coordinate of the background

  /** Player **/
  player = new Player(100, width-600, height-250);
  playerSpaceship = loadImage("playerSpaceship.png"); // loads the player's spaceship
  playerSpaceship.resize(380, 260); // resizes the player's spaceship

  /** Player's Bullet **/
  playerBullet = new Bullet(); // initializes the player bullet object
  playerBullet.playerInitBulletPos(); // sets the initial player bullet position
  currentPlayerBullet = 0; // current player bullet is 0 (first one)
  minPosPlayerBulletY = -500; // minimum position for player's bullet to reach before shooting a new one
  playerBullets = new PImage[6]; // initializes the bullet image array (player)
  playerBullet.playerCreateBullets(); // creates the bullets image array (player)

  /** Enemy **/
  enemy = new Enemy(100, width-545, height-655); // initializes the enemy object
  enemySpaceship = loadImage("enemySpaceship.png"); // loads the enemy's spaceship
  enemySpaceship.resize(250, 200); // resizes the enemy's spaceship

  /** Enemy's Bullet **/
  enemyBullet = new Bullet(); // initializes the enemy bullet object
  currentEnemyBullet = 0; // current player bullet is 0 (first one)
  minPosEnemyBulletY = 1180; // minimum position for enemy's bullet to reach before shooting a new one
  enemyBullets = new PImage[6]; // initializes the bullet image array (enemy)
  enemyBullet.enemyCreateBullets(); // creates the bullets image array (enemy)
  enemyCurShootTime = 0; // current enemy shoot time is set to 0
  enemyReduceLife = true; // allowed to reduce enemy's life

  /** Asteroid **/
  asteroidObj = new Asteroid(width-720, height-50, 1); // asteroid object is created
  asteroidObj.createAsteroids(); // creates asteroids
  asteroidObj.initAsteroidPos(); // function to randomly generate asteroid y values

  /** Play Button **/
  playButton = loadImage("playButton.png"); // play button is loaded in
  playButton.resize(275, 55); // resizes the play button
  playButtonX = width-545; // x coordinate of the button initialized
  playButtonY = height-250; // y coordinate of the button initialized
  playButtonW = playButton.width; // width of the button initialized
  playButtonH = playButton.height; // height of the button initialized

  /** Game States **/
  chapters = "Start"; // first chapter is set to "The Start"

  /** Name Input **/
  textInitLayout(); // layout of the textbox
  send = false; // send is initially false
} // end setup


/************************************
 ***
 Main Draw Loop of the Game
 ***
 **************************************/

void draw() {

  if (screens == "Home" || screens == "Play") {
    backgroundStars(); // calls the background game screen function
  }
  if (blurredHomeWanted) {
    image(blurredHome, 0, 0); // places the blurred home screen

    /** Name Text **/
    textSize(50);
    fill(255);
    text("Enter Your Name: ", 150, (height/2)-100);
    for (TextBox t : textboxes) {
      t.DRAW();
    } // draws the textbox
  }

  if (screens == "Home") {
    home(); // calls home screen function
  } // home screen ends
  else if (screens == "Play") {
    playScreen(); // calls play screen function
  } // play screen ends
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 In game Screens Functions
 ***
 **************************************/

void home() {

  /****************************************
   Home Screen
   ***************************************/

  image(home, 0, 0); // loads home screen image

  /** Name Display **/
  textSize(18);
  text("Player: " + finalName, width-865, height-625);

  image(playButton, playButtonX, playButtonY);

  if (send) {
    text(name, (width - textWidth(name)) / 2, 260);
  }

  if (mousePressed) {
    if (mouseX>playButtonX && mouseX <playButtonX+playButtonW && mouseY>playButtonY && mouseY <playButtonY+playButtonH) {
      playerShootTime = millis(); // player shoot time starts measuring the time
      enemyCurShootTime = millis(); // enemy shoot time starts measuring the time
      screens = "Play"; // changes game state
    }
  } // play button is clicked

  /** Current Chapter Display **/
  text("Current Chapter: " + chapters, width-865, height-655);
}

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

  /** Current Chapter Display **/
  textSize(18);
  text("Current Chapter: " + chapters, width-865, height-655);

  /** Name Display **/
  text("Player: " + finalName, width-865, height-625);

  /** Generate Player and Enemy Spaceships **/
  image(playerSpaceship, player.playerSpaceshipX, player.playerSpaceshipY); // draws the player's spaceship
  image(enemySpaceship, enemy.enemySpaceshipX, enemy.enemySpaceshipY); // draws the enemy's spaceship

  enemy.moveEnemySpaceship(); // calls the function to move the enemy spaceship

  /** Asteroids **/
  asteroidObj.asteroidMechanics(); // mechanics of the asteroid

  if (currentPlayerBullet < 6) {

    /** Moves the Player's Bullet **/
    playerBullet.playerSpeedBullet(); // bullet speed function (player)

    image(playerBullets[currentPlayerBullet], playerBullet.playerBulletPosX, playerBullet.playerBulletPosY); // places bullet image on screen (player)

    playerBullet.playerBulletCollide(); // function to see if player's bullet collides with the enemy's spaceship
  }// stop firing once mag has finished

  /** Player Life Left **/
  if (player.playerLifeLeft > 0) {
    textSize(14);
    fill(255);
    text("Player Life Left: " + player.playerLifeLeft, width-860, height-50);
  } // player is alive
  else {
    textSize(14);
    text("Player is Dead", width-860, height-50);
  } // player has died

  if ((millis() - enemyCurShootTime > 2000) && (player.playerLifeLeft > 0) && (enemy.enemyLifeLeft > 0)) {

    enemyBullet.enemyShoot(); // calls the shoot bullet function

    image(enemyBullets[currentEnemyBullet], enemyBullet.enemyBulletPosX, enemyBullet.enemyBulletPosY); // places bullet image on screen (enemy)

    enemyBullet.enemyBulletCollide(); // function to see if enemy's bullet collides with the player's spaceship

    currentEnemyBullet++; // increments the current bullet being used to the next one

    if (currentEnemyBullet == 4) {
      currentEnemyBullet = 0; // resets enemy laser
    } // reloads enemy laser

    enemyCurShootTime = millis(); // updates enemy shoot time
  } // shoot the enemy bullet after 1 second

   /** Enemy Life Left **/
  if (enemy.enemyLifeLeft < 0) {
    textSize(14);
    fill(255);
    text("Enemy Life Left: " + enemy.enemyLifeLeft, width-120, height-655);
  } // enemy is alive
  else {
    text("Enemy is Dead", width-120, height-655);
    if (chapters == "Start" || chapters == "Carry on The Legacy") {
      homePlanetY = height-950; // brings home planet y on the screen
      enemy.enemySpaceshipY = -500; // moves the enemy spaceship off the screen
      allowPlayerYMovement = true; // player y movement is allowed
      asteroidDoDmg = false; // asteroid is not allowed to do damage
    } else {
      // GAME FINISHED SCREEN
    }
  } // enemy has died
}

void resetElements() {

  /********************************************
   Resets the Elements of the Game
   ********************************************/

  player.playerLifeLeft = 100;
  enemy.enemyLifeLeft = 100;
  asteroidObj.asteroidX = width-720;
  enemy.enemySpaceshipX = width-545;
  enemy.enemySpaceshipY =  height-655;
  player.playerSpaceshipX = width-600;
  player. playerSpaceshipY =  height-250;
  asteroidDoDmg = true; // asteroid is allowed to do damage
  if (chapters == "Start") {
    chapters = "Carry on The Legacy"; // chapter changed to carry on the legacy
    chapterChange = true; // chapter change is seen
  } else {
    chapters = "The Final One"; // chapter changed to the final one
    chapterChange = true; // chapter change is seen
  }
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

  /** Name Input **/
  for (TextBox t : textboxes) {
    if (t.KEYPRESSED(key, keyCode)) {
      send = true;
      name = "Message is: " + textboxes.get(1).name;
    }
  } // records the key pressed in the textbox

  /** Reaches the Extreme End Flags **/

  boolean atRightEndFlag = false; // flag if the player's spaceship reaches off the the screen
  boolean atLeftEndFlag = false; // flag if the player's spaceship reaches off the the screen

  /** Detect if the Player's Spaceship is Moving Extremely Right or Left **/

  if (player.playerSpaceshipX >= width-380) {
    atRightEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the right off the screen
  else if (player.playerSpaceshipX <= 10) {
    atLeftEndFlag = true; // reaches the end flag is true
  } // if the player's spaceship goes extremely to the left off the screen

  /** Makes sure the Player's Spaceship doesn't go off the screen **/

  if (atRightEndFlag) {
    if (key == 'd' || key == 'D') {
      player.playerSpaceshipX +=0;
    } else if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -=10;
    }
  } else if (atLeftEndFlag) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -= 0;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX +=10;
    }
  }

  /** ONLY If the Player's Spaceship is NOT Moving to the Extreme Right or Left **/
  /** Moves the Player's Spaceship Left and Right **/

  if (player.playerSpaceshipX < width-380 && player.playerSpaceshipX > 10 && atRightEndFlag == false && atRightEndFlag == false) {
    if (key == 'a' || key == 'A') {
      player.playerSpaceshipX -=10;
    } else if (key == 'd' || key == 'D') {
      player.playerSpaceshipX += 10;
    }
  }
}

void mouseReleased() {

  /****************************************
   Performs Action Based on Mouse Release
   ***************************************/

  for (TextBox t : textboxes) {
    t.pressed(mouseX, mouseY);
  } // records if the textbox region is pressed with the mouse

  if (screens == "Play") {
    if (millis() - playerShootTime > 1000) {
      if (enemy.enemyLifeLeft > 0 && player.playerLifeLeft > 0) {
        playerBullet.playerShootBullet(); // function to shoot the player's bullet
      } // shoot only if player and enemy life left are greater than 0
    } // fires the player's bullet only after 1 second of the play button being clicked
  } // shoots the bullet, only with mouse press, and in one of the play screens (or chapters)
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

/************************************
 ***
 TextBox Functions
 ***
 **************************************/

void textInitLayout() {

  /****************************************
   Layout of the TextBox
   ***************************************/

  /** Layout of the TextBox **/

  TextBox receiver = new TextBox();
  receiver.W = width-300;
  receiver.H = height-620;
  receiver.X = (width - receiver.W)/2;
  receiver.Y = (height/2)-50;
  textboxes.add(receiver);
}

// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

// END MAIN PROGRAM
