GRAVITY = 0.2;
TILESIZE = 16;

tilemap = layer_tilemap_get_id("Collisions");
hsp = 0;
vsp = 0;

isJumping = false;
isGrounded = false;
isPreparingJump = false;

lineX = 0;
lineY = 0;
lineRadius = TILESIZE;
lineAngle = 0;
lineHsp = 0;
lineVsp = 1;

lastVsp = 0;
lastHsp = 0;

frameCounter = 0;
isStopped = false;
isSlow = false;

lineColor = c_lime;

jumpCount = 0;