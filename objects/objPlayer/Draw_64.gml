draw_set_colour(c_white);
draw_text(TILESIZE, TILESIZE, "Jumps : " + string_format(jumpCount, 3, 0));

/*
if (abs(hsp) > HALF_GRAVITY) {
	draw_set_colour(c_white);
} else {
	draw_set_colour(c_red);
}
draw_text(TILESIZE * 10, TILESIZE, "hsp=" + string_format(hsp, 2, 2));

if (abs(vsp) > HALF_GRAVITY) {
	draw_set_colour(c_white);
} else {
	draw_set_colour(c_red);
}
draw_text(TILESIZE * 16, TILESIZE, "vsp=" + string_format(vsp, 2, 2));
*/

// 3 3 -2 -2
//draw_text(TILESIZE, TILESIZE * 8 , string_format(ceil(2.6), 2, 0) + "," + string_format(ceil(2.2), 2, 0) + "," + string_format(ceil(-2.6), 2, 0) + "," + string_format(ceil(-2.2), 2, 0));
// 2 2 -3 -3
//draw_text(TILESIZE, TILESIZE * 16 , string_format(floor(2.6), 2, 0) + "," + string_format(floor(2.2), 2, 0) + "," + string_format(floor(-2.6), 2, 0) + "," + string_format(floor(-2.2), 2, 0));

/*
if (!isGrounded) draw_set_colour(c_white); else draw_set_colour(c_yellow);
draw_text(TILESIZE, TILESIZE, "hsp=" + string_format(hsp, 4, 2));

if (!isJumping) draw_set_colour(c_white); else draw_set_colour(c_yellow);
draw_text(TILESIZE, TILESIZE * 2, "vsp=" + string_format(vsp, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE * 8 , TILESIZE, "lastHsp=" + string_format(lastHsp, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE * 8 , TILESIZE * 2, "lastVsp=" + string_format(lastVsp, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE * 20, TILESIZE, "rad=" + string_format(lineRadius, 4, 2));
*/
/*
draw_set_colour(c_white);
draw_text(TILESIZE * 8 , TILESIZE, "x=" + string_format(x, 4, 0));

draw_set_colour(c_white);
draw_text(TILESIZE * 8 , TILESIZE * 2, "y=" + string_format(y, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE * 14, TILESIZE, "top=" + string_format(bbox_top, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE  * 14, TILESIZE * 2, "btm=" + string_format(bbox_bottom, 4, 2));

draw_set_colour(c_white);
draw_text(TILESIZE * 22 , TILESIZE, "lef=" + string_format(bbox_left, 4, 0));

draw_set_colour(c_white);
draw_text(TILESIZE * 22 , TILESIZE * 2, "rig=" + string_format(bbox_right, 4, 0));
*/

// Draw the jumping line
if (isPreparingJump) {
	draw_line_width_color(x, y, lineX, lineY, 1, lineColor, lineColor);
}

/*
draw_line_color(bbox_left,bbox_top, bbox_right, bbox_top, c_red, c_red);
draw_line_color(bbox_left,bbox_bottom, bbox_right, bbox_bottom, c_yellow, c_yellow);
draw_line_color(bbox_left,bbox_top, bbox_left, bbox_bottom, c_aqua, c_aqua);
draw_line_color(bbox_right,bbox_top, bbox_right, bbox_bottom, c_lime, c_lime);
*/