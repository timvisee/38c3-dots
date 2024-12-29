extends Node


var grid;
var width;
var height;

const BALL_COUNT = 8;

var balls = [];
var dirs = [];

func _start():
	for i in range(BALL_COUNT):
		balls.push_back(Vector2(randi_range(0, width), randi_range(0, height)));
		var dir = (Vector2.UP + Vector2.RIGHT).rotated(float(randi_range(0, 4)) * PI / 2.0);
		dirs.push_back(dir);
	wipe();


func _frame(frame):
	for i in range(BALL_COUNT):
		balls[i] += dirs[i];
		
		if balls[i].x < 0:
			balls[i].x = 0;
			dirs[i].x *= -1;
		elif balls[i].x >= width:
			balls[i].x = width - 1;
			dirs[i].x *= -1;
		if balls[i].y < 0:
			balls[i].y = 0;
			dirs[i].y *= -1;
		elif balls[i].y >= height:
			balls[i].y = height - 1;
			dirs[i].y *= -1;
	
	wipe();
	for pos in balls:
		grid.set_dot(pos.x, pos.y, true);


func wipe():
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);
