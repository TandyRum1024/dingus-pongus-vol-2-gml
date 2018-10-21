#define pong_game_logic

var tableHalfWid = tableWid / 2;
var tableHalfHei = tableHei / 2;

/*
debug
if (keyboard_check_pressed(vk_numpad1))
    pong_score(0);
if (keyboard_check_pressed(vk_numpad2))
    pong_score(1);
*/

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
    
    // P1 SCORE!!
    pong_score(0);
}
if (tableX + tableHalfWid > room_width)
{
    tableX = room_width - tableHalfWid;
    tableVX *= -0.5;
    
    // P2 SCORE!!
    pong_score(1);
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
tableVX *= 0.85;
tableVY *= 0.85;


// Handle Intensity
////////////////////
if (point_distance(ballVX, ballVY, 0, 0) > 15)
{
    superIntense = lerp(superIntense, 1, 0.2);
    
    repeat (irandom_range(2, 4))
    {
        particle_add(ePTYPE.BALL_TRAIL, 10, make_colour_hsv((gameCtr + 42) % 255, 250, 250), random_range(0.6, 1), ballX, ballY, -ballVX + random_range(-4, 4), -ballVY + random_range(-4, 4), random_range(-2, 2), random_range(-2, 2), point_direction(ballVX, ballVY, 0, 0));
        particle_add(ePTYPE.BALL_TRAIL, 20, make_colour_hsv(gameCtr % 255, 250, 250), random_range(0.6, 1), ballX, ballY, -ballVX + random_range(-10, 10), -ballVY + random_range(-10, 10), random_range(-1.5, 1.5), random_range(-1.5, 1.5), point_direction(ballVX, ballVY, 0, 0));
    }
    
}
else
    superIntense = lerp(superIntense, 0, 0.2);
    
targetIntensity = min(targetIntensity, 10);

if (boringCtr > 0)
    boringCtr--;
else
{
    targetIntensity = 0;
    
    if (intensity < 0.05)
        intensity = 0;
}

intensity = lerp(intensity, targetIntensity, 0.1);

if (gameIntermission == 0)
{

    var off = 10;
    
    if (abs(room_width / 2 - tableX) > off)
        uIntensity = (off - abs(room_width / 2 - tableX)) / (room_width - off);
    
    intenseFlash *= 0.95;
}


#define pong_title_logic
if (keyboard_check_pressed(vk_anykey))
{
    pong_set_state(ePONG.intermission);
    gameIntermission = 60;
    
    // Reset paddles to prevent swoocing even before you're playable
    p1Y = tableHei / 2;
    p2Y = tableHei / 2;
    p1Vel = 0;
    p2Vel = 0;
}

// DOG!!!!
dogX = room_width / 2 + sin(34 + 22 * sin(gameCtr * 0.032) + dcos(gameCtr * 0.2) * 42) - sin(gameCtr * 0.032 + dsin(gameCtr * 0.2) * 42) * 512;
dogY = room_height / 2 + cos(42 + 34 * cos(gameCtr * 0.034) + dsin(gameCtr * 0.2) * 42) - cos(gameCtr * 0.034 + dcos(gameCtr * 0.2) * 42) * 256;

/*
if (dogX < 0)
{
    dogX = 0;
    dogVX *= -1;
}
if (dogX > room_width)
{
    dogX = room_width;
    dogVX *= -1;
}
if (dogY < 0)
{
    dogY = 0;
    dogVY *= -1;
}
if (dogY > room_height)
{
    dogY = room_height;
    dogVY *= -1;
}
dogX += dogVX;
dogY += dogVY;
*/

#define pong_result_logic
if (keyboard_check_pressed(vk_anykey))
{
    pong_reset();
    pong_set_state(ePONG.title);
}

#define pong_intermission_logic

// debug
// if (keyboard_check_pressed(vk_anykey))
    // pong_set_state(ePONG.game);
if (intermState == 0)
    intenseFlash = 0;

// Windup
if (intermWindup <= INTERM_WINDUP_DURATION)
    intermWindup++;
else
{
    // Update anim
    if (gameIntermission > 0)
    {
        if (intermAnim < INTERM_ANIM_DURATION)
            intermAnim++;
        
        gameIntermission--;
        
        if (gameIntermission < INTERM_ANIM_DURATION * 2)
        {
            p1ScorePrev = p1Score;
            p2ScorePrev = p2Score;
        }
        
        // Lerp table position
        var iTime = power(smoothstep(intermAnim / INTERM_ANIM_DURATION), 3);
        tableX = lerp(intermTableX, room_width / 2, iTime);
        tableY = lerp(intermTableY, room_height / 2, iTime);
        tableVX = 0;
        tableVY = 0;
        
        // Lerp ball
        ballX = lerp(intermBallX, tableWid / 2, iTime);
        ballY = lerp(intermBallY, tableHei / 2, iTime);
        
        // Lerp cam
        /*
        var VIEW_W = view_wport[0];
        var VIEW_H = view_hport[0];
        camVX = 0;
        camVY = 0;
        camVZ = 0;
        camX = lerp(camX, VIEW_W / 2, iTime);
        camY = lerp(camY, VIEW_H / 2, iTime);
        camZ = lerp(camZ, 1, iTime);
        camRot = lerp(camRot, 0, iTime);
        camShake = lerp(camShake, 0, iTime);
        */
        
        // yay victory
        scoreIntense = lerp(0, 1, iTime);
        
        if (intermState == 0)
            intenseFlash = 0;
        else
            // Set flash anyway
            intenseFlash = lerp(1, 0, iTime);
    }
    else
    {
        if (intermAnim > 0)
            intermAnim--;
        else
        {
        // END INTERMISSION
        
        // Reset table position
        tableX = room_width / 2;
        tableY = room_height / 2;
        tableVX = 0;
        tableVY = 0;
        
        pong_set_state(ePONG.game);
        
        // Move ball
        var dir = random_range(0, 360);
        var spd = random_range(6, 10);
        
        ballVX = lengthdir_x(spd, dir);
        ballVY = lengthdir_y(spd, dir);
        
        
        if (abs(ballVX) < 2)
            ballVX = 1;
        if (abs(ballVX) < 1)
            ballVY = 1;
        
        // Reset cam
        /*
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
        */
        
        // End victory
        scoreIntense = 0;
        intenseFlash = 0;
        }
    }
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
        
        p1Squeeze = 0.35;
        
        // Particle
        particle_add(ePTYPE.PADDLE_SWOOCE, PT_PADDLE_SWOOCE_LIFE, make_colour_rgb(12, 109, 255), 1, p1X, p1Y - (hMove * paddleHalfLen), 0, p1Vel * -0.2, 1, 1, 0);
        particle_add(ePTYPE.PADDLE_SWOOCE, PT_PADDLE_SWOOCE_LIFE / 2, make_colour_rgb(155, 68, 255), 1, p1X, p1Y - (hMove * paddleHalfLen), 0, p1Vel * -1.2, 1, 1, 0);
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
        
        p2Squeeze = 0.35;
        particle_add(ePTYPE.PADDLE_SWOOCE, PT_PADDLE_SWOOCE_LIFE, make_colour_rgb(255, 53, 17), 1, p2X, p2Y - (hMove * paddleHalfLen), 0, p2Vel * -0.2, 1, 1, 0);
        particle_add(ePTYPE.PADDLE_SWOOCE, PT_PADDLE_SWOOCE_LIFE / 2, make_colour_rgb(255, 45, 76), 1, p2X, p2Y - (hMove * paddleHalfLen), 0, p2Vel * -1.2, 1, 1, 0);
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
/*
var hMove = keyboard_check(vk_numpad6) - keyboard_check(vk_numpad4);
var vMove = keyboard_check(vk_numpad2) - keyboard_check(vk_numpad8);
ballVX += hMove * 2;
ballVY += vMove * 2;
*/

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
    
    // tableVX += ballVX * 0.05;
    if (abs(ballVX) < 4)
        ballVX *= -1.42;
    else
        ballVX *= -1.2;
    ballX = p1X + paddleHalfWid + ballHalfSize;
    
    // Apply paddle speed
    ballVY += p1Vel * 0.15;
    
    // Vibrate
    var ballVel = abs(ballVX) + abs(ballVY) * 0.34;
    if (ballVel > 4)
        p1Tremble = ballVel;
        
    pong_camera_shake(ballVX * 0.2, ballVY * 0.2, random_range(-3, 3), 0, ballVX * 0.5);
        
    // Intensify
    targetIntensity += ballVel * 0.2;
    boringCtr = 80;
    
    if (ballVel > 10)
        intenseFlash += 0.2;
        
    scoreSide = 0;
        
    // Particle
    if (ballVel > 2)
    {
        for (var i=0; i<6; i++)
        {
            var dir = random_range(90, -90);
            var dx = lengthdir_x(20, dir);
            var dy = lengthdir_y(20, dir);
            particle_add(ePTYPE.PADDLE_HIT, PT_PADDLE_HIT_LIFE, c_creme, 0.6, ballX, ballY, dx, dy, 1, 1, dir);
        }
        
        var _ms = emit_msg(choose("WOO", "좋았어", "나이스", "포-잉", "끼얗호", "잘한다", "스무스", "뚝-딱", chr(1), chr(2)), c_creme, 30, (tableX - tableWid / 2) + ballX, (tableY - tableHei / 2) + ballY, random_range(2, 6), random_range(-4, 4));
            _ms.image_angle = random_range(-12, 12);
    }
}

// P2
if (ballVX > 0 &&
    ballX - ballHalfSize < p2X + paddleHalfWid &&
    ballX + ballHalfSize > p2X - paddleHalfWid &&
    ballY - ballHalfSize < p2Y + paddleHalfLen &&
    ballY + ballHalfSize > p2Y - paddleHalfLen)
{
    p2Torque = paddle_torque(p2X, p2Y, ballX, ballY, ballVX, ballVY);
    
    // tableVX += ballVX * 0.05;
    if (abs(ballVX) < 4)
        ballVX *= -1.42;
    else
        ballVX *= -1.2;
    ballX = p2X - paddleHalfWid - ballHalfSize;
    
    // Apply paddle speed
    ballVY += p2Vel * 0.15;
    
    // Vibrate
    var ballVel = abs(ballVX) + abs(ballVY) * 0.34;
    if (ballVel > 4)
        p2Tremble = ballVel;
        
    pong_camera_shake(ballVX * 0.2, ballVY * 0.2, random_range(-3, 3), ballVX, ballVX * 0.5);
    
    // Intensify
    targetIntensity += ballVel * 0.2;
    boringCtr = 80;
    
    if (ballVel > 10)
        intenseFlash += 0.2;
    
    scoreSide = 1;
        
    if (ballVel > 2)
    {
        for (var i=0; i<6; i++)
        {
            var dir = random_range(90, 270);
            var dx = lengthdir_x(20, dir);
            var dy = lengthdir_y(20, dir);
            particle_add(ePTYPE.PADDLE_HIT, PT_PADDLE_HIT_LIFE, c_creme, 0.6, ballX, ballY, dx, dy, 1, 1, dir);
        }
        
        var _ms = emit_msg(choose("WOO", "좋았어", "나이스", "포-잉", "끼얗호", "잘한다", "스무스", "뚝-딱", chr(1), chr(2)), c_creme, 30, (tableX - tableWid / 2) + ballX, (tableY - tableHei / 2) + ballY, random_range(-6, -2), random_range(-4, 4));
        _ms.image_angle = random_range(-12, 12);
    }
}

// Handle ball bumping into wall
if (ballX + ballHalfSize > tableWid)
{
    tableVX += ballVX * 0.4;
    ballVX *= -0.5;
    
    ballX = tableWid - ballHalfSize;
    
    // Intensify
    targetIntensity += 2;
    boringCtr = 200;
    
    pong_camera_shake(ballVX * 0.2, 0, random_range(-1, 1), 0, ballVX * 0.1);
}
if (ballX - ballHalfSize < 0)
{
    tableVX += ballVX * 0.4;
    ballVX *= -0.5;
    
    ballX = ballHalfSize;
    
    // Intensify
    targetIntensity += 2;
    boringCtr = 200;
    
    pong_camera_shake(ballVX * 0.2, 0, random_range(-1, 1), 0, ballVX * 0.1);
}

if (ballY + ballHalfSize > tableHei)
{
    tableVY += ballVY * 0.3;
    ballVY = -ballVY;
    
    if (abs(ballVX) < 4)
        ballVX *= 1.05;
    
    ballY = tableHei - ballHalfSize;
    
    pong_camera_shake(0, ballVY * 0.4, random_range(-2, 2), 0, ballVY * 0.5);
}
if (ballY - ballHalfSize < 0)
{
    tableVY += ballVY * 0.3;
    ballVY = -ballVY;
    
    if (abs(ballVX) < 4)
        ballVX *= 1.05;
    
    ballY = ballHalfSize;
    
    pong_camera_shake(0, ballVY * 0.4, random_range(-2, 2), 0, ballVY * 0.5);
}

// Cap the ball speed
ballVX = min(max(ballVX, -paddleWid * 2), paddleWid * 2);