

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogLeft, groundhogRight, groundhogDown;
PImage bg, life, cabbage, stone1, stone2, soilEmpty;
PImage soldier;
PImage soil0, soil1, soil2, soil3, soil4, soil5;
PImage[][] soils, stones;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int SOIL_COL_COUNT = 8;
final int SOIL_ROW_COUNT = 24;
final int SOIL_SIZE = 80;

int[][] soilHealth;

final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;


float[] soldierX= new float[6];
float[] soldierY= new float[6];
float[] cabbageX= new float[6];
float[] cabbageY= new float[6];

boolean leftSoilHealthDecrease= false;
boolean rightSoilHealthDecrease= false;
boolean downSoilHealthDecrease= false;
float soldierSpeed = 2f;

float playerX, playerY;
int playerCol, playerRow;
final float PLAYER_INIT_X = 4 * SOIL_SIZE;
final float PLAYER_INIT_Y = - SOIL_SIZE;
boolean leftState = false;
boolean rightState = false;
boolean downState = false;
int playerHealth = 2;
final int PLAYER_MAX_HEALTH = 5;
int playerMoveDirection = 0;
int playerMoveTimer = 0;
int playerMoveDuration = 15;

int [] space1 = new int [24];
int [] space2 = new int [24];
  
boolean demoMode = false;

