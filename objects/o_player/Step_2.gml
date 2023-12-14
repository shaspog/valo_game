if instance_exists(my_bow) {
	var _depth = (aim_dir > 0 and aim_dir < 180);
	my_bow.depth = depth + _depth;

	my_bow.x = x + lengthdir_x(bow_dis, aim_dir);
	my_bow.y = y + lengthdir_y(bow_dis, aim_dir);

	bow_dis = lerp(bow_dis, 11, 0.1);
}