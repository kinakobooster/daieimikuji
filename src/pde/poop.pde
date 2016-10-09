import java.util.*;
ArrayList<Particle> particles;
PImage poop,hand;
PFont font;
Particle p;
int gameover = 0;
int score = 0;
boolean gameover = false;


void setup(){
  size(320,600);
  particles = new ArrayList<Particle>();
  poop = loadImage("dest/assets/images/emoji_poop.png");
  hand = loadImage("dest/assets/images/emoji_hand.png");
  font = createFont("Helvetica", 32);
  textFont(font);
}

void draw(){
  background(0);
  particles.add(new Particle(new PVector(width/2,0)));

  Iterator<Particle> it = particles.iterator();

  while (it.hasNext()){
    Particle p = it.next();
    p.run();
    if(p.isDead()){
      it.remove();
    }
    if(p.isTouch()){
      gameOver();
      break;
    }


  }
  image(hand,mouseX,mouseY);
  if(frameCount % 10 == 0)  score++;
  text(score,50,330);

}
void gameOver(){
  fill(255,0,0,50);
  rect(0,0,width,height);
  fill(255);
  text("YOU are DEAD", 50,50);
  gameover = true;
  noLoop();

}

void mouseClicked(){
  if(gameover == true){
  particles.clear();
  score = 0;
  loop();
  gameover = false;
}

}



class Particle{
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  float mass;

  Particle(PVector l ){
   loc = l.get();
   acc = new PVector(0,0.05);
   vel = new PVector(random(-1,1),random(-1,1));
   lifespan = 255;
   mass = 10;


   }

   void run(){
     applyForce(mouseForce());
     update();
     display();
   }

   void update(){
     vel.add(acc);
     loc.add(vel);
     lifespan--;

   }

   void display(){
     noStroke();
     fill(255,lifespan);
     image(poop, loc.x,loc.y);
     }

   void applyForce(PVector f){
     f.mult(1/mass);
     acc.add(f);
     acc.mult(0.8);

   }

     boolean isTouch(){
     PVector mousepos = new PVector(mouseX,mouseY);
     if (PVector.dist(mousepos,loc) < 4) return true;
     else return false;
   }

   PVector mouseForce(){
     PVector mousepos = new PVector(mouseX,mouseY);
     PVector f = PVector.sub(mousepos,loc);
     f.normalize();
     f.mult(0.05);
     return f;
   }

   boolean isDead(){
   if(lifespan < 0)     return true;
   else return false;

   }

}
