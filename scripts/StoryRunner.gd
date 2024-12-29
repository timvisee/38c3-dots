extends Node

const STORIES_PATH = "res://stories";
const STORIES_EXTENSION = "gd";
const STORY_INTERVAL_MSEC = 5 * 1000;

@onready var grid = $"../Center/Margin/Grid";

@export var single_story: Script = null;
@export var interval_msec = STORY_INTERVAL_MSEC;

var story = null;
var story_files = [];
var story_start = 0;


func _ready():
	var stories = load_stories();
	self.next_story();


var frame = 0;
var user_frame = 0;
func _process(_delta):
	if self.single_story == null:
		if Time.get_ticks_msec() - self.story_start > STORY_INTERVAL_MSEC:
			self.next_story();
	
	frame += 1;
	if frame < 5:
		return;
	frame = 0;
	
	if self.story != null:
		if self.story.has_method("_frame"):
			self.story._frame(user_frame);
		else:
			print("Story does not have _frame function");
			
	user_frame += 1;


func _input(event):
	# Change padding
	if event.is_action_pressed("story_next") :
		self.next_story();


func next_story():
	if self.story_files.is_empty():
		print("No stories found");
		return;
	
	# Load next story, or configured single story
	var script;
	if self.single_story == null:
		var path = self.story_files[0];
		print("Loading story ", path);
		self.story_files.push_back(self.story_files.pop_front());
		script = load(path).new();
	else:
		script = self.single_story.new();
	
	if self.story != null:
		self.story.queue_free();
	self.story = script;
	self.story_start = Time.get_ticks_msec();
	
	self.story.grid = self.grid;
	self.story.width = self.grid.WIDTH;
	self.story.height = self.grid.HEIGHT;
	if self.story.has_method("_start"):
		self.story._start();


func load_stories():
	self.story_files = list_files(STORIES_PATH, STORIES_EXTENSION);
	print("Found stories: ", self.story_files);


func list_files(path, ext = null):
	var dir = DirAccess.open(path);
	var files = [];
	if dir:
		dir.list_dir_begin();
		var file_name = dir.get_next();
		while file_name != "":
			if ext and file_name.get_extension() != ext:
				file_name = dir.get_next();
				continue;
			files.append(path + "/" + file_name);
			file_name = dir.get_next();
	else:
		print("An error occurred when trying to access %s." % path)

	return files
