extends Node


var grid;
var width;
var height;


func _start():
	draw(true);


func _frame(frame):
	pass


func draw(enabled: bool):
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, enabled);
