/* 
Create two boolean variables: WonGame / LostGame; both start false
In voidloop call three 'if' statements: 
  The first: if (wonGame == false) 
  the second: if (wonGame == true)
  the third: if (lostGame == true)

if wonGame == false, have the game play out.
if wonGame == true, call upon the method that will regenerate the game and then write in a winning tone sound. (if time for levels, this will then increase the level)
if lostGame == true, call upon the method that will regenerate the game and then write in a losing tone sound. this will fix the out of shots problem and still drawing blue
_____
In order for for wonGame to == true, all the boats must be found before OutofShots == true. 
In order for lostGame to == true, OutofShots == true.
______

create another boolean called isRed = false;
The red represents a ship that has been found in the ocean.
When clicked with the cursor, it will show up as red, not blue.
If isRed == true, isBlue = false. It shouldn't draw blue over the red dot. 
if there is a boat, it will not draw over it.
  want it to draw red.
                                  

*/

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

Point a1 = {0,7}; //Points in array for displaying ammo on the Px Board
Point a2 = {1,7};
Point a3 = {2,7};
Point a4 = {3,7};
Point a5 = {4,7};
Point a6 = {5,7};
Point a7 = {6,7};
Point a8 = {7,7};
  
Point PxAmmo[8] = {a1,a2,a3,a4,a5,a6,a7,a8}; //Ammo on board array

int xcursor; //x and y coordinates of the cursor
int ycursor;
int CursorCounter = 0; //counts interations for the modulous to blink cursor
int ShotCounter; //counter to keep track of ammo remaining
boolean isBlue = false; //boolean variable to display drawn missed shots
boolean isRed = false; //boolean variable to display drawn hits
boolean OutofShots; // boolean variable to disable shooting once ammo is at zero
int MoveBoatx = random(5); //random xcoordinate for boat
int MoveBoaty = random(5); //random ycoordinate for boat

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

Point b1 = {1,1}; //Points in array for another boat
Point b2 = {b1.x,b1.y+1};
Point b3 = {b1.x,b1.y+2};
Point b4 = {b1.x,b1.y+3};

Point BoatVert[4] = {b1,b2,b3,b4};

Point c1 = {1,1}; //Points in array for boat
Point c2 = {c1.x+1,c1.y};
Point c3 = {c1.x+2,c1.y};

Point BoatHorz[3] = {c1,c2,c3};

Point d1 = {5,6}; //Points in array for boat
Point d2 = {5,5};
Point d3 = {5,4};

Point Boat3[3] = {d1,d2,d3};

boolean wonGame = false; //the game starts off as not being won. called when conditions are met to win the game
boolean lostGame = false; //if the player runs out of ammo, then this will be changed to true and the board will reset with a losing sound

void setup()
{
  MeggyJrSimpleSetup();
  Serial.begin(9600);
  xcursor=4; //initial cursor position
  ycursor=4; 
  ShotCounter = 16; //start game with max ammo
  OutofShots = false; //enable shooting 
  SetAuxLEDsBinary(B11111111); //display all LEDs for max ammo
}

void loop() 
{
  if (wonGame == false) // playing the game! :) //(MIGHT need to say wonGame == false && lostGame == false)
    {
      DrawBay(); //method for drawing the island border, first as everything over it
      DrawAmmo(); //method for drawing Ammo, second just in case to overide backdrop
      
      DrawBoat(); //REPLACE WITH drawBoats()
      
      DrawCursor(); //method for drawing the cursor, last to overide background
    }
  
  if (wonGame == true) //the player has won the game (found all of the boats without running out of ammo)
    {
      //call method for drawing a new board
      //winning sound!
        //if time for levels, increase level by one here.
      wonGame = false; //sets the game back to 'playing' mode, so to speak
    }
  
  if (lostGame == true) //if the player has run out of ammo without finding all the boats
    {
      //call method for drawing out a new board
      //losing sound
      lostGame = false;
      wonGame = false; //sets the game back to 'playing' mode, so to speak
    }
     
  DisplaySlate();
  delay(200);
  // ClearSlate();
  //DrawAmmo();
}

//void drawBoats()
//{
//  //code will draw boats randomly and check to see if they are overlapping. if they are, redraw them
//}

