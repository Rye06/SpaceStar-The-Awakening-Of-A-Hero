/****************************************
 ****
 Bullet Class
 ****
 ***************************************/

class Bullet {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Variables
   ***
   **************************************/

  /** Player Bullets **/
  int playerBulletPosX; // x position of the player's bullet
  int playerBulletPosY; // y position of the player's bullet
  int playerBulletSpeed; // player's bullet speed

  /** Enemy Bullets **/
  int enemyBulletPosX; // x position of the enemy's bullet
  int enemyBulletPosY; // y position of the enemy's bullet
  int enemyBulletSpeed; // enemy's bullet speed

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Functions (Bullet Class- Player)
   ***
   **************************************/

  void playerInitBulletPos() {

    /*******************************************
     Initial Position of the Player's Bullet
     *******************************************/

    /** Initial Coordinates **/
    playerBulletPosX = 0; // sets the initial x bullet position off the screen
    playerBulletPosY = -40; // sets the initial y bullet position off the screen

    /** Initial Bullet Speed **/
    playerBulletSpeed = 1;
  }

  void playerShoot() {

    /*********************************************
     Shoots the Bullet from the Player's Spaceship
     ********************************************/

    playerBulletPosX =  playerSpaceshipX+175; // sets the x coordinate of the bullet to the player's spaceship x
    playerBulletPosY =  playerSpaceshipY+4; // sets the y coordinate of the bullet to the player's spaceship y
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Bullet Functions (Bullet Class- Enemy)
   ***
   **************************************/

  void enemyInitBulletPos() {

    /*******************************************
     Initial Position of the Enemy's Bullet
     *******************************************/

    /** Initial Coordinates **/
    enemyBulletPosX = 0; // sets the initial x bullet position off the screen
    enemyBulletPosY = -40; // sets the initial y bullet position off the screen

    /** Initial Bullet Speed **/
    enemyBulletSpeed = 1;
  }

  void enemyShoot() {

    /*********************************************
     Shoots the Bullet from the Enemy's Spaceship
     ********************************************/

    enemyBulletPosX =  playerSpaceshipX+175; // sets the x coordinate of the bullet to the enemy's spaceship x
    enemyBulletPosY =  playerSpaceshipY+4; // sets the y coordinate of the bullet to the enemy's spaceship y
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}
