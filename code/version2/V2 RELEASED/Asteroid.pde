/****************************************
 ****
 Asteroid Class
 ****
 ***************************************/

class Asteroid {

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Variables
   ***
   **************************************/

  int asteroidX; // asteroid x coordinate
  int asteroidY; // asteroid y coordinate
  int asteroidSpeed; // speed of the asteroid

  ArrayList<PImage> asteroids = new ArrayList<PImage>(); // asteroids's image array list
  int[] randomAsteroidYVals = new int[backgroundPic.width]; // random asteroid y values\

  int asteroidDmg; // asteroid damage

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Constructor
   ***
   **************************************/

  public Asteroid(int asteroidX, int asteroidY, int asteroidSpeed) {
    /** Set the Variables **/
    this.asteroidX = asteroidX;
    this.asteroidY = asteroidY;
    this.asteroidSpeed = asteroidSpeed;
  } // asteroid constructor

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------

  /************************************
   ***
   Asteroid Functions
   ***
   **************************************/

  void createAsteroids() {

    /**********************************************
     Creates Asteroids
     **********************************************/

    for (int i = 0; i < 5; i++) {
      asteroids.add(loadImage("asteroid.png")); // adds the asteroid image to the list
      asteroids.get(i).resize(30, 30); // resizes the asteroid image
    } // generates 5 asteroids
  }

  void initAsteroidPos() {

    /**********************************************
     Initial Asteroid Position
     **********************************************/

    for (int a = 0; a < randomAsteroidYVals.length; a++) {
      randomAsteroidYVals[a] = int(random(20, 150)); // random y asteroid values
    } // generates random positions for the asteroid
  }

  void randAsteroidY(int asteroid) {

    /**********************************************
     Generates Random Asteroid Y Value
     **********************************************/

    randomAsteroidYVals[asteroid] = int(random(-150, -1)); // generates a new random y value for the asteroid
  }

  void asteroidMechanics() {

    /**********************************************
     Mechanics of the Asteroid
     **********************************************/

    for (int k = 0; k < asteroids.size(); k++) {
      image(asteroids.get(k), asteroidX+(k*100), randomAsteroidYVals[k]); // places asteroid image on the screen
      randomAsteroidYVals[k] += asteroidSpeed; // moves the asteroid down

      if (dist(asteroidX+(k*100), randomAsteroidYVals[k], player.playerSpaceshipX+185, player.playerSpaceshipY+185) <= 138) {
        if (chapters == "Start" && asteroidDoDmg) {
          asteroidDmg = 5; // asteroid damage is changed to 15
        } else if (chapters == "Carry on The Legacy" && asteroidDoDmg) {
          asteroidDmg = 10; // asteroid damage is changed to 15
        } else if (chapters == "The Final One" && asteroidDoDmg) {
          asteroidDmg = 15; // asteroid damage is changed to 15
        }
        player.playerLifeLeft-=asteroidDmg; // decreases the player's life left on collsion
        randomAsteroidYVals[k] = -100; // shifts the asteroid off the screen
      } // collision is seen of asteroid with player's spaceship

      if (randomAsteroidYVals[k] > 800) {
        randAsteroidY(k); // generates new random asteroid y value
      } // edge of screen is reached

      if (chapterChange) {
        for (int s = 0; s < randomAsteroidYVals.length; s++) {
          randAsteroidY(s);
        }
        chapterChange = false; // chapter change is now false
      } // resets y asteroid position if a new chapter is seen
    }
  }

  // ---------------------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------------
}  