void DrawCursor()
{
  CursorCounter++; //adds one to cursorcounter every iteration to blink

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
    if (Button_Right) //move cursor right
    {
      if (isBlue) //checks if dot underneath cursor is blue
      {
        isBlue = false; //if it is don't draw another one
        DrawPx(xcursor,ycursor,Blue);
      }
      else DrawPx(xcursor,ycursor,0); //if not draw the cursor Dark to blink it
      xcursor=xcursor+1; 
      if (xcursor==7)
      {
        xcursor=6;
      }
      
//      if (isRed)
//      {
//        isRed = false;
//        DrawPx(xcursor,ycursor,Red);
//      }
//      else DrawPx(xcursor,ycursor,0);
//      xcursor=xcursor+1;
    }
    if (Button_Up) //moves cursor up
    {
      if (isBlue) //checks if dot underneath cursor is blue; same thing
      {
        isBlue = false;
        DrawPx(xcursor,ycursor,Blue);
      }
      else DrawPx(xcursor,ycursor,0);
      ycursor=ycursor+1;
      if (ycursor==7)
        ycursor=6;
      
//      if (isRed)
//      {
//        isRed = false;
//        DrawPx(xcursor,ycursor,Red);
//      }
//      else DrawPx(xcursor,ycursor,0);
//      ycursor=ycursor+1;
    }
    if (Button_Left) //same thing for button left
    {
      if (isBlue)
      {
        isBlue = false;
        DrawPx(xcursor,ycursor,Blue);
      }
      else DrawPx(xcursor,ycursor,0);
      xcursor=xcursor-1;
      if (xcursor==0)
        xcursor=1;

//      if (isRed)
//      {
//        isRed = false;
//        DrawPx(xcursor,ycursor,Red);
//      }
//      else DrawPx(xcursor,ycursor,0);
//      xcursor=xcursor-1;
    }
    if (Button_Down) //same thing for button down
    {
      if (isBlue)
      {
        isBlue = false;
        DrawPx(xcursor,ycursor,Blue);
      }
      else DrawPx(xcursor,ycursor,0);
      ycursor=ycursor-1;
      if (ycursor==0)
        ycursor=1;
    
//      if (isRed)
//      {
//        isRed = false;
//        DrawPx(xcursor,ycursor,Red);
//      }
//      else DrawPx(xcursor,ycursor,0);
//      ycursor=ycursor-1;
    }
  }
  if (CursorCounter > 10) //resets cursor counter so it doesn't just increase forever
  {
    CursorCounter = 0;
  }
  if (CursorCounter%2 == 0) //modulous to make cursor blink every two iteration 
  {
    if (ReadPx(xcursor,ycursor) == Blue) isBlue = true; //code to maintain blue 
    {
      DrawPx(xcursor,ycursor,7);
    }
//    if (ReadPx(xcursor,ycursor) == Red) isRed = true;
//    {
//      DrawPx(xcursor,ycursor,1);
//    }
  }

  if (CursorCounter%2 == 1) //other half of blinking cursor code
  {
    if (ReadPx(xcursor,ycursor) == Blue) isBlue = true;
    {
      DrawPx(xcursor,ycursor,0);
    }
//    if (ReadPx(xcursor,ycursor) == Red) isRed = true;
//    {
//      DrawPx(xcursor,ycursor,1);
//    }
  }
}

