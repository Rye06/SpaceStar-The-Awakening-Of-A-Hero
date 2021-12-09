/****************************************
 Bullet Class
 ***************************************/

class Bullet {

  int bulletX; // x position of the bullet
  int bulletY; // y position of the bullet

  void newBullet() {

    /****************************************
     Creates a Bullet
     ***************************************/

    bulletX = playerSpaceshipX + 178; // sets the initial x position of the bullet
    bulletY = playerSpaceshipY+4; // sets the initial y position of the bullet

    fire(bulletX, bulletY); // calls the fire function

    checkBullet = false; // sets check for new bullet to false
  } // bullet shoots only in the play screen


  void fire(int bulletX, int bulletY) {

    /****************************************
     Fires the Bullet
     ***************************************/
 
    while (bulletY > 0) {
      image(bulletPic, bulletX, bulletY);
      bulletY -= 50; // moves the bullet forward
    }
  }
}
