switch(state) {
	
		case states.DEAD:
			image_index = image_index - 1;
			image_speed = 0;
			//dead = true;
		break;
		case states.ATTACK:
			image_index = 0;
			state = states.IDLE;
		break;
}