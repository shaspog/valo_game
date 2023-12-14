var _dir = point_direction(x, y, other.x, other.y);
var _force = force;
with(other) {
	hsp = lengthdir_x(_force, _dir);
	vsp = lengthdir_y(_force, _dir);
}

damage_entity(other, id, damage, random_range(45, 60));