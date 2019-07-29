// Check inputs
var keyRestart = keyboard_check_pressed(ord("R"));
var keyStop = keyboard_check_pressed(ord("S"));
var keySlow = keyboard_check_pressed(ord("F"));
var keyStartJump = keyboard_check(vk_space);
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

// Start prepareing jump
if (!isPreparingJump and !isJumping and keyStartJump) {
	lineRadius = TILESIZE;
	isPreparingJump = true;
	lineX = x;
	lineY = y - lineRadius;
	lineVsp = 1;
}
// End preparing jump
if (isPreparingJump and !isJumping and keyEndJump) { 
	isPreparingJump = false;
	isJumping = true;
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
	if (abs(lineAngle + lineHsp * DELTA_PI) <= MAX_ANGLE) {
		lineAngle += lineHsp * DELTA_PI;
	}
	
	// Update line X,Y
	lineX = x + lineRadius * sin (lineAngle);
	lineY = y - lineRadius * cos (lineAngle);
}

// While the game is running and player is jumping, update the x,y position
if (!isStopped and isJumping) {
	isColliding = false;
	
	// Framecounter used to slow per 10 the game speed
	if (isSlow) {
		frameCounter += 1;
	}
	if (!isSlow || frameCounter % 20 == 0) {
		if (isSlow) {
			frameCounter = 0;
		}
	
		/***********************************************************/
		/***************** HORIZONTAL COLLISIONS *******************/
		/***********************************************************/
	
		// Check horizontal collision side
		var bbox_side_h = hsp > 0 ? bbox_right : bbox_left;
		var bbox_side_hsp = bbox_side_h + /*ceil(hsp);*/ (sign(hsp) > 0 ? ceil(hsp) : floor(hsp));
		
		if (tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_top) != 0 or 
			tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_bottom) != 0) {
			// Player collides horizontally (=true)
			playerCollides(true, bbox_side_h);
		}
		
		/***********************************************************/
		/****************** VERTICAL COLLISIONS ********************/
		/***********************************************************/

		// Check vertical collision side
		var isGoingDown = vsp > 0;
		var bbox_side_v = isGoingDown ? bbox_bottom : bbox_top;
		var vspRound = isGoingDown ? ceil(vsp) : floor(vsp);
		var bbox_side_vsp = bbox_side_v + vspRound;
		var bbox_bottom_vsp = bbox_bottom + vspRound;
			
		if (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side_vsp) != 0 or 
			tilemap_get_at_pixel(tilemap, bbox_left, bbox_side_vsp) != 0) {
			// Player collides vertically (=false)
			playerCollides(false, bbox_side_v);
			
		} else if (tilemap_get_at_pixel(pfTilemap, bbox_right, bbox_bottom_vsp) != 0 or 
			tilemap_get_at_pixel(pfTilemap, bbox_left, bbox_bottom_vsp) != 0) {

			// If the player doesn't alreay collide the platform
			if (!isPassingThroughPlatform) {
				// If player is falling
				if (isGoingDown) {
					// Player collides vertically (=false)
					playerCollides(false, bbox_side_v);
				
				} else {
					// Player's colliding from beneath
					isPassingThroughPlatform = true;
				}
			}
			
			// In other cases, the player is passing through the platform
			// We wait untill the player is comlpetely above it to handle the collision
			
		} else if (isPassingThroughPlatform) {
			// No more collision with platform
			isPassingThroughPlatform = false;
		}
		
		// If no collision detected, update player positions
		if (!isColliding) {
			// Update x when no collision is detected
			x += hsp;
		
			// Add gravity to vertical speed
			vsp += GRAVITY;
				
			// Handle max velocity
			if (vsp > MAX_VSP) {
				vsp = MAX_VSP;	
			}
				
			// Update y when no collision detected
			y += vsp;
		}
	}
}
