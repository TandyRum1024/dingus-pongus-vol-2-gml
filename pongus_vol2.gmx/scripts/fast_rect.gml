#define fast_rect
///fast_rect(x, y, wid, hei, colour, alpha)
/*
    Spritebatch toture
*/

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, 0, argument4, argument4, argument4, argument4, argument5);
//draw_sprite_stretched_ext(sprWhite, 0, argument0, argument1, argument2, argument3, argument4, argument5);

#define fast_rect_pos
///fast_rect_pos(x1, y1, x2, y2, colour, alpha)
/*
    Spritebatch toture
*/

var _w = abs(argument2 - argument0);
var _h = abs(argument3 - argument1);

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0, argument1, _w, _h, 0, argument4, argument4, argument4, argument4, argument5);

#define fast_rect_rot
///fast_rect_rot(x, y, wid, hei, colour, alpha, rot)
/*
    Same as fast_rect but rotated
*/

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, argument6, argument4, argument4, argument4, argument4, argument5);

#define fast_rect_rot_center
///fast_rect_rot_center(x, y, wid, hei, colour, alpha, rot)
/*
    Same as fast_rect but rotated
*/

var halfWid = (argument2 / 2);
var halfHei = (argument3 / 2);

var ox = lengthdir_x(halfWid, argument6) - lengthdir_y(halfHei, argument6);
var oy = lengthdir_y(halfWid, argument6) + lengthdir_x(halfHei, argument6);

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0 - ox, argument1 - oy, argument2, argument3, argument6, argument4, argument4, argument4, argument4, argument5);

#define fast_rect_rot_origin
///fast_rect_rot_origin(x, y, wid, hei, colour, alpha, rot, ox, oy)
/*
    Same as fast_rect but rotated
*/

var originX = argument7;
var originY = argument8;

var ox = lengthdir_x(originX, argument6) - lengthdir_y(originY, argument6);
var oy = lengthdir_y(originX, argument6) + lengthdir_x(originY, argument6);

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0 - ox, argument1 - oy, argument2, argument3, argument6, argument4, argument4, argument4, argument4, argument5);

#define fast_rect_rot_pos
///fast_rect_rot(x1, y1, x2, y2, colour, alpha, rot)
/*
    Same as fast_rect but rotated
*/

var _w = abs(argument2 - argument0);
var _h = abs(argument3 - argument1);

draw_sprite_general(sprWhite, 0, 1, 1, 1, 1, argument0, argument1, _w, _h, argument6, argument4, argument4, argument4, argument4, argument5);
