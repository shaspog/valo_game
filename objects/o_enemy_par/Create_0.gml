event_inherited();
hp_max = 15;
hp = hp_max;
//are we chasing the player
alert = false;
alert_dis = 160;
attack_dis = 18;
attack_angle  = 180;

attack_dis = 12;
attack_frame = 6;
can_attack = true;
attack_cooldown = 75;
damage = 2;
knockback_time = 10;

//create path resource
path = path_add(); 
//movespeed
move_spd = 1;

calc_path_delay = 30;

calc_path_timer = irandom(60);

