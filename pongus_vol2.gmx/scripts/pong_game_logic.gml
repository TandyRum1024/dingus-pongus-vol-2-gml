#define pong_game_logic

var tableHalfWid = tableWid / 2;
var tableHalfHei = tableHei / 2;

// Handle paddle
//////////////////////
pong_handle_physics();

// Handle Balls
//////////////////////
pong_handle_ball();

// Handle table moving
//////////////////////
tableX += tableVX;
tableY += tableVY;

// Handle table bumping into walls
if (tableX - tableHalfWid < 0)
{
    tableX = tableHalfWid;
    tableVX *= -0.5;
}
if (tableX + tableHalfWid > room_width)
{
    tableX = room_width - tableHalfWid;
    tableVX *= -0.5;
}

if (tableY - tableHalfHei < 0)
{
    tableY = tableHalfHei;
    tableVY *= -0.5;
}
if (tableY + tableHalfHei > room_height)
{
    tableY = room_height - tableHalfHei;
    tableVY *= -0.5;
}

// Graaadually slow down table
tableVX *= 0.98;
tableVY *= 0.98;


#define pong_title_logic
if (keyboard_check_pressed(vk_anykey))
{
    gameState = ePONG.game;
    gameCtr = 0;
    
    // Reset paddles to prevent swoocing even before you're playable
    p1Y = tableHei / 2;
    p2Y = tableHei / 2;
    p1Vel = 0;
    p2Vel = 0;
}

#define pong_handle_physics
var paddleHalfWid = paddleWid / 2;
var paddleHalfLen = paddleLen / 2;
var tableHalfWid = tableWid / 2;
var tableHalfHei = tableHei / 2;

// P1 - Paddle movement
////////////////////////
var hMove = keyboard_check(ord('S')) - keyboard_check(ord('W'));

if (hMove != 0)
{
    if (p1LastMove == hMove && p1Dash && p1DashCtr > 0)
    {
        p1Vel += hMove * 20;
        // emit_msg("SPD : " + string(p1Vel), $EE88FF, 42, p1X, p1Y, random_range(2, 5), random_range(-2, 2));
        // emit_msg("DASH!", $00DDFF, 42, p1X, p1Y, random_range(2, 5), random_range(-2, 2));
        p1DashCtr = 0;
        p1Dash = false;
        
        p1Anim[eANIM.scalex] = 0.6;
        p1Anim[eANIM.scaley] = 1.4;
    }
    else
    {
        p1LastMove = hMove;
        
        var currentSpd = p1Vel * hMove;
        if (currentSpd + 2 < 15)
            p1Vel += hMove * 2;
        else
            p1Vel += hMove * max(15 - currentSpd, 0);
        
        p1DashCtr = 7;
        p1Dash = false;
    }
}
else
{
    p1Vel *= 0.85;
    p1Dash = true;
}

// Handle dash counter
if (p1DashCtr > 0)
    p1DashCtr--;

// Check collision
if (p1Y - paddleHalfLen + p1Vel < 0) // Upperside
{
    p1Y = paddleHalfLen;
    
    // Ouch, Table is shifting!
    // tableVY += p1Vel * 0.25;
    
    if (hMove == 0)
        p1Vel *= -0.85;
    else
        p1Vel = 0;
}
if (p1Y + paddleHalfLen + p1Vel > tableHei) // Bottom side
{
    p1Y = tableHei - paddleHalfLen;
    
    // Ouch, Table is shifting!
    // tableVY += p1Vel * 0.25;
    
    if (hMove == 0)
        p1Vel *= -0.85;
    else
        p1Vel = 0;
}

// integrate
p1Y += p1Vel;


// P2 - Paddle movement
////////////////////////
hMove = keyboard_check(vk_down) - keyboard_check(vk_up);

if (hMove != 0)
{
    if (p2LastMove == hMove && p2Dash && p2DashCtr > 0)
    {
        p2Vel += hMove * 20;
        p2DashCtr = 0;
        p2Dash = false;
        
        p2Anim[eANIM.scalex] = 0.6;
        p2Anim[eANIM.scaley] = 1.4;
    }
    else
    {
        p2LastMove = hMove;
        
        var currentSpd = p2Vel * hMove;
        if (currentSpd + 2 < 15)
            p2Vel += hMove * 2;
        else
            p2Vel += hMove * max(15 - currentSpd, 0);
        
        p2DashCtr = 7;
        p2Dash = false;
    }
}
else
{
    p2Vel *= 0.85;
    p2Dash = true;
}

