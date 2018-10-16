#define pong_game_logic

var tableHalfWid = tableWid / 2;
var tableHalfHei = tableHei / 2;

// Handle paddle
//////////////////////
pong_handle_physics();


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


// Handle balls
//////////////////////
var ballHalfWid = ballWid / 2;
var ballHalfHei = ballHei / 2;

// Ball control (Debug)
var hMove = keyboard_check(vk_numpad6) - keyboard_check(vk_numpad4);
var vMove = keyboard_check(vk_numpad2) - keyboard_check(vk_numpad8);

ballVX += hMove * 2;
ballVY += vMove * 2;

// Handle ball moving
ballX += ballVX;
ballY += ballVY;

// Handle ball bumping into wall
if (ballX + ballHalfWid > tableWid)
{
    tableVX += ballVX * 0.5;
    ballVX *= -0.5;
    
    ballX = tableWid - ballHalfWid;
}
if (ballX - ballHalfWid < 0)
{
    tableVX += ballVX * 0.5;
    ballVX *= -0.5;
    
    ballX = ballHalfWid;
}

if (ballY + ballHalfHei > tableHei)
{
    tableVY += ballVY * 0.5;
    ballVY *= -0.5;
    
    ballY = tableHei - ballHalfWid;
}
if (ballY - ballHalfHei < 0)
{
    tableVY += ballVY * 0.5;
    ballVY *= -0.5;
    
    ballY = ballHalfHei;
}

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

// if (hMove != 0)
//     if (p1Vel * hMove < 10)
//         p1Vel += hMove * 4;
//     else
//         p1Vel = hMove * 10;
// else
//     p1Vel *= 0.7;
if (hMove != 0)
    p1Vel = hMove * 10;
else
    p1Vel *= 0.7;

// Check collision
if (p1Y - paddleHalfLen + p1Vel < 0) // Upperside
{
    p1Y = paddleHalfLen;
    p1Vel *= -0.85;
    
    // Ouch, Table is shifting!
    tableVY -= 2;
}
if (p1Y + paddleHalfLen + p1Vel > tableHei) // Bottom side
{
    p1Y = tableHei - paddleHalfLen;
    p1Vel *= -0.85;
    
    // Ouch, Table is shifting!
    tableVY += 2;
}

// integrate
p1Y += p1Vel;

// P2 - Paddle movement
////////////////////////
hMove = keyboard_check(vk_down) - keyboard_check(vk_up);

// if (hMove != 0)
//     if (p2Vel * hMove < 10)
//         p2Vel += hMove * 4;
//     else
//         p2Vel = hMove * 10;
// else
//     p2Vel *= 0.7;
if (hMove != 0)
    p2Vel = hMove * 10;
else
    p2Vel *= 0.7;

// Check collision
if (p2Y - paddleHalfLen + p2Vel < 0) // Upperside
{
    p2Y = paddleHalfLen;
    p2Vel *= -0.85;
    
    // Ouch, Table is shifting!
    tableVY -= 2;
}
if (p2Y + paddleHalfLen + p2Vel > tableHei) // Bottom side
{
    p2Y = tableHei - paddleHalfLen;
    p2Vel *= -0.85;
    
    // Ouch, Table is shifting!
    tableVY += 2;
}

// integrate
p2Y += p2Vel;