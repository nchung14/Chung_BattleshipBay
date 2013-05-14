#include <MeggyJrSimple.h> 

struct Point
{
  int x; //sets x and y coordinates for struct points in array
  int y;
};

int xcursor;
int ycursor;

/*Point s1 = {

int boat[4] = {s1,s2,s3,s4};*/

void setup()
{
  MeggyJrSimpleSetup();
  xcursor=4;
  ycursor=4;
  
  
}

void loop()
{
  DrawBay();
  DrawCursor();
  DisplaySlate();
}


void DrawCursor()
{
  DrawPx(xcursor,ycursor,7);
  DisplaySlate();
  delay(200);
  ClearSlate();
  DrawBay();
  DisplaySlate();
  delay(200);
    
  CheckButtonsDown();
  {
    if (Button_Right)
      xcursor=xcursor+1;
    if (Button_Up)
      ycursor=ycursor+1;
    if (Button_Left)
      xcursor=xcursor-1;
    if (Button_Down)
      ycursor=ycursor-1;
  }
}

void DrawBay()
{
  for (int bay = 0; bay<9; bay++)
  {
    DrawPx(0,bay,4);
    DrawPx(bay,0,4);
    DrawPx(7,bay,4);
    DisplaySlate();
  }
}
