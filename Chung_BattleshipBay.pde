#include <MeggyJrSimple.h> 

struct Point
{
  int x; //sets x and y coordinates for struct points in array
  int y;
};

int xcursor; //x and y coordinates of the cursor
int ycursor;

void setup()
{
  MeggyJrSimpleSetup();
  xcursor=4; //initial cursor position
  ycursor=4; 
  SetAuxLEDsBinary(B11111111);
}

void loop() 
{
  DrawBay(); //method for drawing the island border, first as everything over it
  DrawAmmo(); //method for drawing Ammo, second just in case to overide backdrop
  DrawCursor(); //method for drawing the cursor, last to overide background
  DisplaySlate(); 
}

void DrawCursor()
{
  DrawPx(xcursor,ycursor,7);
  DisplaySlate();
  delay(200);
  ClearSlate();
  DrawBay(); //within drawing cursor to prevent blinking 
  DrawAmmo();
  DisplaySlate();
  delay(200);
    
  CheckButtonsDown();
  {
    if (Button_Right)
      xcursor=xcursor+1;
      if (xcursor==7)
        xcursor=6;
    if (Button_Up)
      ycursor=ycursor+1;
      if (ycursor==7)
        ycursor=6;
    if (Button_Left)
      xcursor=xcursor-1;
      if (xcursor==0)
        xcursor=1;
    if (Button_Down)
      ycursor=ycursor-1;
      if (ycursor==0)
        ycursor=1;
  }
}

void DrawBay()
{
  for (int bay = 0; bay<8; bay++)
  {
    DrawPx(0,bay,4);
    DrawPx(bay,0,4);
    DrawPx(7,bay,4);
    DisplaySlate();
  }
}

void DrawAmmo()
{
  Point a1 = {0,7};
  Point a2 = {1,7};
  Point a3 = {2,7};
  Point a4 = {3,7};
  Point a5 = {4,7};
  Point a6 = {5,7};
  Point a7 = {6,7};
  Point a8 = {7,7};
  
  Point PxAmmo[8] = {a1,a2,a3,a4,a5,a6,a7,a8};
  int ShotCounter = 16;
  CheckButtonsPress();
  {
    if (Button_A)
      ShotCounter = ShotCounter - 1;
      
  if (ShotCounter == 16)
    SetAuxLEDsBinary(B11111111);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 15)
    SetAuxLEDsBinary(B11111110);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 14)
    SetAuxLEDsBinary(B11111100);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 13)
    SetAuxLEDsBinary(B11111000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 12)
    SetAuxLEDsBinary(B11110000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 11)
    SetAuxLEDsBinary(B11100000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 10)
    SetAuxLEDsBinary(B11000000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 9)
    SetAuxLEDsBinary(B10000000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
  if (ShotCounter == 8)
    SetAuxLEDsBinary(B00000000);
    for (int i = 0; i < 8; i++)
    {
      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    }
    
  }      
}
/*void DrawBoat()
{
  int boat[3] = {s1,s2,s3};
  randomboatx=random(6)+1;
  randomboaty=random(6)+1;
  Point s1 = {randomboatx,randomboaty,1}
  Point s2 = {randomboatx+1,randomboaty,1}
  DrawPx(randomboatx,randomboaty,1);
}*/
