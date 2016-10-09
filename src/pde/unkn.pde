int STROKECOUNT = 48;

void setup(){
  size(320,500);
  //smooth();
}

void draw(){
  background(0);
  strokeWeight(2);
  stroke(255);
  fill(0);
  int step = 4;
  float lastx = -999;
  float lasty = -999;
  float ynoise = float(frameCount)/20;
  float y;
  float ystep = (height-130) / STROKECOUNT;

  for (int yorigin = 80; yorigin < height-50; yorigin+=ystep){
    beginShape();
    for (float x=20; x<=width-20; x+=step) {
       y = yorigin -  noise(ynoise + x/200)*80 * exp(pow((x - width/2 - sin(yorigin/ystep)*random(10))/50,2)*(-0.95));
      if (lastx > -999) {
        vertex(x, y);
    }
    lastx = x; lasty = y; ynoise += 0.1;
    }
    endShape();
    lastx = -999; ynoise += 0.2;
  }

}
