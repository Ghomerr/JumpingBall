var keyRestart = keyboard_check_pressed(ord("R"));
var keyStop = keyboard_check_pressed(ord("S"));
var keySlow = keyboard_check_pressed(ord("F"));
var keyStartJump = keyboard_check_pressed(vk_space);
var keyEndJump = keyboard_check_released(vk_space);

if (keyRestart) {
	room_restart();
}
if (keyStop) {
	isStopped = !isStopped;
}
if (keySlow) {
	isSlow = !isSlow;
}

if (!isPreparingJump and !isJumping and keyStartJump) {
	lineRadius = TILESIZE;
	isPreparingJump = true;
	lineX = x;
	lineY = y - lineRadius;
	lineVsp = 1;
}
if (isPreparingJump and !isJumping and keyEndJump) { 
	isPreparingJump = false;
	isJumping = true;
	isGrounded = false;
	hsp = (lineX - x) / 10;
	vsp = (lineY - y) / 10;
	jumpCount += 1;
}

// Compute the line jump vector coordinates
if (isPreparingJump) {
	var key_right = keyboard_check(vk_right);
	var key_left = keyboard_check(vk_left);
	
	// Line vertical margin is between 1 - 4 tile size
	lineRadius += lineVsp;
	// Invert the growing direction when max/min is reached
	if (lineRadius >= TILESIZE * 4 || lineRadius <= TILESIZE) {
		lineVsp = lineVsp * -1;
		if (lineRadius >= TILESIZE * 4) {
			lineColor = c_red;
		} else {
			lineColor = c_lime;
		}
	} else {
		if (lineRadius > TILESIZE * 3) {
			lineColor = c_orange;
		} else if (lineRadius > TILESIZE * 2) {
			lineColor = c_yellow;
		} else {
			lineColor = c_lime;
		}
	}
	
	// Move the horizontal coordinates with left/right keys
	lineHsp = (key_right - key_left);
	
	// Stop the line horizontally if the angle exceed the max
	if (abs(lineAngle + lineHsp * DELTA_PI ) <= (HALF_PI - DELTA_PI)) {
		lineAngle += lineHsp * DELTA_PI;
	}
	
	// Update line X,Y
	lineX = x + lineRadius * sin (lineAngle);
	lineY = y - lineRadius * cos (lineAngle);
}


if (!isStopped and (isJumping || isGrounded)) {
	
	frameCounter += 1;
	if (!isSlow || frameCounter % 10 == 0) {
	
		frameCounter = 0;
	
		// Handle horizontal collisions
		var bbox_side_h = hsp > 0 ? bbox_right : bbox_left;
		var bbox_side_hsp = bbox_side_h + /*ceil(hsp);*/ (sign(hsp) > 0 ? ceil(hsp) : ceil(hsp) - 1);
		if (tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_top) != 0 or 
			tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_bottom) != 0) {
			
			// Pixel perfect position of the player 
			var tileOffset = bbox_side_h == bbox_right ? (TILESIZE - 1) : 0;
			x = x - (x mod TILESIZE) + tileOffset - (bbox_side_h - x);
			
			// Slow horizontal speed
			hsp = -1 * hsp * 0.8;
			lastHsp = hsp;
			
			// Display hit sprite
			sprite_index = spPlayerHit;
			alarm[0] = 10;
			
			// Stop the horizontal speed and states
			if (abs(hsp) <= GRAVITY/2) {
				hsp = 0;
				isGrounded = false;
				isJumping = false;
			}
			
		} else {
			// Player is at the ground
			if (isGrounded) {
				// Slow the horizontal speed
				hsp += (-1 * sign(hsp)) * GRAVITY;
				x += hsp;
				
				// Stop the player
				if (abs(hsp) <= GRAVITY/2) {
					hsp = 0;
					isGrounded = false;
					isJumping = false;
				}
				
			} else {
				// While jumping, update x
				x += hsp;
			}
			//image_angle -= hsp * 3;
		}
	
		if (isJumping and !isGrounded) {
			// Handle vertical collisions
			var bbox_side_v = vsp > 0 ? bbox_bottom : bbox_top;
			var bbox_side_vsp = bbox_side_v + /*ceil(vsp);*/ (sign(vsp) > 0 ? ceil(vsp) : ceil(vsp) - 1);
			if (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side_vsp) != 0 or 
				tilemap_get_at_pixel(tilemap, bbox_left, bbox_side_vsp) != 0) {
				
				// Pixel perfect player position
				var tileOffset = bbox_side_v == bbox_bottom ? (TILESIZE - 1) : 0;
				y = y - (y mod TILESIZE) + tileOffset - (bbox_side_v - y);

				// Slow the player on colliding
				vsp = -1 * vsp * 0.8;
				hsp *= 0.8;
				lastVsp = vsp;
				
				// Display hit sprite
				sprite_index = spPlayerHit;
				alarm[0] = 10;
		
				// Player is at the ground
				if (abs(vsp) <= GRAVITY/2) {
					vsp = 0;
					isGrounded = true;
				}
			} else {
				// Update y position while falling
				vsp += GRAVITY;
				y += vsp;
			}
		}
	}
}
