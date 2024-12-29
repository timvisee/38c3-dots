extends Node


var grid;
var width;
var height;

var dir = Vector2.ZERO;


func _start():
	var r = randi_range(0, 7);
	if r >= 0 && r <= 2:
		self.dir += Vector2.UP;
	if r >= 2 && r <= 4:
		self.dir += Vector2.RIGHT;
	if r >= 4 && r <= 6:
		self.dir += Vector2.DOWN;
	if r >= 6 && r <= 7 || r == 0:
		self.dir += Vector2.LEFT;
		
	wipe();


func _frame(frame):
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, posmod(  int((x + dir.x * frame)/ 3) + int((y + dir.y * frame) / 3), 2) == 0);


func wipe():
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);
