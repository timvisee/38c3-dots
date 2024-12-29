extends Node


var grid;
var width;
var height;


func _start():
	wipe();


func _frame(frame):
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, (int(x / 3) + int((y + frame) / 3)) % 2 == 0);


func wipe():
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);
