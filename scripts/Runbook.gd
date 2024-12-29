extends Node


@onready var grid = $"../Center/Margin/Grid";
@onready var width = grid.WIDTH;
@onready var height = grid.HEIGHT;


var frame = 0;
var last = 0;
func _process(_delta):
	frame += 1;
	if frame < 5:
		return;
	frame = 0;
	
	set_pix(last, false);
	set_pix(last - 1, true);
	
	last += 1;
	if (last > (width + height)):
		last = 0;
		

func set_pix(i: int, enabled: bool):
	for x in range(width):
		var y = i - x;
		if y >= height:
			continue;
		if x >= width:
			continue;
		grid.set_dot(x, y, enabled);