void setup() {
  
//soilEmpty
  for(int n=0; n<24; n++){
  space1[n] = (int)(floor(random(0,8))*SOIL_SIZE);
  }
  
  for(int n=0; n<24; n++){
  space2[n] = (int)(floor(random(0,8))*SOIL_SIZE);
  }

  println(cabbageX);


	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle = loadImage("img/groundhogIdle.png");
	groundhogLeft = loadImage("img/groundhogLeft.png");
	groundhogRight = loadImage("img/groundhogRight.png");
	groundhogDown = loadImage("img/groundhogDown.png");
	life = loadImage("img/life.png");
	soldier = loadImage("img/soldier.png");
	cabbage = loadImage("img/cabbage.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");

	soilEmpty = loadImage("img/soils/soilEmpty.png");

	// Load soil images used in assign3 if you don't plan to finish requirement #6
	soil0 = loadImage("img/soil0.png");
	soil1 = loadImage("img/soil1.png");
	soil2 = loadImage("img/soil2.png");
	soil3 = loadImage("img/soil3.png");
	soil4 = loadImage("img/soil4.png");
	soil5 = loadImage("img/soil5.png");

	// Load PImage[][] soils
	soils = new PImage[6][5];
	for(int i = 0; i < soils.length; i++){
		for(int j = 0; j < soils[i].length; j++){
			soils[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".png");
		}
	}



	// Load PImage[][] stones
	stones = new PImage[2][5];
	for(int i = 0; i < stones.length; i++){
		for(int j = 0; j < stones[i].length; j++){
			stones[i][j] = loadImage("img/stones/stone" + i + "/stone" + i + "_" + j + ".png");
		}
	}

	// Initialize player
	playerX = PLAYER_INIT_X;
	playerY = PLAYER_INIT_Y;
	playerCol = (int) (playerX / SOIL_SIZE);
	playerRow = (int) (playerY / SOIL_SIZE);
	playerMoveTimer = 0;
	playerHealth = 2;

	// Initialize soilHealth
	soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
	for(int i = 0; i < soilHealth.length; i++){
		for (int j = 0; j < soilHealth[i].length; j++) {
			 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
			soilHealth[i][j] = 15;
		}
	}

 //row 1~8 soilHealth
    for(int i = 0; i < 8; i++){
        soilHealth[i][i] =30;
    }

 //row 9~16 soilHealth
        for(int i=0;i<8;i++){
        for(int j=0;j<8;j++){
          int x = j+8;
          if(i%4==0){
            if(j%4>0 && j%4<3){
          soilHealth[i][x] =30;
          soilHealth[i+3][x] =30;
          } 
          
          else{
          soilHealth[i+1][x] =30;
          soilHealth[i+2][x] =30;
          }
          }
      }
    }
    
//row 17~24


//soilEmpty
    for(int i=1;i<SOIL_ROW_COUNT;i++){
    for(int j=0; j<SOIL_ROW_COUNT;j++){
          soilHealth[space1[i]/SOIL_SIZE][i] =0;
          soilHealth[space2[i]/SOIL_SIZE][i] =0;
    }
    }
    
        for(int i=0;i<6;i++){
          
    image(cabbage,cabbageX[i],cabbageY[i]);
    }
    
	// Initialize soidiers and their position
        for(int n=0; n<6; n++){
          soldierX[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
        }
  
      for(int n=0; n<6; n++){
      soldierY[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
      }
  
	// Initialize cabbages and their position
      for(int n=0; n<6; n++){
        int cabbageXX = (floor(random(0,8))*SOIL_SIZE);
        cabbageX[n] = (int) cabbageXX;
      }

      for(int n=0; n<6; n++){
        cabbageY[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
      }
}

void draw() {

	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}

		break;

		case GAME_RUN: // In-Game
		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

	    // CAREFUL!
	    // Because of how this translate value is calculated, the Y value of the ground level is actually 0
		pushMatrix();
		translate(0, max(SOIL_SIZE * -18, SOIL_SIZE * 1 - playerY));

		// Ground

		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil
for(int n = 5; n >0 ; n--){
		for(int i = 0; i < soilHealth.length; i++){
			for (int j = 0; j < soilHealth[i].length; j++) {

				// Change this part to show soil and stone images based on soilHealth value
				// NOTE: To avoid errors on webpage, you can either use floor(j / 4) or (int)(j / 4) to make sure it's an integer.
				int areaIndex = floor(j / 4);
        if(soilHealth[i][j]<=30 && soilHealth[i][j]>15){
        image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);
        }
        if(soilHealth[i][j]<3*n+1 && soilHealth[i][j]>3*(n-1)){
				image(soils[areaIndex][n-1], i * SOIL_SIZE, j * SOIL_SIZE);
        }
        if(soilHealth[i][j]==0){
        image(soilEmpty, i * SOIL_SIZE, j * SOIL_SIZE);
        }
        
        }
			}
		}

    // Stone
    // row 1~8
for(int n = 5; n >0 ; n--){
    for(int i = 0; i < 8; i++){
        int areaIndex = floor(i / 4);
        if(soilHealth[i][i]<15+3*n+1 && soilHealth[i][i]>15){
        image(soils[areaIndex][4], i * SOIL_SIZE, i * SOIL_SIZE);
        image(stones[0][n-1], i * SOIL_SIZE, i * SOIL_SIZE);
        }
    }
}
    
    // row 9~16
for(int n = 5; n >0 ; n--){
    for(int i=0;i<8;i++){
        for(int j=8;j<16;j++){
          int areaIndex = floor(j / 4);
        if(soilHealth[i][j]<15+3*n+1 && soilHealth[i][j]>15){
           

          if(j%4>0 && j%4<3){
          image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);
          image(stones[0][n-1],i* SOIL_SIZE,j* SOIL_SIZE);
          } 
          
          else{
          image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);
          image(stones[0][n-1],i* SOIL_SIZE,j* SOIL_SIZE);
          }
        }
      }
    }
}

    //row 17~24
    
    pushMatrix();
    translate(0,16*SOIL_SIZE);
    for(int j=0;j<16;j++){
      for(int i=0;i<8;i++){
        int stoneX = width*2-SOIL_SIZE;
        stoneX = stoneX-SOIL_SIZE*j;
        if(j%3>0){
          image(stone1,stoneX-SOIL_SIZE*i,i*SOIL_SIZE);
        }
        if(j%3==2){
          image(stone2,stoneX-SOIL_SIZE*i,i*SOIL_SIZE);
        }
      }
    }
    popMatrix();
     
     //soilEmpty
    for(int i=1;i<SOIL_ROW_COUNT;i++){
    for(int j=0; j<SOIL_ROW_COUNT;j++){
    image(soilEmpty, space1[i],i * SOIL_SIZE);
    image(soilEmpty, space2[i],i * SOIL_SIZE);
    }
    }
		// Cabbages

    for(int i=0;i<6;i++){
    image(cabbage,cabbageX[i],cabbageY[i]);
    }
		// > Remember to check if playerHealth is smaller than PLAYER_MAX_HEALTH!

		// Groundhog

		PImage groundhogDisplay = groundhogIdle;

		// If player is not moving, we have to decide what player has to do next
		if(playerMoveTimer == 0){

			// HINT:
			// You can use playerCol and playerRow to get which soil player is currently on

        if(playerRow==23){
          playerRow=23;
        }
        else{
        if(soilHealth[playerCol][playerRow+1]==0){
        downState =true;
        }
        }

        
        
			// Check if "player is NOT at the bottom AND the soil under the player is empty"
			// > If so, then force moving down by setting playerMoveDirection and playerMoveTimer (see downState part below for example)
			// > Else then determine player's action based on input state

			if(leftState){
        if(playerY>=0){
        if(soilHealth[playerCol-1][playerRow]>0){
          if(leftSoilHealthDecrease){
            soilHealth[playerCol-1][playerRow]--;
            groundhogDisplay = groundhogLeft;
          }
          
        }
        if(soilHealth[playerCol-1][playerRow]==0){
				groundhogDisplay = groundhogLeft;

				// Check left boundary
				if(playerCol > 0){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the left"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = LEFT;
					playerMoveTimer = playerMoveDuration;
        }

				}
        }
        else{
        playerMoveDirection = LEFT;
        playerMoveTimer = playerMoveDuration;
        }

        

			}else if(rightState){
          if(playerY>=0){
          if(soilHealth[playerCol+1][playerRow]>0){
          if(rightSoilHealthDecrease){
            soilHealth[playerCol+1][playerRow]--;
            groundhogDisplay = groundhogRight;
          }
        }
        if(soilHealth[playerCol+1][playerRow]==0){
				groundhogDisplay = groundhogRight;

				// Check right boundary
				if(playerCol < SOIL_COL_COUNT - 1){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the right"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = RIGHT;
					playerMoveTimer = playerMoveDuration;

				}
        }
          }
        else{
        playerMoveDirection = RIGHT;
        playerMoveTimer = playerMoveDuration;
        }
			}else if(downState){
          if(soilHealth[playerCol][playerRow+1]>0){
          if(downSoilHealthDecrease){
            soilHealth[playerCol][playerRow+1]--;
          }
        }
				groundhogDisplay = groundhogDown;

        if(playerRow==24){
        downState =false;
        }
        if(soilHealth[playerCol][playerRow+1]==0){
        downState =false;
        }
				// Check bottom boundary

				// HINT:
				// We have already checked "player is NOT at the bottom AND the soil under the player is empty",
				// and since we can only get here when the above statement is false,
				// we only have to check again if "player is NOT at the bottom" to make sure there won't be out-of-bound exception
				if(playerRow < SOIL_ROW_COUNT - 1){

					// > If so, dig it and decrease its health

					// For requirement #3:
					// Note that player never needs to move down as it will always fall automatically,
					// so the following 2 lines can be removed once you finish requirement #3

					playerMoveDirection = DOWN;
					playerMoveTimer = playerMoveDuration;


				}
			}

		}

		// If player is now moving?
		// (Separated if-else so player can actually move as soon as an action starts)
		// (I don't think you have to change any of these)

		if(playerMoveTimer > 0){

			playerMoveTimer --;
			switch(playerMoveDirection){

				case LEFT:
				groundhogDisplay = groundhogLeft;
				if(playerMoveTimer == 0){
					playerCol--;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SOIL_SIZE;
				}
				break;

				case RIGHT:
				groundhogDisplay = groundhogRight;
				if(playerMoveTimer == 0){
					playerCol++;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SOIL_SIZE;
				}
				break;

				case DOWN:
				groundhogDisplay = groundhogDown;
      if(soilHealth[playerCol][playerRow+1]==0){
				if(playerMoveTimer == 0){
					playerRow++;
					playerY = SOIL_SIZE * playerRow;

				}else{
					playerY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SOIL_SIZE;
				}

				break;
			}
}
		}

		image(groundhogDisplay, playerX, playerY);

		// Soldiers

        for(int i=0;i<6;i++){

        image(soldier,soldierX[i],soldierY[i]);
        soldierX[i]=soldierX[i]+2;
        
        if(soldierX[i] >width){
        soldierX[i]=-SOIL_SIZE;
  }

    }

		// > Remember to stop player's moving! (reset playerMoveTimer)
		// > Remember to recalculate playerCol/playerRow when you reset playerX/playerY!
		// > Remember to reset the soil under player's original position!

		// Demo mode: Show the value of soilHealth on each soil
		// (DO NOT CHANGE THE CODE HERE!)

		if(demoMode){	

			fill(255);
			textSize(26);
			textAlign(LEFT, TOP);

			for(int i = 0; i < soilHealth.length; i++){
				for(int j = 0; j < soilHealth[i].length; j++){
					text(soilHealth[i][j], i * SOIL_SIZE, j * SOIL_SIZE);
				}
			}

		}

		popMatrix();

		// Health UI

    //cabbage
    for(int i = 0; i<6; i++){
      if(playerX == cabbageX[i] && playerY == cabbageY[i]){
         playerHealth++;
         cabbageX[i]=0;
         cabbageY[i]=-240;
         if(playerHealth>PLAYER_MAX_HEALTH){
           playerHealth=PLAYER_MAX_HEALTH;
         }
      }
    }
    
    //soldier
        for(int i = 0; i<6; i++){
      if(playerX < soldierX[i]+(SOIL_SIZE-10) &&
         playerX+70 > soldierX[i] &&
         playerY < soldierY[i]+(SOIL_SIZE-10) &&
         playerY+70 > soldierY[i]
         ){
         playerHealth--;
        playerX = PLAYER_INIT_X;
        playerY = PLAYER_INIT_Y;
        playerCol = (int) (playerX / SOIL_SIZE);
        playerRow = (int) (playerY / SOIL_SIZE);
        playerMoveDirection = 0;
        playerMoveTimer = playerMoveDuration;
         if(playerHealth<1){
            gameState=GAME_OVER;

         }
         
      }
    }

    
    for(int j = 0; j<playerHealth; j++){
      int lifeX = 10;
      lifeX = lifeX+j*70;
      image(life,lifeX,10);
    }


    
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;

				// Initialize player
				playerX = PLAYER_INIT_X;
				playerY = PLAYER_INIT_Y;
				playerCol = (int) (playerX / SOIL_SIZE);
				playerRow = (int) (playerY / SOIL_SIZE);
				playerMoveTimer = 0;
        playerMoveDirection = 0;
				playerHealth = 2;

				// Initialize soilHealth
				soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
				for(int i = 0; i < soilHealth.length; i++){
					for (int j = 0; j < soilHealth[i].length; j++) {
						 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
						soilHealth[i][j] = 15;
					}
				}

				// Initialize soidiers and their position
        for(int n=0; n<6; n++){
          soldierX[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
        }
  
      for(int n=0; n<6; n++){
      soldierY[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
      }
				// Initialize cabbages and their position
      for(int n=0; n<6; n++){
        cabbageX[n] = (int) (floor(random(0,8))*SOIL_SIZE);
        
      }
        for(int n=0; n<6; n++){
        cabbageY[n] = (int)(floor(random(0,4))*SOIL_SIZE)+4*SOIL_SIZE*n;
      }
      
      //Initialize soilEmpty and their position
    for(int n=0; n<24; n++){
    space1[n] = (int)(floor(random(0,8))*SOIL_SIZE);
    }
    for(int i=1;i<SOIL_ROW_COUNT;i++){
    for(int j=0; j<SOIL_ROW_COUNT;j++){
          soilHealth[space1[i]/SOIL_SIZE][i] =0;
          soilHealth[space2[i]/SOIL_SIZE][i] =0;
    }
    }
    
			}

		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}
}

void keyPressed(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
      if( playerCol>0){
      leftSoilHealthDecrease = true;
			leftState = true;
      }
			break;
			case RIGHT:
      if( playerCol<7){
      rightSoilHealthDecrease = true;
			rightState = true;
      }
			break;
			case DOWN:
      downSoilHealthDecrease = true;
			downState = true;
      
			break;
		}
	}else{
		if(key=='b'){
			// Press B to toggle demo mode
			demoMode = !demoMode;
		}
	}
}

void keyReleased(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
      leftSoilHealthDecrease = false;
			leftState = false;
      
			break;
			case RIGHT:
      rightSoilHealthDecrease = false;
			rightState = false;
			break;
			case DOWN:
      downSoilHealthDecrease = false;
			downState = false;
			break;
		}
	}
}
