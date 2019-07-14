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
}

// Compute the line jump vector coordinates
if (isPreparingJump) {
	var key_right = keyboard_check(vk_right);
	var key_left = keyboard_check(vk_left);
	
	// Line vertical margin is between 1 - 4 tile size
	lineRadius += lineVsp;
	if (lineRadius >= TILESIZE * 4 || lineRadius <= TILESIZE) {
		lineVsp = lineVsp * -1;
	}
	
	// Move the horizontal coordinates with left/right keys
	lineHsp = (key_right - key_left);
	
	if (abs(lineAngle + lineHsp * DELTA_PI ) <= (HALF_PI - DELTA_PI)) {
		lineAngle += lineHsp * DELTA_PI;
	}
	
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
			//isStopped = true;
			var tileOffset = bbox_side_h == bbox_right ? (TILESIZE - 1) : 0;
			x = x - (x mod TILESIZE) + tileOffset - (bbox_side_h - x);
			hsp = -1 * hsp * 0.8;
			lastHsp = hsp;
			
			sprite_index = spPlayerHit;
			alarm[0] = 10;
			
			if (abs(hsp) <= GRAVITY/2) {
				hsp = 0;
				isGrounded = false;
				isJumping = false;
			}
			
		} else {
			if (isGrounded) {
				hsp += (-1 * sign(hsp)) * GRAVITY;
				x += hsp;
				
				if (abs(hsp) <= GRAVITY/2) {
					hsp = 0;
					isGrounded = false;
					isJumping = false;
				}
				
			} else {
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
				//isStopped = true;
				var tileOffset = bbox_side_v == bbox_bottom ? (TILESIZE - 1) : 0;
				y = y - (y mod TILESIZE) + tileOffset - (bbox_side_v - y);

				vsp = -1 * vsp * 0.8;
				hsp *= 0.8;
				lastVsp = vsp;
				
				sprite_index = spPlayerHit;
				alarm[0] = 10;
		
				if (abs(vsp) <= GRAVITY/2) {
					vsp = 0;
					isGrounded = true;
				}
			} else {
				vsp += GRAVITY;
				y += vsp;
			}
		}
	}
	
	/*
	// Collisions
	movVect = sqrt(sqr(hsp) + sqr(vsp));
	
	// PosX and PosY are the coord of the point located on the sprite border
	// in the direction of the hsp/vsp vector
	posX = x + hsp * radius / movVect;
	posY = y + vsp * radius / movVect;
	
	// Translate the posX,posY to the origin to compute the rotations
	tmpPosX = posX - x;
	tmpPosY = posY - y;
	
	// Point from posX,posY 90° counter clockwise
	posXLeft = (tmpPosX * cos(COLLISION_ANGLE) + tmpPosY * sin(COLLISION_ANGLE)) + x;
	posYLeft = (-tmpPosX * sin(COLLISION_ANGLE) + tmpPosY * cos(COLLISION_ANGLE)) + y;
	
	// Point from posX,posY 90° clockwise
	posXRight = (tmpPosX * cos(-COLLISION_ANGLE) + tmpPosY * sin(-COLLISION_ANGLE)) + x;
	posYRight = (-tmpPosX * sin(-COLLISION_ANGLE) + tmpPosY * cos(-COLLISION_ANGLE)) + y;
	
	// Check if one of those three points collide the tilemap
	if (tilemap_get_at_pixel(tilemap, round(posX + hsp), round(posY + vsp)) != 0 or
		tilemap_get_at_pixel(tilemap, round(posXLeft + hsp), round(posYLeft + vsp)) != 0 or
		tilemap_get_at_pixel(tilemap, round(posXRight + hsp), round(posYRight + vsp))  != 0) {
			
		// Moving the ball next to the collided area
		while (tilemap_get_at_pixel(tilemap, round(posX), round(posY)) == 0 and
			   tilemap_get_at_pixel(tilemap, round(posXLeft), round(posYLeft)) == 0 and 
			   tilemap_get_at_pixel(tilemap, round(posXRight), round(posYRight)) == 0) {
			
			x += sign(hsp);
			y += sign(vsp);
			
			// PosX and PosY are the coord of the point located on the sprite border
			// in the direction of the hsp/vsp vector
			posX = x + hsp * radius / movVect;
			posY = y + vsp * radius / movVect;
			
			// Translate the posX,posY to the origin to compute the rotations
			tmpPosX = posX - x;
			tmpPosY = posY - y;
	
			// Point from posX,posY 90° counter clockwise
			posXLeft = (tmpPosX * cos(COLLISION_ANGLE) + tmpPosY * sin(COLLISION_ANGLE)) + x;
			posYLeft = (-tmpPosX * sin(COLLISION_ANGLE) + tmpPosY * cos(COLLISION_ANGLE)) + y;
	
			// Point from posX,posY 90° clockwise
			posXRight = (tmpPosX * cos(-COLLISION_ANGLE) + tmpPosY * sin(-COLLISION_ANGLE)) + x;
			posYRight = (-tmpPosX * sin(-COLLISION_ANGLE) + tmpPosY * cos(-COLLISION_ANGLE)) + y;
		}
		
		// Stop the ball
		hsp = 0;
		vsp = 0;
		isJumping = false;	
	}
	*/
}


/*
// Get inputs
var key_right = keyboard_check(vk_right);
var key_left = keyboard_check(vk_left);
var key_jump = keyboard_check(vk_space);

// Horizontal movement
hsp = (key_right - key_left) * HORIZONTAL_SPEED;

// Handle horizontal collisions
var bbox_side_h = hsp > 0 ? bbox_right : bbox_left;
var bbox_side_hsp = bbox_side_h + hsp;
if (tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_top) != 0 or 
	tilemap_get_at_pixel(tilemap, bbox_side_hsp, bbox_bottom) != 0) {
	
	var tileOffset = bbox_side_h == bbox_right ? (TILESIZE - 1) : 0;
	x = x - (x mod TILESIZE) + tileOffset - (bbox_side_h - x);
	hsp = 0;
}
x += hsp;


vsp += GRAVITY;

// Vertical movement
if (!isJumping and key_jump) {
	isJumping = true;
	vsp = -VERTICAL_SPEED;
}

// Handle vertical collisions
var bbox_side_v = vsp > 0 ? bbox_bottom : bbox_top;
var bbox_side_vsp = bbox_side_v + round(vsp);
if (tilemap_get_at_pixel(tilemap, bbox_right, bbox_side_vsp) != 0 or 
	tilemap_get_at_pixel(tilemap, bbox_left, bbox_side_vsp) != 0) {
	
	var tileOffset = bbox_side_v == bbox_bottom ? (TILESIZE - 1) : 0;
	y = y - (y mod TILESIZE) + tileOffset - (bbox_side_v - y);
	vsp = 0;
	isJumping = false;
}
y += vsp;
*/