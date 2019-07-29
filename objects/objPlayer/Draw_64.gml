// Score board
draw_set_colour(c_white);
draw_text(TILESIZE / 2, TILESIZE / 2, "Jumps : " + string_format(jumpCount, 3, 0));
// TODO : time

// Debug
/*
if (isPassingThroughPlatform) {
	draw_set_colour(c_aqua);
} else {
	draw_set_colour(c_white);
}
draw_text(TILESIZE * 8, TILESIZE / 2, "vsp=" + string_format(vsp, 2, 2));
draw_text(TILESIZE * 16, TILESIZE / 2, "col=" + string_format(platformCollide, 2, 0));
*/


// Draw keys instructions
draw_set_colour(c_yellow);
draw_text_transformed(TILESIZE, TILESIZE * 12, "KEYS : ", 0.5, 0.5, 0);
draw_text_transformed(TILESIZE, TILESIZE * 13, "- space : jump power", 0.5, 0.5, 0);
draw_text_transformed(TILESIZE, TILESIZE * 14, "- left/right : jump angle", 0.5, 0.5, 0);
draw_text_transformed(TILESIZE, TILESIZE * 15, "- R : reset", 0.5, 0.5, 0);
draw_text_transformed(TILESIZE, TILESIZE * 16, "- S : pause", 0.5, 0.5, 0);
draw_text_transformed(TILESIZE, TILESIZE * 17, "- F : f*cking slow x10", 0.5, 0.5, 0);

// Draw the jumping line
if (isPreparingJump) {
	draw_line_width_color(x, y, lineX, lineY, 1, lineColor, lineColor);
}

// Show pause
if (isStopped) {
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_text_transformed(window_get_width()/2, window_get_height()/2, "PAUSE", 5, 5, 0);
	draw_set_halign(fa_left);
}
