extends Node


var grid;
var width;
var height;


func _start():
	draw(self.on);


var on = true;
func _frame(_delta):
	self.on = !self.on;
	draw(self.on);
		

func draw(enabled: bool):
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, enabled);
