#define pong_game_ui
/*
    Draw in-game UI
*/
var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;
var SCORE_MARGIN = CENTER_X / 2;
var SCORE_Y = CENTER_Y + CENTER_Y / 1.5;


draw_set_halign(1); draw_set_valign(1);
// 1p
draw_text_transformed_colour(CENTER_X - SCORE_MARGIN + 4, SCORE_Y + 4, "0", 8, 8, dsin(gameCtr * 20) * 8, $151515, $151515, $151515, $151515, 1);
draw_text_transformed_colour(CENTER_X - SCORE_MARGIN, SCORE_Y, "0", 8, 8, dsin(gameCtr * 20) * 8, $7DF442, $7DF442, $7DF442, $7DF442, 1);

// 2p
draw_text_transformed_colour(CENTER_X + SCORE_MARGIN + 4, SCORE_Y + 4, "0", 8, 8, dsin(gameCtr * 20) * 8, $151515, $151515, $151515, $151515, 1);
draw_text_transformed_colour(CENTER_X + SCORE_MARGIN, SCORE_Y, "0", 8, 8, dsin(gameCtr * 20) * 8, $913DFF, $913DFF, $913DFF, $913DFF, 1);
draw_set_halign(0); draw_set_valign(0);

#define pong_title_ui
/*
    Draw title UI
*/
var CENTER_X = window_get_width() / 2;
var CENTER_Y = window_get_height() / 2;

draw_set_halign(1); draw_set_valign(1);
draw_text_transformed_colour(CENTER_X, CENTER_Y - 100, "DINGUS#P*O*N*G*U*S", 2, 2, dsin(gameCtr * 21) * 4, $00DDFF, $00DDFF, $00DDFF, $00DDFF, 1);
draw_text_transformed_colour(CENTER_X + 88, CENTER_Y - 70, "VOL. 2", 2, 2, 24, $4400FF, $4400FF, $4400FF, $4400FF, 1);

draw_text_transformed_colour(CENTER_X, CENTER_Y + 200, ">> [PRESS ANY KEY YE DINK] <<", 2, 2, dsin(gameCtr * 21) * 4, $00DDFF, $00DDFF, $00DDFF, $00DDFF, 1);
draw_set_halign(0); draw_set_valign(0);