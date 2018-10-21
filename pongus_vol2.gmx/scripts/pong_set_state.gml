#define pong_set_state
///pong_set_state()

switch (argument0)
{
    case ePONG.intermission:
        // Init state
        intenseFlash = 1;
        intermAnim = 0;
        intermWindup = 0;
        
        intermTableX = tableX;
        intermTableY = tableY;
        intermBallX = ballX;
        intermBallY = ballY;
        
        intermCamX = camX;
        intermCamY = camY;
        intermCamZ = camZ;
        intermCamR = camRot;
        intermCamS = camShake;
        break;
        
    case ePONG.title:
        // DOG!!!
        dogX = room_width / 2;
        dogY = room_height / 2;
        
        var dir = random_range(0, 360);
        var spd = random_range(10, 20);
        
        dogVX = lengthdir_x(spd, dir);
        dogVY = lengthdir_y(spd, dir);
        
        break;
}

gameState = argument0;

#define pong_score
///pong_score(side)

if (argument0 == 0)
    p1Score++;
else
    p2Score++;

scoreSide = argument0;
pong_set_state(ePONG.intermission);
intermAnim = 0;
intermState = 1;
gameIntermission = 120;

pong_camera_shake(random_range(-8, 8), random_range(-8, 8), random_range(-8, 8), random_range(-15, 15), random_range(2, 4));

quipIdx = irandom_range(0, array_length_1d(quips) - 1);

if (max(p1Score, p2Score) >= 5)
{
    pong_set_state(ePONG.results);
    
    if (p1Score > p2Score)
        winner = 0;
    else
        winner = 1;
}

#define pong_reset

p1Score = 0;
p2Score = 0;
p1Y = 0;
p2Y = 0;
p1Vel = 0;
p2Vel = 0;

// Reset table position
tableX = room_width / 2;
tableY = room_height / 2;
tableVX = 0;
tableVY = 0;

pong_set_state(ePONG.title);

ballVX = 0;
ballVY = 0;

// Reset cam
var VIEW_W = view_wport[0];
var VIEW_H = view_hport[0];
camVX = 0;
camVY = 0;
camVZ = 0;
camX = VIEW_W / 2;
camY = VIEW_H / 2;
camZ = 1;
camRot = 0;
camShake = 0;

// End victory
superIntense = 0;
intensity = 0;
targetIntensity = 0;
intenseFlash = 0;
boringCtr = 0;
scoreIntense = 0;
intermState = 0; // Show different message in intermisison?