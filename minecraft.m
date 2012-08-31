% MineCraft for MatLab
% Developer: Leif Andreas Rudlang
% Started: 30.08.2012
% Latest update: 31.08.2012

function main


figure('Units', 'Normalized', 'OuterPosition', [0 0 1 1],'Color',[0.6 0.6 1]);

campos('manual');
camva('manual');
camva(80);
camtarget('manual');
camproj('perspective');
axis square;



axis([0,50,0,50,0,50]);
axis off;

BLOCKS = zeros(100, 100, 100);
BlockType = 1;
GAME = 1;
TTT = 0;
mX = 0; mY = 0;
dY = 0; dX = 0;
Strafe = 0; Fwd = 0;
DeltaY = 0; DeltaX = 0;
cPos = [14,14,13.5];
cDir = [0,1,0];
cTraceType = 1;
cTrace = [0,0,0];

cX = 0.000; cY = 0.000;  

set(gcf,'KeyPressFcn',@keypress_callback);
set(gcf,'WindowButtonMotionFcn',@mouse_move);


for I = 1:29

    for I2 = 1:29
    spawnCube(I,I2,10,BlockType);
    end
end

while GAME

    Strafe = Strafe-Strafe/5;
    StrafeTrace = round(cPos + [sin(cY+pi/2)*sign(Strafe)*0.65,cos(cY+pi/2)*sign(Strafe)*0.65,-1]); 
    if BLOCKS(StrafeTrace(1),StrafeTrace(1),StrafeTrace(1)) == 0
    cPos = cPos -  [sin(cY+pi/2)*Strafe,cos(cY+pi/2)*Strafe,0]; 
    else
    Strafe = 0;
    end    
    
    Fwd = Fwd - Fwd/5;
    FwdTrace = round (cPos + [cDir(1)*sign(Fwd)*0.65,cDir(2)*sign(Fwd)*0.65,-1]); 
    if BLOCKS(FwdTrace(1),FwdTrace(2),FwdTrace(3)) == 0
    cPos = cPos + [cDir(1)*Fwd,cDir(2)*Fwd,0]; 
    else
        Fwd = 0;
    end
    
cY = cY - dY*2;
cX = cX - dX*2;
dX = 0;
dY = 0;

%falling if no blocks under
cTrace = round([cPos(1),cPos(2),cPos(3)-1.5]);

if cPos>0
cTraceType = BLOCKS(cTrace(1),cTrace(2),cTrace(3));
end

cDir = [sin(cY),cos(cY),cX];
camtarget(cPos+cDir); 
campos(cPos);

if cTraceType == 0
cPos = cPos + [0,0,-0.1];
end


drawnow;


end

function mouse_move (object, eventdata)
 
if TTT
 set(0,'PointerLocation',[1000 500]);
 C = get (gcf, 'CurrentPoint');
 mX = C(1,2); mY = C(1,1);
    TTT=0; DeltaX = mX; DeltaY = mY;
 dX = 0; dY = 0;

else
    TTT=1;
C = get (gcf, 'CurrentPoint');
mX = C(1,2); mY = C(1,1);

dX = (mX-DeltaX);
dY = (mY-DeltaY);


DeltaX = mX; DeltaY = mY;


%title(gca, ['(X,Y) = (', num2str(mX-DeltaX), ', ',num2str(mY-DeltaY), ')']);


if cX < -1.75
cX = -1.75;
end
if cX > 1.75
cX = 1.75;
end
end




end

    function keypress_callback(gcbo, event)
        
        K = event.Key;
        
        if K == 'w'
            if Fwd < 0.54
            Fwd = Fwd+0.05;
            end
          
        end
        if K == 's'
            if Fwd > -0.54
            Fwd = Fwd-0.05;
            end
         
        end
        if K == 'a'
            if Strafe < 0.54
            Strafe = Strafe+0.1;
            end
         
        end
        if K == 'd'
            if Strafe > -0.54
            Strafe = Strafe-0.1;
            end
         
             
        end
        
        switch K
           
            case 'space'
            cPos = cPos + [0,0,3];
           
            case '1'
         
         BlockType = 1;
            case '2'    
         BlockType = 2;   
            case '3'
         BlockType = 3;      
            case '4' 
         BlockType = 4;       
            case 'q'
                GAME = 0;
                close;
                return
            case 'p'
                  
            case 'b'
                
             spawnCube(round(cPos(1)+cDir(1)),round(cPos(2)+cDir(2)),round(cPos(3)+cDir(3)),BlockType);   
            case 'n'
             deleteCube(round(cPos(1)+cDir(1)),round(cPos(2)+cDir(2)),round(cPos(3)+cDir(3)));   
               
             
        end
        
        
        
      
        
    end

%function to spawn a cube
function spawnCube(pX, pY, pZ, InType)

    switch InType
        case 1
        CubeColor = [0.2,0.2,0.1; 0.2,0.2,0.1; 0.2,0.2,0.1; 0.2,0.2,0.1; 0.2,0.2,0.1; 0,0.5,0;];
        case 2
        CubeColor = [0.7,0.7,0.7; 0.7,0.7,0.7; 0.7,0.7,0.7; 0.7,0.7,0.7; 0.7,0.7,0.7; 0.7,0.7,0.7;];
        case 3
        CubeColor = [1,0,0; 1,0,0; 1,0,0; 1,0,0; 1,0,0; 1,0,0;];  
         case 4
        CubeColor = [0,0,1; 0,0,1; 0,0,1; 0,0,1; 0,0,1; 0,0,1;];  
    end
fm = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];
vm = [-0.5+pX -0.5+pY -0.5+pZ; 0.5+pX -0.5+pY -0.5+pZ; 0.5+pX 0.5+pY -0.5+pZ; -0.5+pX 0.5+pY -0.5+pZ; -0.5+pX -0.5+pY 0.5+pZ; 0.5+pX -0.5+pY 0.5+pZ; 0.5+pX 0.5+pY 0.5+pZ; -0.5+pX 0.5+pY 0.5+pZ];
B = patch('Vertices',vm,'Faces',fm, 'FaceVertexCData',CubeColor,'FaceColor','flat'); 
BLOCKS(pX, pY, pZ) =  B;

end

function deleteCube(pX, pY, pZ)

   
B = BLOCKS(pX, pY, pZ);
delete(B);

BLOCKS(pX, pY, pZ) = 0;

end

    end
