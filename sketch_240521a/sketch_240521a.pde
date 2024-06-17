ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int w=30, h=30, blocks=20, diraction = 2, foodx = 15, foody = 15, fc1 = 255, fc2 = 255, fc3 = 255, speed = 8, extra_lifex = 15, extra_lifey = 15, exl1 = 255, exl2 = 255, exl3 = 255;
int[] x_diraction={0,0,1,-1}, y_diraction={1,-1,0,0};
boolean gameover = false;
boolean extralife_mode = false;
int counter;
int lastsize ;

void setup(){
  size(600,600);
  x.add(0);
  y.add(15);
  counter = 0;
  lastsize = 0;
}

void draw(){
  background(0);
    fill (255, 33, 33);
    for (int i = 0; i < x.size(); i++)
      rect(x.get(i)*blocks, y.get(i)*blocks, blocks, blocks);
    textAlign(RIGHT); //extra life
    textSize(25);
    fill(255);
    text("extra life: " + counter, 10, 10, width -20, 50);
    textAlign(LEFT); // score
    textSize(25);
    fill(255);
    text("score: " + x.size(), 10, 10, width - 20, 50);
    if (!gameover)
    {
      if (x.size()%5==0 && lastsize != x.size())
      {    
        lastsize = x.size();
        extralife_mode = true;
      }
      if(extralife_mode)
      {
        fill(exl1,exl2,exl3); // extra life color
        rect(extra_lifex*blocks,extra_lifey*blocks, blocks, blocks); //extra life
      }
      fill(fc1, fc2, fc3); //food color
      ellipse(foodx*blocks+10, foody*blocks+10, blocks, blocks); //food
      
      if (frameCount%speed==0)
      {
        x.add(0, x.get(0) + x_diraction[diraction]);
        y.add(0, y.get(0) + y_diraction[diraction]);
        if (x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h)
        {
          if(counter > 0)
          {
            counter--;
            x.set(0,0);
            y.set(0,15);
            diraction = 2;
          } else { 
            gameover = true;
          }
        }
        for (int i = 1; i<x.size(); i++)
        {
          if (x.get(0) == x.get(i) && y.get(0) == y.get(i))
          {
            if(counter > 0)
            {
              counter--;
              x.set(0,0);
              y.set(0,15);
              diraction = 2;
            } else {
              gameover = true;
            }
          }
        }
        if (x.get(0) == foodx && y.get(0) == foody)
        {
          if (x.size()%2==0 && speed >= 2)
            speed -= 1; //speed increase   
          foodx = (int)random(0,w);
          foody = (int)random(0,w);
          fc1 = (int)random(255);
          fc2 = (int)random(255);
          fc3 = (int)random(255);
        }
        else
        {
          x.remove(x.size()-1);
          y.remove(y.size()-1);
        }
        if (x.get(0) == extra_lifex && y.get(0) == extra_lifey && extralife_mode)
        {
          counter++;
          extra_lifex = (int)random(0,w);
          extra_lifey = (int)random(0,w);
          exl1 = (int)random(255);
          exl2 = (int)random(255);
          exl3 = (int)random(255);
          extralife_mode = false;
        }
      }
    }
    else
    {
      fill(255, 229, 33);
      textSize(30);
      textAlign(CENTER);
      text("GAME OVER \n Your score is: "+ x.size() +"\n Press Enter", width/2, height/3);
      if (keyCode == ENTER)
      {
        x.clear();
        y.clear();
        x.add(0);
        y.add(15);
        extralife_mode = false;
        counter = 0;
        lastsize = 0;
        diraction = 2;
        speed = 8;
        gameover = false;
      }
    }
}

void keyPressed()
{
  int newdir = keyCode == DOWN? 0:(keyCode == UP?1:(keyCode == RIGHT?2:(keyCode == LEFT?3:-1)));
  if (newdir != -1)
    diraction = newdir;
}
