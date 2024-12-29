extends Node


var grid;
var width;
var height;

var tail = [];
var enlarge = 2;
var dir = 0;

var blink_dead = 0;

var fruit = Vector2(1, 1);


func _start():
	dir = 0;
	enlarge = 2;
	tail = [Vector2(int(width / 2), int(height / 2))];
	wipe();


func _frame(frame):
	if blink_dead > 0:
		blink_dead -= 1;
		if blink_dead == 0:
			_start();
			return;
		elif blink_dead % 2 == 1:
			wipe();
		else:
			draw(frame);
		return;
	
	if (frame + 1) % 20 == 0:
		enlarge += 1;
	
	if randf() <= 0.08:
		if randf() <= 0.5:
			dir = posmod(dir - 1, 4);
		else:
			dir = (dir + 1) % 4;
	
	var front = tail[0];
	var next = front;
	if dir == 0:
		next += Vector2.UP;
	elif dir == 1:
		next += Vector2.RIGHT;
	elif dir == 2:
		next += Vector2.DOWN;
	elif dir == 3:
		next += Vector2.LEFT;
	next = wrap_pos(next);
	if is_collision(next):
		blink_dead = 10;
		return;
	tail.push_front(next);
	
	if enlarge == 0:
		var pos = tail.pop_back();
		grid.set_dot(pos.x, pos.y, false);
	else:
		enlarge -= 1;
		
	draw(frame);


func wrap_pos(pos: Vector2) -> Vector2:
	return Vector2(posmod(int(pos.x), width), posmod(int(pos.y), height));


func is_collision(pos: Vector2) -> bool:
	for i in tail:
		if i == pos:
			return true;
	return false;


func draw(frame):
	for pos in tail:
		grid.set_dot(pos.x, pos.y, true);
		
	grid.set_dot(fruit.x, fruit.y, (int(frame / 4) % 2 == 0))

func wipe():
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);