// Handle dash counter
if (p2DashCtr > 0)
    p2DashCtr--;

// Check collision
if (p2Y - paddleHalfLen + p2Vel < 0) // Upperside
{
    p2Y = paddleHalfLen;
    
    // Ouch, Table is shifting!
    // tableVY += p2Vel * 0.25;
    
    if (hMove == 0)
        p2Vel *= -0.85;
    else
        p2Vel = 0;
}
if (p2Y + paddleHalfLen + p2Vel > tableHei) // Bottom side
{
    p2Y = tableHei - paddleHalfLen;
    
    // Ouch, Table is shifting!
    // tableVY += p2Vel * 0.25;
    
    if (hMove == 0)
        p2Vel *= -0.85;
    else
        p2Vel = 0;
}

// integrate
p2Y += p2Vel;

#define pong_handle_ball
// BALLS!!!
////////////////////////

var paddleHalfWid = paddleWid / 2;
var paddleHalfLen = paddleLen / 2;
var ballHalfSize = ballSize / 2;

// Ball control (Debug)
var hMove = keyboard_check(vk_numpad6) - keyboard_check(vk_numpad4);
var vMove = keyboard_check(vk_numpad2) - keyboard_check(vk_numpad8);
ballVX += hMove * 2;
ballVY += vMove * 2;

// Handle ball moving
ballX += ballVX;
ballY += ballVY;

// Handle ball bumping into paddle
// P1
if (ballVX < 0 &&
    ballX - ballHalfSize < p1X + paddleHalfWid &&
    ballX + ballHalfSize > p1X - paddleHalfWid &&
    ballY - ballHalfSize < p1Y + paddleHalfLen &&
    ballY + ballHalfSize > p1Y - paddleHalfLen)
{
    p1Torque = paddle_torque(p1X, p1Y, ballX, ballY, ballVX, ballVY);
    
    tableVX += ballVX * 0.05;
    ballVX *= -1.1;
    ballX = p1X + paddleHalfWid + ballHalfSize;
    
    // Apply paddle speed
    ballVY += p1Vel * 0.5;
    
    // Vibrate
    var ballVel = (ballVX + ballVY) * 0.34;
    if (abs(ballVel) > 4)
        p1Tremble = ballVel;
}

// P2
if (ballVX > 0 &&
    ballX - ballHalfSize < p2X + paddleHalfWid &&
    ballX + ballHalfSize > p2X - paddleHalfWid &&
    ballY - ballHalfSize < p2Y + paddleHalfLen &&
    ballY + ballHalfSize > p2Y - paddleHalfLen)
{
    p2Torque = paddle_torque(p2X, p2Y, ballX, ballY, ballVX, ballVY);
    
    tableVX += ballVX * 0.05;
    ballVX *= -1.1;
    ballX = p2X - paddleHalfWid - ballHalfSize;
    
    // Apply paddle speed
    ballVY += p2Vel * 0.5;
    
    // Vibrate
    var ballVel = (ballVX + ballVY) * 0.34;
    if (abs(ballVel) > 4)
        p2Tremble = ballVel;
}

// Handle ball bumping into wall
if (ballX + ballHalfSize > tableWid)
{
    tableVX += ballVX * 0.5;
    ballVX *= -0.5;
    
    ballX = tableWid - ballHalfSize;
}
if (ballX - ballHalfSize < 0)
{
    tableVX += ballVX * 0.5;
    ballVX *= -0.5;
    
    ballX = ballHalfSize;
}

if (ballY + ballHalfSize > tableHei)
{
    tableVY += ballVY * 0.5;
    ballVY = -ballVY;
    
    ballY = tableHei - ballHalfSize;
}
if (ballY - ballHalfSize < 0)
{
    tableVY += ballVY * 0.5;
    ballVY = -ballVY;
    
    ballY = ballHalfSize;
}

// Cap the ball speed
ballVX = min(max(ballVX, -paddleWid * 1.5), paddleWid * 1.5);