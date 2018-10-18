#define pong_update_surface
/*
    Let's draw paddle and balls and such!
*/

var p1Wid = paddleWid * p1Anim[eANIM.scalex];
var p1Hei = paddleLen * p1Anim[eANIM.scaley];
var p2Wid = paddleWid * p2Anim[eANIM.scalex];
var p2Hei = paddleLen * p2Anim[eANIM.scaley];

var p1WorldX = p1X - p1Wid / 2;
var p1WorldY = p1Y - p1Hei / 2;
var p2WorldX = p2X - p2Wid / 2;
var p2WorldY = p2Y - p2Hei / 2;

surface_set_target(tableSurf);
draw_clear_alpha(0, 0);

// Draw paddle 1
fast_rect_rot_center(p1X + p1Anim[eANIM.offx] + random_range(-p1Tremble, p1Tremble), p1Y + p1Anim[eANIM.offy] + random_range(-p1Tremble, p1Tremble), p1Wid, p1Hei, p1Col, 1, p1Anim[eANIM.rot]);

// Draw paddle 2
fast_rect_rot_center(p2X + p2Anim[eANIM.offx] + random_range(-p2Tremble, p2Tremble), p2Y + p2Anim[eANIM.offy] + random_range(-p2Tremble, p2Tremble), p2Wid, p2Hei, p2Col, 1, p2Anim[eANIM.rot]);

// Draw Ball
var ballHalfSize = ballSize / 2;
var ballWorldX = ballX - ballHalfSize;
var ballWorldY = ballY - ballHalfSize;

fast_rect(ballWorldX, ballWorldY, ballSize, ballSize, c_creme, 1);

var velDir = point_direction(ballVX, ballVY, 0, 0);
var velLen = sqrt(ballVX * ballVX + ballVY * ballVY);

// calc hypotenuse length via angle
// https://yal.cc/gamemaker-circular-cooldown-rectangle/
var vecX = lengthdir_x(1, velDir);
var vecY = lengthdir_y(1, velDir);
var i = max(abs(vecX), abs(vecY));
vecX /= i;
vecY /= i;
var hypo = sqrt(vecX * vecX + vecY * vecY) * ballSize;

fast_rect_rot_origin(ballX, ballY, velLen, hypo, c_creme, 1, velDir, 0, hypo / 2); // Trail
fast_rect(ballWorldX - ballVX, ballWorldY - ballVY, ballSize, ballSize, c_creme, 1);

// Draw drag line
// if (drag)
//    draw_line(dx, dy, mouse_x - (tableX - tableWid / 2), mouse_y - (tableY - tableHei / 2));

surface_reset_target();

#define pong_update_anim

// Update paddle torque
// AKA bouncy torque
p1Torque -= p1Anim[eANIM.rot] * 0.5;
p2Torque -= p2Anim[eANIM.rot] * 0.5;

p1Anim[eANIM.rot] += p1Torque;
p2Anim[eANIM.rot] += p2Torque;

p1Torque *= 0.65;
p2Torque *= 0.65;


// Update squeeze
p1Anim[eANIM.scalex] = lerp(p1Anim[eANIM.scalex], 1, 0.45);
p1Anim[eANIM.scaley] = lerp(p1Anim[eANIM.scaley], 1, 0.45);
p2Anim[eANIM.scalex] = lerp(p2Anim[eANIM.scalex], 1, 0.45);
p2Anim[eANIM.scaley] = lerp(p2Anim[eANIM.scaley], 1, 0.45);

p1Tremble *= 0.75;
p2Tremble *= 0.75;

#define pong_update_cam

camVelX = 0;
camVelY = 0;