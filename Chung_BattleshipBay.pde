#include <MeggyJrSimple.h> 

//Boat b1 = {randomboatx,randomboaty,1};
//Boat b2 = {randomboatx+1,randomboaty,1};
//Boat b3 = {randomboatx+2,randomboaty,1};
//Boat randomboat[3] = {s1,s2,s3};

struct Point
{
  int x; //sets x and y coordinates for struct points in array
  int y;
};

Point a1 = {0,7};
Point a2 = {1,7};
Point a3 = {2,7};
Point a4 = {3,7};
Point a5 = {4,7};
Point a6 = {5,7};
Point a7 = {6,7};
Point a8 = {7,7};
  
Point PxAmmo[8] = {a1,a2,a3,a4,a5,a6,a7,a8};

int xcursor; //x and y coordinates of the cursor
int ycursor;
int CursorCounter = 0;
int ShotCounter;

int MoveBoatx = random(5);
int MoveBoaty = random(5);

//struct Boat
//{
//  int x;
//  int y;
//};

//int randomboatx = random(6)+1;
//int randomboaty = random(6)+1;
//
//Point b1 = {randomboatx,randomboaty};
//Point b2 = {b1.x+1,b1.y+1};
//Point b3 = {b1.x+2,b1.y+2};
//Point b4 = {b1.x+3,b1.y+3};
//
//Point Boat[4] = {b1,b2,b3,b4};

Point b1 = {1,1};
Point b2 = {b1.x,b1.y+1};
Point b3 = {b1.x,b1.y+2};
Point b4 = {b1.x,b1.y+3};

Point BoatVert[4] = {b1,b2,b3,b4};

Point c1 = {1,1};
Point c2 = {c1.x+1,c1.y};
Point c3 = {c1.x+2,c1.y};

Point BoatHorz[3] = {c1,c2,c3};

void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
  xcursor=4; //initial cursor position
  ycursor=4; 
  ShotCounter = 16;
  SetAuxLEDsBinary(B11111111);
}

void loop() 
{
  DrawBay(); //method for drawing the island border, first as everything over it
  DrawAmmo(); //method for drawing Ammo, second just in case to overide backdrop
  DrawCursor(); //method for drawing the cursor, last to overide background
  DrawBoat();
  DisplaySlate();
  delay(200);
 // ClearSlate();
  //DrawAmmo();
}

void DrawCursor()
{
  CursorCounter++;
  if (CursorCounter > 10)
  {
    CursorCounter = 0;
  }
  if (CursorCounter%2 == 0)
  {
    DrawPx(xcursor,ycursor,7);
  }

  if (CursorCounter%2 == 1)
    {
    DrawPx(xcursor,ycursor,0);
    }

  /*DrawPx(xcursor,ycursor,7);
  DisplaySlate();
  delay(200);
  ClearSlate();
  DrawBay(); //within drawing cursor to prevent blinking 
  DrawAmmo();
  DisplaySlate();
  delay(200);*/
    
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
    //DisplaySlate();  
  }
}

void DrawAmmo()
{
  CheckButtonsDown(); //MUST BE FIXED, shots don't fire
  {
    if (Button_A)
    {
      ShotCounter = ShotCounter - 1;
      Serial.println(ShotCounter);
      Serial.println("i wanna draw the blue now");
      DrawPx(xcursor,ycursor,1); //doesn't draw this point. if it does, it's the same color as the cursor. PROBLEM
    }
  
  
  
  
  for (int i = 0; i < 8; i++)
  {
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      
  if (ShotCounter == 16)
    SetAuxLEDsBinary(B11111111);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 15)
    SetAuxLEDsBinary(B11111110);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 14)
    SetAuxLEDsBinary(B11111100);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 13)
    SetAuxLEDsBinary(B11111000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 12)
    SetAuxLEDsBinary(B11110000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 11)
    SetAuxLEDsBinary(B11100000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 10)
    SetAuxLEDsBinary(B11000000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 9)
    SetAuxLEDsBinary(B10000000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 8)
    SetAuxLEDsBinary(B00000000);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,3);
  }
  
  if (ShotCounter == 7)
    for (int j = 0; j < 7; j++)
  {
    DrawPx(PxAmmo[j].x,PxAmmo[j].y,3);
  }

  if (ShotCounter == 6)
    for (int i = 0; i < 6; i++)
  {
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,3);
  }    
  
  }      
}

void DrawBoat()
{
  for (int Length = 0;Length < 4;Length++)
  {
    DrawPx(BoatVert[Length].x+MoveBoatx,BoatVert[Length].y+MoveBoaty,1);
    if (MoveBoaty > 2)
      MoveBoaty = random(1)+1;
//      Serial.println("MoveBoaty");
//      Serial.println(MoveBoaty);
  }
  for (int Length = 0;Length < 3;Length++)
  {
    DrawPx(BoatHorz[Length].x+MoveBoatx,BoatHorz[Length].y+MoveBoaty,1);
    if (MoveBoatx > 3)
      MoveBoatx = random(3)+1;
//      Serial.println("MoveBoatx");
//      Serial.println(MoveBoatx);
 
//    if (BoatHorz[Length].x+MoveBoatx == BoatVert[Length].y+MoveBoaty);
//      Serial.println("BoatHorz[Length].x+MoveBoatx");
//      Serial.println(BoatHorz[Length].x+MoveBoatx);
//      MoveBoatx = random(5+1);
//      MoveBoaty = random(5+1);
  }
}
