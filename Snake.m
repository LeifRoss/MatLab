% Snake for MatLab
% Developer: Leif Andreas Rudlang
% Date: 29.08.2012

function main
  

    axis([0,10,0,10]);
    dirX = 0; dirY = 1;
    X = [0,0,1,1];
    Y = [1,0,0,1];
    PosX = 0;
    PosY = 0;
    aPosX = [0];
    aPosY = [0];
    WHITE = [0.9,0.9,0.9];
    RGB = [0,0,1];
    RED = [1,0,0];
    RUN = 1;
    SNAKESIZE = 1;
    GAME = 1;
    I = 0;
    grid on;
    PAUSE = 0;

            message = sprintf('score: 0');      
            title(message);
    
    %color entire screen
    for H = 0:10
 for H2 = 0:10
 
 patch(X+H,Y+H2,WHITE);
 end
    end
    
set(gcf,'KeyPressFcn',@keypress_callback)
    

FoodX = X+5;
FoodY = Y+5;


patch(FoodX,FoodY,RED);

while RUN == 1
if PAUSE
   pause(0.5); 
else


     
 PosX = PosX + dirX;
 PosY = PosY + dirY;
 if PosX >= 10 
     PosX = 0;
 end
  if PosX < 0 
     PosX = 10;
  end
  if PosY >= 10 
     PosY = 0;
 end
  if PosY < 0 
     PosY = 10;
 end
  aPosY = [aPosY , PosY];
  aPosX = [aPosX , PosX];
 
 
 if X+PosX == FoodX & Y+PosY == FoodY
   beep;
     SNAKESIZE = SNAKESIZE + 1;
     message = sprintf('score: %i',SNAKESIZE-1);      
            title(message);
RX = rand(1)*9;
RY = rand(1)*9;
FoodX = X+round(RX);
FoodY = Y+round(RY);    
 end




 patch(X+PosX,Y+PosY,RGB);

 if I>0
 R = numel(aPosX)-SNAKESIZE;
 X2 = X+aPosX(R);
 Y2 = Y+aPosY(R);
 
 
 %check for snake collisions
 INDEX = numel(aPosX);
 
 for N = 1:SNAKESIZE
     N1 = INDEX-N;
  cX = aPosX(N1);
  cY = aPosY(N1);
 
  if PosX == cX & PosY == cY
             message = sprintf('GAME OVER, your score: %i ',SNAKESIZE-1);      
            title(message);
      RUN = 0;
  end
 end
 %draw white overlay
 patch(X2,Y2,WHITE);
 end        
 I = I + 1;  

 patch(FoodX,FoodY,RED);  
        drawnow;
    pause(0.25);
    
end
end

    
    function keypress_callback(gcbo, event)
        
        switch event.Key
            case 'w'
                dirY = 1;   
                dirX = 0;
            case 's'   
                dirY = -1; 
                dirX = 0;
            case 'a'
                dirX = -1;
                dirY = 0;
            case 'd'
                dirX = 1;
                dirY = 0;
            case 'q'
                RUN = 0;
                close;
                return
            case 'p'
                  
                if(PAUSE)
                PAUSE = 0;
                 message = sprintf('score: %i ',SNAKESIZE-1);    
            title(message);
                else
                PAUSE = 1;   
                message = sprintf('Game Paused');         
            title(message); 
                
        end
        end
        
        
        
      
        
    end

end

