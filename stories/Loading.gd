extends Node


var grid;
var width;
var height;
var points;
var midpoint = 10;


func _start():
	# Clear dots
	midpoint = width / 2;
	points = get_points(midpoint, [9, 10 ,11 , 12], 1000);
	for x in range(width):
		for y in range(height):
			grid.set_dot(x, y, false);



var index = 0;
func _frame(frame):
	var lastframe = 0;
	var trail_percent = fposmod(frame/200.0, 1);
	#print(trail_percent)
	var trail = int(len(points)*trail_percent);
	var speed = 50;

	for s in range(speed):
		grid.set_dot(points[index-trail][0], points[index-trail][1], false);
		grid.set_dot(points[index][0], points[index][1], true);
		index = (index +1) % len(points);
		

func _is_done(frame):
	return frame >= 200;
	
	
func _fps():
	return 1;
	
	
func get_points(midpoint, radius, num_points):
	var points = [];
	for i in range(num_points):
		var angle = 2 * PI * i / num_points;
		for rad in radius:
			var x = midpoint + rad * cos(angle);
			var y = midpoint + rad * sin(angle);
			points.append(Vector2(x, y))
	return points
	
