import java.util.Arrays;

Fish fish;
Liquid liquid;
ArrayList<Food> foods;

void setup() {
  size(640,320);
  background(255);
  fish = new Fish();
  foods = new ArrayList<Food>();
  liquid = new Liquid(0, height*1/5, width, height*4/5, 0.1);
}


void mousePressed() {
  Food f = new Food(random(width),random(height),0.8);
  foods.add(f);
}


void draw() {
  PVector mouseLocation = new PVector(mouseX, mouseY);
  fish.attract(mouseLocation);
  fish.drawGame();
  for (int i = 0; i < foods.size(); i++) {
    Food f = foods.get(i);
    if (f.isInside(liquid)) {
        f.drag(liquid);
    }
    if (f.eaten(fish)) {
        foods.remove(i);
        fish.addMass(0.1);
    }
    float c = 0.01;
    PVector friction = f.velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    float m = f.mass;
    PVector gravity = new PVector(0,0.1*m);
    f.applyForce(gravity);
    f.applyForce(friction);
    f.update();
    f.checkEdges();
    f.display();
  }
}
