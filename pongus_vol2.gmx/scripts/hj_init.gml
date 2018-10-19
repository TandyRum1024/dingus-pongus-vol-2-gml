#define hj_init
///hj_init()

// Set hangul font attributes
global.hangulFntSize = 24;
global.hangulJungOffset = 28 * 2;
global.hangulJongOffset = 28 * 3;

global.hangulAlignH = 0;
global.hangulAlignV = 0;

// Set non-hangul font
global.hangulAsciiFont = sprAscii24;

// BUILD HANGUL JUNGSEONG BEOL LUT
var BEOL_OFFSET = 28;
for (var i=0; i<=7; i++)
    global.hangul_beol_lut[i] = 0;
global.hangul_beol_lut[20] = 0;

for (var i=8; i<20; i++)
    global.hangul_beol_lut[i] = BEOL_OFFSET;

#define hj_draw
///hj_draw(x, y, string, colour, alpha, angle)

var jungOffset = global.hangulJungOffset;
var jongOffset = global.hangulJongOffset;
var beol_lut = global.hangul_beol_lut;
var asciiFont = global.hangulAsciiFont;
var halign = global.hangulAlignH;
var valign = global.hangulAlignV;

var strX = argument0;
var strY = argument1;
var str = argument2;
var col = argument3;
var alpha = argument4;
var rot = argument5;
var strlen = string_length(str);

var _cho, _jung, _jong;
var _utf;
var beolOffset;

var lineWidth = hj_get_width_line(str);
var lineHeight = hj_get_height(str);
var offX, offY, tX, tY;

// Calc font offset via align
if (halign == 1)
        tX = -(lineWidth >> 1);
else if (halign == 2)
        tX = -lineWidth;

if (valign == 1)
        tY = -(lineHeight >> 1);
else if (valign == 2)
        tY = -lineHeight;

// Transform
d3d_transform_stack_push();
d3d_transform_set_translation(tX, tY, 0);
d3d_transform_add_rotation_z(rot);
d3d_transform_add_translation(strX, strY, 0);

offX = 0;
offY = 0;

// Draw hangul
for (var i=1; i<=strlen; i++)
{
    _utf = string_ord_at(str, i);
    
    if (_utf == 0 || _utf < $AC00 || _utf > $D7A3)
    {
        if (_utf == ord('\') && string_char_at(str, i + 1) == "n")
        {
            offX = 0;
            offY += 25;
            
            // Recalc font width and update align
            lineWidth = hj_get_width_line(string_delete(str, 1, i + 1));
            
            if (halign == 1)
                    tX = -(lineWidth >> 1);
            else if (halign == 2)
                    tX = -lineWidth;
            
            d3d_transform_set_translation(tX, tY, 0);
            d3d_transform_add_rotation_z(rot);
            d3d_transform_add_translation(strX, strY, 0);
            
            i++;
            continue;
        }
        else
        {
            draw_sprite_ext(sprAscii24, _utf, offX, offY, 1, 1, 0, col, alpha);
        }
    }
    else
    {
        _utf -= $AC00;
        
        _cho    = _utf div (588);
        _jung   = (_utf % (588)) div 28;
        _jong   = _utf % 28;
        
        // Determine beol from jungseong
        beolOffset = beol_lut[_jung];
        
        // Choseong
        draw_sprite_ext(sprHangul24, beolOffset + _cho, offX, offY, 1, 1, 0, col, alpha);
        
        // Jungseong
        draw_sprite_ext(sprHangul24, jungOffset + _jung, offX, offY, 1, 1, 0, col, alpha);
        
        // Jongseong
        draw_sprite_ext(sprHangul24, jongOffset + beolOffset + _jong, offX, offY, 1, 1, 0, col, alpha);
    }
    
    // Advance
    offX += 25;
}

d3d_transform_stack_pop();

#define hj_get_width_line
///hj_get_width_line(str)
/*
  Returns str's width until \n or eof
*/

var len = 0;
var char = string_char_at(argument0, 1), idx = 1;
var strlen = string_length(argument0);

while (idx <= strlen)
{
    if (char == "\" && string_char_at(argument0, idx + 1) == "n") // NEWLINE
        return len;
    
    len += global.hangulFntSize;
    char = string_char_at(argument0, ++idx);
}

return len;

#define hj_get_height
///hj_get_height(str)
/*
  Returns str's height
*/

return global.hangulFntSize + global.hangulFntSize * string_count("\n", argument0);
