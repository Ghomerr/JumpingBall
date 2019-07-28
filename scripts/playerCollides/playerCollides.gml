var isCollidingHorizontally = argument0;

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
if (!isCollidingHorizontally and abs(vsp) <= HALF_GRAVITY) {
	vsp = 0;
	isJumping = false;
}
if (isCollidingHorizontally and abs(hsp) <= HALF_GRAVITY) {
	hsp = 0;
}