extends Node


@onready var grid = $"../Container/Grid";
@onready var width = grid.WIDTH;
@onready var height = grid.HEIGHT;


var frame = 0;
var last = 0;
func _process(delta):
	frame += 1;
	if frame < 5:
		return;
	frame = 0;
	
	grid.set_dot_i(last, false);
	grid.set_dot_i(last - 1, true);
	if last == 0:
		grid.set_dot_i(last - 1, true);
	else:
		grid.set_dot_i(width * height - 1, true);
	last = (last + 1) % (width * height);
