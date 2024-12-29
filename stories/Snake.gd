extends Node


var grid;
var width;
var height;

var tail = [];
var enlarge = 2;
var dir = 0;

var blink_dead = 0;
var is_done = false;
var auto = true;

var fruit = Vector2.ZERO;


func _start():
	dir = 0;
	enlarge = 2;
	tail = [Vector2(int(width / 2), int(height / 2))];
	fruit = Vector2(randi_range(0, width), randi_range(0, height));
	wipe();


func _frame(frame):
	if blink_dead > 0:
		blink_dead -= 1;
		if blink_dead == 0:
			self.is_done = true;
			_start();
			return;
		elif blink_dead % 2 == 1:
			wipe();
		else:
			draw(frame);
		return;
	
	if auto:
		if (frame + 1) % 25 == 0:
			enlarge += 2;
		
		if randf() <= 0.08:
			if randf() <= 0.5:
				dir = posmod(dir - 1, 4);
			else:
				dir = (dir + 1) % 4;
	else:
		if Input.is_action_pressed("ui_up") && dir != 2:
			dir = 0;
		if Input.is_action_pressed("ui_right") && dir != 3:
			dir = 1;
		if Input.is_action_pressed("ui_down") && dir != 0:
			dir = 2;
		if Input.is_action_pressed("ui_left") && dir != 1:
			dir = 3;
	
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
	if next == fruit:
		enlarge += 3;
		fruit = Vector2(randi_range(0, width), randi_range(0, height));
	tail.push_front(next);
	
	if enlarge == 0:
		var pos = tail.pop_back();
		grid.set_dot(pos.x, pos.y, false);
	else:
		enlarge -= 1;
		
	draw(frame);


func _is_done() -> bool:
	return self.is_done;


func wrap_pos(pos: Vector2) -> Vector2:
	return Vector2(posmod(int(pos.x), width), posmod(int(pos.y), height));


func is_collision(pos: Vector2) -> bool:
	for i in tail:
		if i == pos:
			return true;
	return false;


func draw(frame):
	grid.set_dot(fruit.x, fruit.y, (int(frame / 4) % 2 == 0))
	for pos in tail:
		grid.set_dot(pos.x, pos.y, true);


func wipe():
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);
