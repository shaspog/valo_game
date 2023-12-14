//set grid / tile size
#macro TS		32

//get tiles in room
var _w = ceil(room_width / TS);
var _h = ceil(room_height / TS);

global.mp_grid = mp_grid_create(0, 0, _w, _h, TS, TS);

var _map = layer_tilemap_get_id("Tiles_wall");

for (var yy = 0; yy < _h; ++yy) {
    for (var xx = 0; xx < _w; ++xx){
        var _t1 = tilemap_get(_map, xx, yy);
        if (_t1 >= 1 and _t1 <= 47) {
            instance_create_layer(xx * TS, yy * TS, "Collisions", o_wall);
        }
    }
}



//create planning
global.mp_grid = mp_grid_create(0, 0, _w, _h, TS, TS);

//add solid instances to grid
mp_grid_add_instances(global.mp_grid, o_wall, true);

for (var yy = 0; yy < _h; ++yy) {
    for (var xx = 0; xx < _w; ++xx){
        var _t1 = tilemap_get(_map, xx, yy);
        if (_t1 >= 1 && _t1 <= 47) {
			var _inst = collision_point(xx * TS, yy * TS, o_wall, 0, 1);
			
			if _inst == noone continue;
			
			with(_inst) {
				do {
					var _change = false;
					var _inst_next = instance_place(x + 1, y, o_wall);
					if _inst_next != noone {
						image_xscale ++;
						col = make_color_rgb(irandom(255), irandom(255), irandom(255));
						instance_destroy(_inst_next);
						_change = true;
					}
				}until _change == false;
				
				var _inst_above = instance_place(x, y -1, o_wall);
				if _inst_above != noone and _inst_above.bbox_left == bbox_left and _inst_above.bbox_right == bbox_right {
					
					y = _inst_above.y;
					image_yscale += _inst_above.image_yscale;
					instance_destroy(_inst_above);
		
				}
				
				
			}
		}
	}
}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			