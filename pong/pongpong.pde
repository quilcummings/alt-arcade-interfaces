import processing.sound.*;

AudioIn input;
AudioIn input2;
Amplitude analyzer;
Amplitude analyzer2;

float pos = 0;

int scoreLeft = 0;
int scoreRight = 0;

Ball ball;
Paddle paddleLeft;
Paddle paddleRight;

void setup() {
  
  input = new AudioIn(this, 0);
  input2 = new AudioIn(this, 1);
  
  input.start();
  input2.start();
  
  analyzer = new Amplitude(this);
  analyzer2 = new Amplitude(this);
  
  analyzer2.input(input2);
  analyzer.input(input);
  
  fullScreen();
  ball = new Ball(width/2, height/2, 10);
  paddleLeft = new Paddle(15, height/2, 10, 100);
  paddleRight = new Paddle(width-15, height/2, 10, 100);
  
  ball.speedX = 4;
  ball.speedY = random(-3,3);
  
}

void draw() {
  background(0, 0, 0);
  
  textSize(40);
  
  text(scoreRight, width/2+30, 30);
  text(scoreLeft, width/2-30, 30);
  
  float vol = analyzer.analyze();
  float vol2 = analyzer2.analyze();
  
   
  //ellipse(width/2, height/2, 10+vol*200, 10+vol*200);
  //ellipse(width/2+100, height/2, 10+vol2*200, 10+vol2*200);

  
  paddleLeft.move();
  paddleLeft.display();
  paddleRight.move();
  paddleRight.display();
  
  ball.move();
  ball.display();
  
  if (ball.right() > width) {
    scoreLeft = scoreLeft + 1;
    ball.x = width/2;
    ball.y = height/2;
  }
  if (ball.left() < 0) {
    scoreRight = scoreRight + 1;
    ball.x = width/2;
    ball.y = height/2;
  }
  
  if (ball.left() < paddleLeft.right() && ball.y > paddleLeft.top() && ball.y < paddleLeft.bottom()){
    ball.speedX = -ball.speedX;
  }
  if (ball.right() > paddleRight.left() && ball.y > paddleRight.top() && ball.y < paddleRight.bottom()) {
    ball.speedX = -ball.speedX;
  }
  
  if (ball.bottom() > height-70) {
    ball.speedY = -ball.speedY;
  }
  if (ball.top() < 0) {
    ball.speedY = -ball.speedY;
  }
  
  
  
  if (vol*100 < 10)
  {
    paddleRight.speedY = 5;
  }
  else
  {
    paddleRight.speedY = -5;
  }
  
  if (vol2*100 < 10)
  {
    paddleLeft.speedY = 5;
  }
  else
  {
    paddleLeft.speedY = -5;
  }
  
  
  if (paddleLeft.bottom() > height) {
    paddleLeft.y = height-paddleLeft.h/2;
  }

  if (paddleLeft.top() < 0) {
    paddleLeft.y = paddleLeft.h/2;
  }
    
  if (paddleRight.bottom() > height) {
    paddleRight.y = height-paddleRight.h/2;
  }

  if (paddleRight.top() < 0) {
    paddleRight.y = paddleRight.h/2;
  }
  
}

//void keyPressed(){

//  if(keyCode == UP && paddleRight.top() > 0){
//    paddleRight.speedY=-3;
//  }
//  if(keyCode == DOWN){
//    paddleRight.speedY=3;
//  }
      
//  if(key == 'a'){
//    paddleLeft.speedY=-3;
//  }
//  if(key == 'z' && paddleLeft.y < 850){
//    paddleLeft.speedY=3;
//  }
//}

//void keyReleased(){
//  if(keyCode == UP){
//    paddleRight.speedY=0;
//  }
//  if(keyCode == DOWN){
//    paddleRight.speedY=0;
//  }
//  if(key == 'a'){
//    paddleLeft.speedY=0;
//  }
//  if(key == 'z'){
//    paddleLeft.speedY=0;
//  }
//}

class Ball {
  float x;
  float y;
  float speedX;
  float speedY;
  float diameter;
  color c;
  
  
  Ball(float tempX, float tempY, float tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
    speedX = 0;
    speedY = 0;
    c = (255); 
  }
  
  void move() {
    y = y + speedY;
    x = x + speedX;
  }
  
  void display() {
    fill(c); 
    rect(x, y, diameter, diameter);
  }
  
  float left(){
    return x-diameter/2;
  }
  float right(){
    return x+diameter/2;
  }
  float top(){
    return y+diameter/2;
  }
  float bottom(){
    return y-diameter/2;
  }
}

class Paddle {

  float x;
  float y;
  float w;
  float h;
  float speedY;
  float speedX;
  color c;
  
  Paddle(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    speedY = 0;
    speedX = 0;
    c=(255);
  }

  void move(){
    y += speedY;
    x += speedX;
  }

  void display(){
    fill(c);
    rect(x-w/2,y-h/2,w,h);
  } 
  
  float left(){
    return x-w/2;
  }
  float right(){
    return x+w/2;
  }
  float top(){
    return y-h/2;
  }
  float bottom(){
    return y+h/2;
  }
}
