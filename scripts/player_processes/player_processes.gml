function reset_variables() {
	left = 0;
	right = 0;
	up = 0;
	down = 0;
	vmove = 0
	hmove = 0
	dash = false;
}

function get_input(){
	if keyboard_check (ord("A")) || keyboard_check(vk_left)	 left	= 1;
	if keyboard_check (ord("D")) || keyboard_check(vk_right) right	= 1;
	if keyboard_check (ord("W")) || keyboard_check(vk_up)	 up		= 1;
	if keyboard_check (ord("S")) || keyboard_check(vk_down)	 down	= 1;
	if keyboard_check_pressed(vk_space)	dash = true;

}

function calc_movement() {
	 hmove = right - left;
	 vmove = down - up;
	 
	 var _facing = (aim_dir < 90 or aim_dir > 270);
	 if _facing == 0 _facing = -1
	 facing = _facing;
	
	if hmove != 0 or vmove != 0 {
		//get direction we are moving
		var _dir = point_direction(0, 0, hmove, vmove);
		
		//get distance we are moving
		hmove = lengthdir_x(walk_spd, _dir);
		vmove = lengthdir_y(walk_spd, _dir);
		
		//add movement to players position 
		x += hmove;
		y += vmove;
		
	}
	
	x += hsp;
	y += vsp;
	
	//apply knockback drag
	switch(state) {
		default: var _drag = 0.15; break;
		case states.DEAD: var _drag = 0.08; break;
	}
	hsp = lerp(hsp, 0, _drag);
	vsp = lerp(vsp, 0, _drag);
	
}

function aim_bow() {
	aim_dir = point_direction(x, y, mouse_x, mouse_y);
	my_bow.image_angle = aim_dir;	
} 

function collision() {
	//set values
	var _tx = x;
	var _ty = y;
	
	//move back last step position, out of the collision
	x = xprevious;
	y = yprevious;
	
	//get distance we want to move
	var _disx = ceil(abs(_tx - x));
	var _disy = ceil(abs(_ty - y));
	
	if place_meeting(x + _disx * sign(_tx - x), y, o_wall) x = round(x);
	if place_meeting(x, y + _disy * sign(_ty - y), o_wall) y = round(y);
	
	//move as far in x and  y before hitting the wall
	repeat(_disx) {
		if !place_meeting(x + sign(_tx - x), y, o_wall) x += sign(_tx - x);	
	}
	repeat(_disy) {
		if !place_meeting(x, y + sign(_ty - y), o_wall) y += sign(_ty - y);	
	}
}



function collision_bounce (){
	collision();
	if place_meeting(x + sign(hsp), y, o_wall) hsp = -hsp;
	if place_meeting(x, y + sign(vsp), o_wall) vsp = -vsp;
}




function anim() {
	switch(state) {
		default:
			if hmove != 0 or vmove != 0 {
				sprite_index = s_player_walk;
			} else {
				sprite_index = s_player_idle;	
			}
		break;
		case states.DEAD:
			sprite_index = s_player_dead;
		break;
	}
	
	depth = -bbox_bottom;
}

function check_fire() {

	if mouse_check_button(mb_left){
	
		if can_attack {
			can_attack = false;
			alarm[CAN_ATTACK] = fire_rate;
			
			var _dir = point_direction(x, y, mouse_x, mouse_y);
			bow_dis = 5;
			
			var _inst = instance_create_layer(x, y, "Arrow", o_arrow);
			with(_inst) {
				speed = other.arrow_speed;	
				direction = _dir;
				image_angle = _dir;
				owner_id = other;
			}
		}
	
	}

}


function check_bomb() {
	if mouse_check_button_pressed(mb_right){
		if can_throw_bomb {
			can_throw_bomb = false;
			alarm[CAN_THROW_BOMB] = bomb_cooldown; 
			var _dir = point_direction(x, y, mouse_x, mouse_y);
			var _inst = instance_create_layer(x, y, "Instances", o_bomb);
			with (_inst) {
				hsp = lengthdir_x(other.bomb_power, _dir);	
				vsp = lengthdir_y(other.bomb_power, _dir);	
			}
		}
	}
}


function check_dash() {
	 hmove = right - left;
	 vmove = down - up;
	if dash and can_dash{
		state = states.DASH;
		dash_timer = dash_timer_initial;
		var _dir = point_direction(0, 0, hmove, vmove);
		hsp = lengthdir_x(dash_spd, _dir);
		vsp = lengthdir_y(dash_spd, _dir);
		dash_arr = [];
	}
	
}













