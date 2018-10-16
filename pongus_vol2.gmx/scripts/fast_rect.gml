#define fast_rect
///fast_rect(x, y, wid, hei, colour, alpha)
/*
    Spritebatch toture
*/

draw_sprite_stretched_ext(sprWhite, 0, argument0, argument1, argument2, argument3, argument4, argument5);

#define fast_rect_pos
///fast_rect_pos(x1, y1, x2, y2, colour, alpha)
/*
    Spritebatch toture
*/

var _w = abs(argument2 - argument0);
var _h = abs(argument3 - argument1);

draw_sprite_stretched_ext(sprWhite, 0, argument0, argument1, _w, _h, argument4, argument5);

#define fast_rect_rot
///fast_rect_rot(x, y, wid, hei, colour, alpha, rot)
/*
    Same as fast_rect but rotated
*/

draw_sprite_general(sprWhite, 0, 0, 0, 1, 1, argument0, argument1, argument2, argument3, argument6, argument4, argument4, argument4, argument4, argument5);

#define fast_rect_rot_pos
///fast_rect_rot(x1, y1, x2, y2, colour, alpha, rot)
/*
    Same as fast_rect but rotated
*/

var _w = abs(argument2 - argument0);
var _h = abs(argument3 - argument1);

draw_sprite_general(sprWhite, 0, 0, 0, 1, 1, argument0, argument1, _w, _h, argument6, argument4, argument4, argument4, argument4, argument5);