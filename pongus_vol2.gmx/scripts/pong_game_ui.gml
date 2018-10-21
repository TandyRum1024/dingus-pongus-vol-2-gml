#define pong_game_ui
/*
    Draw in-game UI
*/
var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;
var SCORE_MARGIN = CENTER_X / 2;
var SCORE_Y = CENTER_Y + CENTER_Y / 1.5;


if (max(p1Score, p2Score) >= 3)
{
    draw_set_halign(1); draw_set_valign(1);
    // 1p
    var p1Col = c_creme;
    if (p1Score > p2Score) p1Col = merge_colour($00DDFF, $FFDD00, (gameCtr % 16) < 8);
    draw_text_shadow(CENTER_X - SCORE_MARGIN, SCORE_Y, string(p1Score), dsin(gameCtr * 5) * 8, 4, 4, p1Col, 1, 4, 4, c_thicc);
    
    // 2p
    var p2Col = c_creme;
    if (p2Score > p1Score) p2Col = merge_colour($00DDFF, $FFDD00, (gameCtr % 16) < 8);
    draw_text_shadow(CENTER_X + SCORE_MARGIN, SCORE_Y, string(p2Score), dsin(gameCtr * 5) * 8, 4, 4, p2Col, 1, 4, 4, c_thicc);
    draw_set_halign(0); draw_set_valign(0);
}

#define pong_title_ui
/*
    Draw title UI
*/
// DOG!!!
draw_sprite_ext(sprVictm, 0, dogX, dogY, random_range(0.65, 0.75), random_range(0.65, 0.75), gameCtr * 20.0, make_colour_hsv(gameCtr * 5, 88, 255), 1.0);

var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;

// draw_set_halign(1); draw_set_valign(1);
// draw_text_transformed_colour(CENTER_X, CENTER_Y - 100, "DINGUS#P*O*N*G*U*S", 2, 2, dsin(gameCtr * 21) * 4, $00DDFF, $00DDFF, $00DDFF, $00DDFF, 1);
// draw_text_transformed_colour(CENTER_X + 88, CENTER_Y - 70, "VOL. 2", 2, 2, 24, $4400FF, $4400FF, $4400FF, $4400FF, 1);

global.hangulAlignH = 1; global.hangulAlignV = 1;
// hj_draw(CENTER_X, CENTER_Y - 100, "FKEN\nD * O * G", $00DDFF, 1, dsin(gameCtr * 12) * 12);
// hj_draw(CENTER_X + 88, CENTER_Y - 70, "VOL. 2", $4400FF, 1, 24);

global.hangulFntSize = 48;
global.hangulFont = sprHangul48;
global.hangulAsciiFont = sprAscii48;
global.hangulAlignH = 1; global.hangulAlignV = 1;

hj_draw(CENTER_X, CENTER_Y + 200, "> 아무 키나 눌러요", make_colour_hsv(gameCtr * 10, 255, 255), round(dsin(gameCtr * 8) * 0.5 + 0.5), dsin(gameCtr) * 4);

global.hangulAlignH = 0; global.hangulAlignV = 0;
global.hangulFntSize = 24;
global.hangulFont = sprHangul24;
global.hangulAsciiFont = sprAscii24;
global.hangulAlignH = 1; global.hangulAlignV = 1;

// Title
draw_sprite_ext(sprLogo, 0, CENTER_X, CENTER_Y - 150, 1 + dsin(gameCtr) * 0.05, 1 + dcos(gameCtr) * 0.05, dsin(gameCtr + dcos(gameCtr * 0.5) * 8), c_white, 1.0);

// draw_text_transformed_colour(CENTER_X, CENTER_Y + 200, ">> [PRESS ANY KEY YE DINK] <<", 2, 2, dsin(gameCtr * 21) * 4, $00DDFF, $00DDFF, $00DDFF, $00DDFF, 1);
// draw_set_halign(0); draw_set_valign(0);

#define pong_intermission_ui
/*
    Draw title UI
*/
var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;
var GAME_W = window_get_width();
var GAME_H = window_get_height();
var iTime = power(smoothstep(intermAnim / INTERM_ANIM_DURATION), 3);

var stripOff = lerp(GAME_W, 0, iTime);
var stripy = CENTER_Y - 128;

var SCORE_MARGIN = 450;
var SCORE_Y = CENTER_Y + 220;


// Backdrop / title strip / message
fast_rect(stripOff, stripy - 80 + 20, GAME_W, 160, $2D44D8, 1);
fast_rect(stripOff, stripy - 80, GAME_W, 160, $3E4144, 1);

draw_set_halign(1); draw_set_valign(1);

