extends GridContainer

@export var dot_prefab: Control; 

@export var WIDTH: int = 5;
@export var HEIGHT: int = 5;

const PREFAB_DOT = preload("res://prefabs/Dot.tscn");
const OFFSET_MOVE = 5.0;

var padding = 10.0;
var offset = Vector2.ZERO;


func _ready():
	self.columns = WIDTH;
	
	# Remove dot shown in editor
	$Dot.queue_free()
	
	# Add dots as configured
	for i in WIDTH * HEIGHT:
		var dot = PREFAB_DOT.instantiate();
		self.add_child(dot);
	
	self.relayout();
	

func _input(event):
	if event.is_action_pressed("padding_plus"):
		self.padding += 1.0;
		self.relayout();
	if event.is_action_pressed("padding_min"):
		self.padding -= 1.0;
		self.relayout();
		
	if event.is_action("ui_up"):
		self.offset += OFFSET_MOVE * Vector2.UP;
		self.relayout();
	if event.is_action("ui_down"):
		self.offset += OFFSET_MOVE * Vector2.DOWN;
		self.relayout();
	if event.is_action("ui_left"):
		self.offset += OFFSET_MOVE * Vector2.LEFT;
		self.relayout();
	if event.is_action("ui_right"):
		self.offset += OFFSET_MOVE * Vector2.RIGHT;
		self.relayout();


func relayout():
	self.add_theme_constant_override("h_separation", self.padding);
	self.add_theme_constant_override("v_separation", self.padding);
	self.position = self.offset;