void DrawBay() //code to draw the bay borders of game
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
  CheckButtonsDown(); //Code to shoot ammo
  {
    if (Button_A)
    {
      if (OutofShots == false);
        {
          Serial.println(ShotCounter);
          Serial.println("i wanna draw the blue now");
          Serial.println(OutofShots);
          ShotCounter = ShotCounter - 1; //decrease shot counter with every shot
          DrawPx(xcursor,ycursor,Blue); //Draw a blue dot to mark misses
        }
       for (int Length = 0;Length < 3;Length++)
         {
           if (xcursor== BoatVert[Length].x && ycursor == BoatVert[Length].y)
             {
               DrawPx(xcursor,ycursor,1);
             }
         }
       else // if outofshots == true
         {
           lostGame = true; //this will make it regester the if (lostgame == true) if statement in void loop... regenerates the board with a losing sound
         }
    }
  
  
  
  
  for (int i = 0; i < 8; i++) //code to display and decrease ammo displayed 
  {
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      
  if (ShotCounter == 16)
    SetAuxLEDsBinary(B11111111);
    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 15)
    SetAuxLEDsBinary(B11111110);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 14)
    SetAuxLEDsBinary(B11111100);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 13)
    SetAuxLEDsBinary(B11111000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 12)
    SetAuxLEDsBinary(B11110000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 11)
    SetAuxLEDsBinary(B11100000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 10)
    SetAuxLEDsBinary(B11000000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 9)
    SetAuxLEDsBinary(B10000000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  if (ShotCounter == 8)
    SetAuxLEDsBinary(B00000000);
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
  }
  
  if (ShotCounter == 7)
    for (int i = 0; i < 7; i++)
  {
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark); //draw dark over color to erase and decrease shots
  }
  if (ShotCounter == 6)
    for (int i = 0; i < 6; i++)
  {
//    DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
    DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
    DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
  }    
  if (ShotCounter == 5)
    for (int i = 0; i < 5; i++)
    {
//      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
      DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
      DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
    }
  if (ShotCounter == 4)
    for (int i = 0; i < 4; i++)
    {
//      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
      DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
      DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
      DrawPx(PxAmmo[4].x,PxAmmo[4].y,Dark);
    }
  if (ShotCounter == 3)
    for (int i = 0; i < 3; i++)
    {
//      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
      DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
      DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
      DrawPx(PxAmmo[4].x,PxAmmo[4].y,Dark);
      DrawPx(PxAmmo[3].x,PxAmmo[3].y,Dark);      
    }
  if (ShotCounter == 2)
    for (int i = 0; i < 2; i++)
    {
//      DrawPx(PxAmmo[i].x,PxAmmo[i].y,2);
      DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
      DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
      DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
      DrawPx(PxAmmo[4].x,PxAmmo[4].y,Dark);
      DrawPx(PxAmmo[3].x,PxAmmo[3].y,Dark);  
      DrawPx(PxAmmo[2].x,PxAmmo[2].y,Dark);        
    }
  if (ShotCounter == 1)
  {
    DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
    DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
    DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
    DrawPx(PxAmmo[4].x,PxAmmo[4].y,Dark);
    DrawPx(PxAmmo[3].x,PxAmmo[3].y,Dark);  
    DrawPx(PxAmmo[2].x,PxAmmo[2].y,Dark);   
    DrawPx(PxAmmo[1].x,PxAmmo[1].y,Dark);       
  }
  if (ShotCounter <= 0)
  {
    OutofShots = true;
    DrawPx(PxAmmo[7].x,PxAmmo[7].y,Dark);
    DrawPx(PxAmmo[6].x,PxAmmo[6].y,Dark);
    DrawPx(PxAmmo[5].x,PxAmmo[5].y,Dark);
    DrawPx(PxAmmo[4].x,PxAmmo[4].y,Dark);
    DrawPx(PxAmmo[3].x,PxAmmo[3].y,Dark);  
    DrawPx(PxAmmo[2].x,PxAmmo[2].y,Dark);   
    DrawPx(PxAmmo[1].x,PxAmmo[1].y,Dark);   
    DrawPx(PxAmmo[0].x,PxAmmo[0].y,Dark);   
  }
  }      
}

void DrawBoat() //code to draw boat arrays
{
  for (int Length = 0;Length < 4;Length++)
  {
    DrawPx(BoatVert[Length].x+MoveBoatx,BoatVert[Length].y+MoveBoaty,Dark);
    if (MoveBoaty > 2)
      MoveBoaty = random(1)+1;
//      Serial.println("MoveBoaty");
//      Serial.println(MoveBoaty);
  }
  for (int Length = 0;Length < 3;Length++)
  {
    DrawPx(BoatHorz[Length].x+MoveBoatx+1,BoatHorz[Length].y+MoveBoaty-1,Dark);
    if (MoveBoatx > 3)
      MoveBoatx = random(3)+1;
      
    DrawPx(Boat3[Length].x,Boat3[Length].y,Dark);
//      Serial.println("MoveBoatx");
//      Serial.println(MoveBoatx);
 
//    if (BoatHorz[Length].x+MoveBoatx == BoatVert[Length].y+MoveBoaty);
//      Serial.println("BoatHorz[Length].x+MoveBoatx");
//      Serial.println(BoatHorz[Length].x+MoveBoatx);
//      MoveBoatx = random(5+1);
//      MoveBoaty = random(5+1);
  }
}
