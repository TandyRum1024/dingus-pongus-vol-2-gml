///emit_msg(str, col, life, x, y, vx, vy)

var msg = instance_create(argument3, argument4, oMSG);
msg.vx = argument5;
msg.vy = argument6;
msg.msg = argument0;
msg.image_blend = argument1;
msg.life = argument2;

return msg;
