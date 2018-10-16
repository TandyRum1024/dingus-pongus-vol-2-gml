/*
    Let's draw paddle and balls and such!
*/

var paddleHalfWid = paddleWid / 2;
var paddleHalfLen = paddleLen / 2;

var p1WorldX = p1X - paddleHalfWid;
var p1WorldY = p1Y - paddleHalfLen;
var p1col = $f2f6ff;

var p2WorldX = p2X - paddleHalfWid;
var p2WorldY = p2Y - paddleHalfLen;
var p2col = $f2f6ff;


surface_set_target(tableSurf);
draw_clear_alpha(0, 0);

// Draw paddle 1
fast_rect(p1WorldX, p1WorldY, paddleWid, paddleLen, p1col, 1);

// Draw paddle 2
fast_rect(p2WorldX, p2WorldY, paddleWid, paddleLen, p2col, 1);

// Draw Ball
var ballWorldX = ballX - ballWid / 2;
var ballWorldY = ballY - ballHei / 2;
fast_rect(ballWorldX, ballWorldY, ballWid, ballHei, p2col, 1);

surface_reset_target();