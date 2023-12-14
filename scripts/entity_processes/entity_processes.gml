function damage_entity(_tid, _sid, _damage, _time){
///@arg tid		real	target_id
///@arg sid		real	source_id
///@arg damage	real	how much damage we deal
///@arg time	real	how long to knockback the target
	with(_tid) {
		if alarm[HURT] > 0 or (state == states.DEAD or state == states.DASH) exit;
		
		hp -= _damage;
		var _dead = is_dead();
		path_end();
		//set knosckback dis
		if _dead var _dis = 5 else var _dis = 3;
		var _dir  = point_direction(_sid.x, _sid.y, x, y);
		hsp += lengthdir_x(_dis, _dir);
		vsp += lengthdir_y(_dis, _dir);
		calc_path_delay = _time;
		alert = true;
		knockback_time = _time;
		alarm[HURT] = hurt_time;
		if !_dead state = states.KNOCKBACK;
		image_index = 0;
		return _dead;
	}
}

function is_dead() {
	//checks if the instance running is dead
	
	if state != states.DEAD {
		if hp <= 0 {
			state = states.DEAD;
			hp = 0;
			image_index = 0;
			//set death sound
			switch(object_index) {
					default:
						//play sound
					break;
					
					case o_player:
						if instance_exists(my_bow) instance_destroy(my_bow);
						//player sound
					break;
			}
			return true;
		}
	}else return true
}

//function disappear() {
//	if dead = true alarm [3] = dead_timer
	
//	if ready_disappear == true instance_destroy(other.o_enemy)
//	if ready_disappear == true sprite_delete(other.s_enemy_dead);
//}

function check_if_stopped() {
	if abs(hsp) < 0.1 hsp = 0;
	if abs(vsp) < 0.1 hsp = 0;
}

function show_healthbar() {
	
	if hp != hp_max and hp > 0 {
		draw_healthbar(x-7, y-19, x+7, y-14, hp/hp_max*100, $003300, $3232FF, $00B200, 0, 1, 1);	
	}
	
}