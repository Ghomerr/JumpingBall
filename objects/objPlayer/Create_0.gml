GRAVITY = 0.2;
HALF_GRAVITY = GRAVITY/2;
TILESIZE = 16;
MAX_VSP = 6;
COLLISION_FACTOR = 0.75;

tilemap = layer_tilemap_get_id("Collisions");
pfTilemap = layer_tilemap_get_id("Platforms");

hsp = 0;
vsp = 0;

isColliding = false;
isJumping = false;
isPreparingJump = false;
isPassingThroughPlatform = false;

lineX = 0;
lineY = 0;
lineRadius = TILESIZE;
lineAngle = 0;
lineHsp = 0;
lineVsp = 1;

frameCounter = 0;
isStopped = false;
isSlow = false;

lineColor = c_lime;

jumpCount = 0;
platformCollide = 0;