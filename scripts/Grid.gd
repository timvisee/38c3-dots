extends GridContainer

@export var dot_prefab: Control;

@export var WIDTH: int = 32;
@export var HEIGHT: int = 32;

const PREFAB_DOT = preload("res://prefabs/Dot.tscn");
const OFFSET_MOVE = 5.0;
const CONFIG_FILE = "user://grid.cfg";

const DEFAULT_PADDING = Vector2.ONE * 8.0;
const DEFAULT_OFFSET = Vector2.ZERO;
const DEFAULT_DOT_SIZE = Vector2.ONE * 8.0;

var padding = DEFAULT_PADDING;
var offset = DEFAULT_OFFSET;
var dot_size = DEFAULT_DOT_SIZE;

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
	
	self.config_load();


func _input(event):
	# Change padding
	if event.is_action_pressed("padding_x_plus"):
		self.padding += Vector2(0.25, 0);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("padding_x_min"):
		self.padding -= Vector2(0.25, 0);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("padding_y_plus"):
		self.padding += Vector2(0, 0.25);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("padding_y_min"):
		self.padding -= Vector2(0, 0.25);
		self.relayout();
		self.config_save();
		
	# Change size
	if event.is_action_pressed("size_x_plus"):
		self.dot_size += Vector2(0.25, 0);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("size_x_min"):
		self.dot_size -= Vector2(0.25, 0);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("size_y_plus"):
		self.dot_size += Vector2(0, 0.25);
		self.relayout();
		self.config_save();
	if event.is_action_pressed("size_y_min"):
		self.dot_size -= Vector2(0, 0.25);
		self.relayout();
		self.config_save();
	
	# Change position
	if event.is_action_pressed("ui_up"):
		self.offset += OFFSET_MOVE * Vector2.UP;
		self.relayout();
		self.config_save();
	if event.is_action_pressed("ui_down"):
		self.offset += OFFSET_MOVE * Vector2.DOWN;
		self.relayout();
		self.config_save();
	if event.is_action_pressed("ui_left"):
		self.offset += OFFSET_MOVE * Vector2.LEFT;
		self.relayout();
		self.config_save();
	if event.is_action_pressed("ui_right"):
		self.offset += OFFSET_MOVE * Vector2.RIGHT;
		self.relayout();
		self.config_save();
	
	# Other actions
	if event.is_action_pressed("ui_accept"):
		for i in range(WIDTH * HEIGHT):
			set_dot_i(i, randi_range(0, 2) == 0);
	if event.is_action_pressed("reset"):
		self.reset();


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
	self.add_theme_constant_override("h_separation", self.padding.x);
	self.add_theme_constant_override("v_separation", self.padding.y);
	for dot in self.dots:
		dot.size = self.dot_size;
		dot.custom_minimum_size = self.dot_size;
	self.position = self.offset;


func reset():
	self.padding = DEFAULT_PADDING;
	self.offset = DEFAULT_OFFSET;
	self.dot_size = DEFAULT_DOT_SIZE;
	self.config_save();
	self.relayout();


func config_load():
	var config = ConfigFile.new();
	if config.load(CONFIG_FILE) != OK:
		return;
	self.padding = config.get_value("", "padding", DEFAULT_PADDING);
	self.offset = config.get_value("", "offset", DEFAULT_OFFSET);
	self.dot_size = config.get_value("", "dot_size", DEFAULT_DOT_SIZE);
	self.relayout();


func config_save():
	var config = ConfigFile.new();
	config.set_value("", "padding", self.padding);
	config.set_value("", "offset", self.offset);
	config.set_value("", "dot_size", self.dot_size);
	config.save(CONFIG_FILE);
