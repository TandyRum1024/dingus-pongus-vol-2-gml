///paddle_torque(paddleX, paddleY, hitX, hitY, forceX, forceY)
var deltax = argument4;
var deltay = argument5;
var localPosX = argument2 - argument0;
var localPosY = argument3 - argument1;

var torque = localPosX * deltay - localPosY * deltax;

return torque * -0.015;
