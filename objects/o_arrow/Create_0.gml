damage = 5;
range = 160;
owner_id = noone; 
knockback_time = 3;

function arrow_die() {
	
	speed = 0;
	instance_change(o_arrow_explode, false);
	
}