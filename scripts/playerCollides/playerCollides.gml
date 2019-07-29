// Get inputs argumebts
var isCollidingHorizontally = argument0;
var bbox_side = argument1;

// Check if the collision is done at the player bottom
var isBottomColliding = bbox_side == bbox_bottom;

// Handle player position when colliding
if (isCollidingHorizontally) {
	// Pixel perfect position of the player 
	var tileOffset = bbox_side == bbox_right ? (TILESIZE - 1) : 0;
	x = x - (x mod TILESIZE) + tileOffset - (bbox_side - x);
} else {
	// Pixel perfect player position
	var tileOffset = isBottomColliding ? (TILESIZE - 1) : 0;
	y = y - (y mod TILESIZE) + tileOffset - (bbox_side - y);
}

// Check speed direction
var hspSign = isCollidingHorizontally ? -1 : 1;
var vspSign = !isCollidingHorizontally ? -1 : 1;

// Slow the player on colliding
hsp = hspSign * hsp * COLLISION_FACTOR;
vsp = vspSign * vsp * COLLISION_FACTOR;
				
// Display hit sprite
sprite_index = spPlayerHit;
alarm[0] = 10;

// Colliding flag
isColliding = true;
		
// Stop motion if speed is to low 
if (isBottomColliding) {
	// Do this only if the collision is done at the player bottom to avoid
	// the player to be stuck at the ceiling
	if (!isCollidingHorizontally and abs(vsp) <= HALF_GRAVITY) {
		vsp = 0;
		// Stop the jumping state
		isJumping = false;
	}
}
if (isCollidingHorizontally and abs(hsp) <= HALF_GRAVITY) {
	hsp = 0;
}