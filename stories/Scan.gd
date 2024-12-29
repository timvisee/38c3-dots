extends Node


var grid;
var width;
var height;


func _start():
	# Clear panels
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);


var last = 0;
func _frame(_delta):
	print("FRAME");
	set_pix(last, true);
	set_pix(last - 1, false);
	
	last += 1;
	if (last > (width + height)):
		last = 0;
		

func set_pix(i: int, enabled: bool):
	for x in range(width):
		var y = i - x;
		if x >= width || y < 0 || y >= height:
			continue;
		grid.set_dot(x, y, enabled);