draw_set_font(fntHangul64);
switch (intermState)
{
    case 0:
        draw_text_shadow(stripOff + CENTER_X, stripy, "준비하세요!!", 0, 1, 1, $00DDFF, 1, 8, 8, c_thicc);
        draw_text_shadow(CENTER_X, CENTER_Y + 100, string(gameIntermission), 0, 0.5, 0.5, c_creme, 1, 0, 8, c_thicc);
        
        global.hangulFntSize = 48;
        global.hangulFont = sprHangul48;
        global.hangulAsciiFont = sprAscii48;
        global.hangulAlignH = 1; global.hangulAlignV = 1;
        hj_draw(CENTER_X, CENTER_Y + 200, "W / S & 방향키로 조작, 연타로 대쉬", make_colour_hsv(gameCtr * 10, 255, 255), 1, dsin(gameCtr) * 4);
        global.hangulAlignH = 0; global.hangulAlignV = 0;
        global.hangulFntSize = 24;
        global.hangulFont = sprHangul24;
        global.hangulAsciiFont = sprAscii24;
        break;
    
    case 1:
        if (scoreSide == 0)
            intermMsg = "플레이어 1 득점!";
        else if (scoreSide == 1)
            intermMsg = "플레이어 2 득점!";
            
        // backdrop
        fast_rect(0, 0, GAME_W, GAME_H, c_thicc, 0.7 * iTime);
    
        draw_text_shadow(stripOff + CENTER_X, stripy, intermMsg, 0, 1, 1, c_creme, 1, 8, 8, c_thicc);
        draw_text_shadow(stripOff + CENTER_X - string_width(intermMsg) / 2 - 62, stripy - 62, "\#"+string(max(p1Score, p2Score)), sin(gameCtr * 0.5) * 8, 1.5, 1.5, $00DDFF, 1, 8, 8, c_thicc);
        
        var p1ScoreCol = c_creme;
        if (scoreSide == 0)
            p1ScoreCol = $00DDFF;
        var p2ScoreCol = c_creme;
        if (scoreSide == 1)
            p2ScoreCol = $00DDFF;
        
        draw_text_shadow(CENTER_X - SCORE_MARGIN, SCORE_Y, string(p1ScorePrev), dsin(gameCtr * 5) * 8, 2, 2, p1ScoreCol, iTime, 0, 8, c_thicc);
        draw_text_shadow(CENTER_X + SCORE_MARGIN, SCORE_Y, string(p2ScorePrev), dsin(gameCtr * 5) * 8, 2, 2, p2ScoreCol, iTime, 0, 8, c_thicc);
        
        global.hangulFntSize = 48;
        global.hangulFont = sprHangul48;
        global.hangulAsciiFont = sprAscii48;
        global.hangulAlignH = 1; global.hangulAlignV = 1;
        
        hj_draw(CENTER_X, CENTER_Y + 170 + 8, quips[quipIdx], c_thicc, iTime, sin(gameCtr * 0.5) * 8.0 * (1 - iTime));
        hj_draw(CENTER_X, CENTER_Y + 170, quips[quipIdx], make_colour_hsv(gameCtr * 10, 255, 255), iTime, sin(gameCtr * 0.5) * 8.0 * (1 - iTime));
        
        global.hangulAlignH = 0; global.hangulAlignV = 0;
        global.hangulFntSize = 24;
        global.hangulFont = sprHangul24;
        global.hangulAsciiFont = sprAscii24;
        break;
}
draw_set_font(fntGame24);

draw_set_halign(0); draw_set_valign(0);

#define pong_result_ui
/*
    Draw result UI
*/
var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;
var GAME_W = window_get_width();
var GAME_H = window_get_height();

var stripy = CENTER_Y - 128;


// Backdrop / title strip / message
fast_rect(0, stripy - 80 + 20, GAME_W, 160, $2D44D8, 1);
fast_rect(0, stripy - 80, GAME_W, 160, $3E4144, 1);

draw_set_halign(1); draw_set_valign(1);

draw_set_font(fntHangul64);

if (winner == 0)
    draw_text_shadow(CENTER_X, stripy, "플레이어 1 승리!", 0, 1, 1, make_colour_rgb(40, 26, 224), 1, 8, 8, c_thicc);
else
    draw_text_shadow(CENTER_X, stripy, "플레이어 2 승리!", 0, 1, 1, make_colour_rgb(244, 26, 42), 1, 8, 8, c_thicc);

var p1ScoreCol = c_creme;
if (winner == 0)
    p1ScoreCol = make_colour_hsv(gameCtr * 10, 255, 255);
var p2ScoreCol = c_creme;
if (winner == 1)
    p2ScoreCol = make_colour_hsv(gameCtr * 10, 255, 255);

draw_text_shadow(CENTER_X - SCORE_MARGIN, SCORE_Y, string(p1ScorePrev), dsin(gameCtr * 5) * 8, 2, 2, p1ScoreCol, 1, 0, 8, c_thicc);
draw_text_shadow(CENTER_X + SCORE_MARGIN, SCORE_Y, string(p2ScorePrev), dsin(gameCtr * 5) * 8, 2, 2, p2ScoreCol, 1, 0, 8, c_thicc);

global.hangulFntSize = 48;
global.hangulFont = sprHangul48;
global.hangulAlignH = 1; global.hangulAlignV = 1;
hj_draw(CENTER_X, CENTER_Y + 250 + 8, "아무키나 눌러서 돌아가세요", c_thicc, 1, 0);
hj_draw(CENTER_X, CENTER_Y + 250, "아무키나 눌러서 돌아가세요", c_creme, 1, 0);
global.hangulAlignH = 0; global.hangulAlignV = 0;
global.hangulFntSize = 24;
global.hangulFont = sprHangul24;

draw_set_font(fntGame24);

draw_set_halign(0); draw_set_valign(0);