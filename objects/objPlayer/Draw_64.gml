draw_set_colour(c_white);
draw_text(TILESIZE, TILESIZE, "Jumps : " + string_format(jumpCount, 4, 0));

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
