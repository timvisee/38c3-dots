extends GridContainer

@export var dot_prefab: Control;

@export var WIDTH: int = 16;
@export var HEIGHT: int = 16;

const PREFAB_DOT = preload("res://prefabs/Dot.tscn");
const OFFSET_MOVE = 5.0;

var padding = 10.0;
var offset = Vector2.ZERO;

var dots = [];


func _ready():
	self.columns = WIDTH;
	
	# Remove dot shown in editor
	$Dot.queue_free()
	
	# Add dots as configured
	for i in WIDTH * HEIGHT:
		var dot = PREFAB_DOT.instantiate();
		self.add_child(dot);
		dots.append(dot);
	
	self.relayout();


func _input(event):
	if event.is_action_pressed("padding_plus"):
		self.padding += 1.0;
		self.relayout();
	if event.is_action_pressed("padding_min"):
		self.padding -= 1.0;
		self.relayout();
		
	if event.is_action_pressed("ui_up"):
		self.offset += OFFSET_MOVE * Vector2.UP;
		self.relayout();
	if event.is_action_pressed("ui_down"):
		self.offset += OFFSET_MOVE * Vector2.DOWN;
		self.relayout();
	if event.is_action_pressed("ui_left"):
		self.offset += OFFSET_MOVE * Vector2.LEFT;
		self.relayout();
	if event.is_action_pressed("ui_right"):
		self.offset += OFFSET_MOVE * Vector2.RIGHT;
		self.relayout();
		
	if event.is_action_pressed("ui_accept"):
		for i in range(WIDTH * HEIGHT):
			set_dot_i(i, randi_range(0, 2) == 0);


func xy_to_i(x: int, y: int) -> int:
	return y * WIDTH + x;
	
	
func get_dot(x: int, y: int) -> bool:
	return self.get_dot_i(xy_to_i(x, y));
	
	
func get_dot_i(i: int) -> bool:
	if i < 0 || i >= WIDTH * HEIGHT:
		print("dot index out of bound");
		return false;
	return dots[i].modulate.a > 0;


func set_dot(x: int, y: int, enabled: bool) -> void:
	self.set_dot_i(xy_to_i(x, y), enabled);


func set_dot_i(i: int, enabled: bool) -> void:
	if i < 0 || i >= WIDTH * HEIGHT:
		print("dot index out of bound");
		return;
	dots[i].modulate = Color(1, 1, 1, float(enabled));
	

func relayout():
	self.add_theme_constant_override("h_separation", self.padding);
	self.add_theme_constant_override("v_separation", self.padding);
	self.position = self.offset;
