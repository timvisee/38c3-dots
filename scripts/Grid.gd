extends GridContainer

@export var dot_prefab: Control; 

@export var WIDTH: int = 5;
@export var HEIGHT: int = 5;

const prefab_dot = preload("res://prefabs/Dot.tscn")

var padding = 10.0;
var offset = Vector2.ZERO;


func _ready():
	self.columns = WIDTH;
	
	# Remove dot shown in editor
	$Dot.queue_free()
	
	# Add dots as configured
	for i in WIDTH * HEIGHT:
		var dot = prefab_dot.instantiate();
		self.add_child(dot);
		
	self.relayout();
	

func _input(event):
	if event.is_action_pressed("padding_plus"):
		self.padding += 1.0;
		self.relayout();
	if event.is_action_pressed("padding_min"):
		self.padding -= 1.0;
		self.relayout();


func relayout():
	self.add_theme_constant_override("h_separation", self.padding);
	self.add_theme_constant_override("v_separation", self.padding);
