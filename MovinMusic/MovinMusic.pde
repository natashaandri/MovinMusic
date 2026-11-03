// Import processing sound library in order to add sound to the project

import processing.sound.*;

SoundFile music;

// Upload background image file

PImage album;

// Upload image files of all interactive elements

PImage NFR;
PImage flag;
PImage woman; 
PImage LDR;

// Introduce variables

// Introduce shake interactive movement
float shakeAmount = 0;
int shakeStart = 0;
boolean shaking = false;

// Introduce size interactive movement
float womanSize = 160;
float targetSize = 160;
boolean womanBig = false;

// Introduce spin interactive movement
boolean LDRspinning = false;
float LDRrotation = 0;

// Set canvas size

void setup() {
  size(400, 400);
  
// Name image and sound files
  album = loadImage("album.png");
  NFR = loadImage("NFR.png");
  flag = loadImage("flag.png");
  woman = loadImage("woman.png");
  LDR = loadImage("LDR.png");
  music = new SoundFile(this, "song.mp3");
}

void draw() {
  // Draw the album cover as the background
  image(album, 0, 0, 400, 400);
  
  // Draw NFR bubble on top and make it shake when clicked
  float shakeX = 0;
float shakeY = 0;

if (shaking) {
  if (millis() - shakeStart < 300) {
    shakeX = random(-shakeAmount, shakeAmount);
    shakeY = random(-shakeAmount, shakeAmount);
  } else {
    shaking = false;
  }
}

image(NFR, shakeX, shakeY, 140, 110);
  
  // Draw flag on top and make it wave
  pushMatrix();

translate(115, 250);
rotate(sin(frameCount * 0.05) * 0.04);

image(flag, -85, -135, 170, 270);

popMatrix();
  
  // Draw woman on top and make her grow when clicked
  womanSize = lerp(womanSize, targetSize, 0.05);

image(woman, 90, 100, womanSize,
      womanSize * woman.height / woman.width);
  
  pushMatrix();

// Move rotation point to the centre of LDR
translate(365, 340);

// Only rotate when clicked
if (LDRspinning) {
  LDRrotation += 0.05;
}

rotate(LDRrotation);

// Draw LDR
image(LDR, -25, -50, 50, 100);

popMatrix();
}

void mousePressed() {

  // If the woman is clicked
if (mouseX > 90 && mouseX < 250 &&
    mouseY > 100 && mouseY < 400) {

  if (womanBig) {
    // Woman shrinks back to normal size, music stops
    targetSize = 160;
    music.stop();
  } else {
    // Woman gets bigger, music plays
    targetSize = 220;
    music.play();
  }

  womanBig = !womanBig;
}

  // Make NFR shake when clicked
  if (mouseX > 0 && mouseX < 140 &&
      mouseY > 0 && mouseY < 110) {

    shaking = true;
    shakeStart = millis();
    shakeAmount = 5;
  }
  
  // If LDR is clicked
if (mouseX > 340 && mouseX < 390 &&
    mouseY > 290 && mouseY < 390) {
  LDRspinning = !LDRspinning;
}

}
