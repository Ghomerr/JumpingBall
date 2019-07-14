GRAVITY = 0.2;
TILESIZE = 16;
HORIZONTAL_SPEED = 2;
VERTICAL_SPEED = 3;

tilemap = layer_tilemap_get_id("Collisions");
hsp = 0;
vsp = 0;

isJumping = false;
isGrounded = false;
isPreparingJump = false;

radius = abs(bbox_left - bbox_right) / 2;

lineX = 0;
lineY = 0;
lineRadius = TILESIZE;
lineAngle = 0;
lineHsp = 0;
lineVsp = 1;
//isBoucing = false;

posX = 0;
posY = 0;
movVect = 0;

posXLeft = 0;
posXRight = 0;
posYLeft = 0;
posYRight = 0;
tmpPosX = 0;
tmpPosY = 0;

lastVsp = 0;
lastHsp = 0;

frameCounter = 0;
isStopped = false;
isSlow = false;