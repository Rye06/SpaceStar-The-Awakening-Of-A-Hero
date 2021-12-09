/****************************************
 Bullet Class
 ***************************************/

class Bullet {

  int bulletPosX; // x position of the bullet
  int bulletPosY; // y position of the bullet

  Bullet(int bulletX, int bulletY) {
    this.bulletPosX = bulletX;
    this.bulletPosY = bulletY;
  } // class constructor

  void initBulletPos() {

    /*******************************************
     Initial Position of the Bullet
     *******************************************/

    bulletPosX = 0; // sets the initial x bullet position off the screen
    bulletPosY = 800; // sets the initial y bullet position off the screen
  }

  void placeX() {

    /*******************************************
     Places the Bullet at Spaceship X Coordinate
     *******************************************/
  }
}
