//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies
int deck1x, deck1y;
int deck2x, deck2y;

boolean deck1Playing = false;
boolean deck2Playing = false;
float rotateDeck1 = 0;
float rotateDeck2 = 0;
float currentFrame = 0;
int margin = width/40;
PImage [] images;
PImage [] recordPlayer;
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;
float speedAdjust=1.0;


void setup()
{
  size(768, 1024);
  imageMode(CENTER);
  images = loadImages("Animation_data/image", ".jpg", 40);
  recordPlayer = loadImages("black-record_", ".png", 36);
  maxim = new Maxim(this);
  player1 = maxim.loadFile("beat1.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("beat2.wav");
  player2.setLooping(true);
  colorMode(HSB, 360, 100, 100);
  color bg = color(180, 50, 50);
  background(bg);
}

void draw()
{
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10);
  deck1y = recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width, recordPlayer[0].height);
  deck2x = (width/2)+recordPlayer[0].width/2+(margin*10);
  deck2y = recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck2], deck2x, deck2y, recordPlayer[0].width, recordPlayer[0].height);

  imageMode(CENTER);
  image(images[(int)currentFrame], width/2, recordPlayer[0].height + images[0].height/4+margin, images[0].width/2, images[0].height/2);


  if (deck1Playing || deck2Playing) {
    player1.speed(speedAdjust);
    player2.speed((player2.getLengthMs()/player1.getLengthMs())*speedAdjust);
    currentFrame= currentFrame+1*speedAdjust;
  }

  if (currentFrame >= images.length) {
    currentFrame = 0;
  }

  if (deck1Playing) {
    rotateDeck1 += 1*speedAdjust;
    if (rotateDeck1 >= recordPlayer.length) {
      rotateDeck1 = 0;
    }
  }

  if (deck2Playing) {
    rotateDeck2 += 1*speedAdjust;
    if (rotateDeck2 >= recordPlayer.length) {
      rotateDeck2 = 0;
    }
  }
}

void mouseDragged() {
  if (mouseY<recordPlayer[0].height) {
    speedAdjust=map(mouseX, 0, width, 0, 2);
  }
}



void mouseClicked()
{
  fill(0);
  rect(mouseX,mouseY,10*speedAdjust,10*speedAdjust);
  if (dist(mouseX, mouseY, deck1x, deck1y) < recordPlayer[0].width/2) {
    deck1Playing = !deck1Playing;
  }
  if (deck1Playing) {
    player1.play();
  } else {
    player1.stop();
  }

  if (dist(mouseX, mouseY, deck2x, deck2y) < recordPlayer[0].width/2) {
    deck2Playing = !deck2Playing;
  }

  if (deck2Playing) {
    player2.play();
  } else {
    player2.stop();
  }
}