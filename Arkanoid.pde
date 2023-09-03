// Final project
// Arkanoid
Vaus v;
Brick brick;

int score;
ArrayList<Balls> ballsList;
Balls lastBall;
int life;

int NAME_INPUT_STATE = 0;
int GAME_STATE = 1;
int END_STATE = 2;
int currentState = NAME_INPUT_STATE;
String playerName = "";

JSONArray scoresArray;

void setup(){
  size(500,700);
  rectMode(CENTER);
  //ellipseMode(CENTER);
  ellipseMode(RADIUS);
  v = new Vaus();
  brick = new Brick(6,6);
  ballsList = new ArrayList<Balls>();
  score = 0;
  life = 2;
  
  String filename = "scores.json";
  if (!new File(filename).exists()) {
    // If the file doesn't exist, create an empty JSON array
    scoresArray = new JSONArray();
    saveJSONArray(scoresArray, filename);
  } else {
    scoresArray = loadJSONArray(filename); // Load the existing JSON array
  }
}

void saveScoreToJson(String playerName, int score) {
  JSONObject json = new JSONObject();
  json.setString("name", playerName);
  json.setInt("score", score);

  scoresArray.append(json);

  if (scoresArray.size() > 10) {
    scoresArray.remove(10);
  }

  String filename = "scores.json";
  saveJSONArray(scoresArray, filename);
}



void keyPressed() {
  if (currentState == NAME_INPUT_STATE) {
    if (keyCode == BACKSPACE && playerName.length() > 0) {
      playerName = playerName.substring(0, playerName.length() - 1);
    } else if (keyCode >= 32 && keyCode <= 126) {
      playerName += key;
    }
  } else if (currentState == GAME_STATE){
    if (keyCode == 32 && lastBall == null) {
      if (life > 0) { 
        lastBall = new Balls(); 
      }
    } else if (keyCode == 82){
      currentState = NAME_INPUT_STATE;
      brick = new Brick(6,6);
      score = 0;
      life = 2;
      ballsList.clear();
      lastBall = null;
      playerName = "";
    }
  }
}

void mousePressed() {
  if (currentState == NAME_INPUT_STATE) {
    // Check if the mouse click is inside the "Start" button
    if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 &&
        mouseY > height / 2 + 20 && mouseY < height / 2 + 100) {
      currentState = GAME_STATE; // Change the state to GAME_STATE
      playerName = playerName.trim(); // Remove leading/trailing spaces
    }
  } else if (currentState == END_STATE){
      // Check for mouse click on "Play Again" button
      if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 &&
      mouseY > height / 2 + 20 && mouseY < height / 2 + 100) {
      currentState = NAME_INPUT_STATE;
      brick = new Brick(6,6);
      score = 0;
      life = 2;
      ballsList.clear();
      lastBall = null;
      playerName = "";
    } else if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 &&
      mouseY > height / 2 + 30 && mouseY < height / 2 + 130){
      saveScoreToJson(playerName, score);
    }
  }
}


void playGame() {
  if (life == 0){
    currentState = END_STATE;
  }
  brick.display();
  
  v.move();
  v.display();
  
  if (lastBall != null) {
    lastBall.edge_detect();
    lastBall.hitVaus(v);
    lastBall.move();
    lastBall.removeBricks(brick.getBricks(), brick.getBricksColor(), brick.getSize());
    lastBall.display();
    
    // Check if the last ball is out of the screen height
    if (lastBall.pos.y > height) {
      lastBall = null;
      life--;
    }
  }
  
  // Display the score
  fill(255);
  textAlign(RIGHT, BOTTOM);
  textSize(24);
  text("Score: " + score, width - 20, height - 20);
  
  // Display the count of lives
  fill(255);
  textAlign(LEFT, BOTTOM);
  textSize(24);
  text("Lives: " + life, 20, height - 20);
}


void displayNameInputScreen() {
  background(125);
  
  // Display instructions
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Enter your name:", width / 2, height / 2 - 50);
  
  // Display text box for name input
  fill(255);
  rectMode(CENTER);
  rect(width / 2, height / 2, 200, 40);
  
  // Display the player's name inside the text box
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(playerName, width / 2, height / 2);
  
  // Display "Start" button
  fill(#77FAA5);
  rect(width / 2, height / 2 + 60, 100, 40);
  fill(0);
  textSize(24);
  text("Start", width / 2, height / 2 + 60);
}

void displayEndGameScreen() {
  background(125);
  
  // Display game over message
  fill(0);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("Game Over", width / 2, height / 2 - 50);
  
  // Display final score
  textSize(24);
  text("Final Score: " + score, width / 2, height / 2);
  
  // Display "Play Again" button
  fill(#77FAA5);
  rect(width / 2, height / 2 + 60, 150, 40);
  fill(0);
  textSize(24);
  text("Play Again", width / 2, height / 2 + 60);
  
  // Display "Save Score" button
  fill(#77FAA5);
  rect(width / 2, height / 2 + 120, 150, 40);
  fill(0);
  textSize(24);
  text("Save Score", width / 2, height / 2 + 120);
}


void draw(){
  background(125);
  if (currentState == NAME_INPUT_STATE) {
    displayNameInputScreen();
  } else if (currentState == GAME_STATE) {
    playGame();
  } else if (currentState == END_STATE){
    displayEndGameScreen();
  }
}
