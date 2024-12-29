extends Node


var grid;
var width;
var height;


func _start():
	# Clear dots
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);


var index = 0;
func _frame(_delta):
	line(index, true);
	line(index - 1, false);
	
	index += 1;
	if (index > (width + height)):
		index = 0;
		

func line(i: int, enabled: bool):
	for x in range(width):
		var y = i - x;
		if x >= width || y < 0 || y >= height:
			continue;
		grid.set_dot(x, y, enabled);
