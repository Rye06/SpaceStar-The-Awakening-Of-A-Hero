/****************************************
 Bullet Class
 ***************************************/

class Bullet {


  void fire() {

    /****************************************
     Fire Function
     ***************************************/

    if (mousePressed && chapters == "Play") {
      rect(playerSpaceshipX+100, playerSpaceshipY+5, playerSpaceshipX, playerSpaceshipY+15); // bullet
    }
  }
}
