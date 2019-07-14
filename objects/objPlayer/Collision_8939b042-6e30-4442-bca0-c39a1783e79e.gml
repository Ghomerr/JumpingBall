if (!other.isPushed) {
	with(other) {
		isPushed = true;
		alarm[0] = 10;
		sprite_index = spOrangeSwitchTransition;
	}
}