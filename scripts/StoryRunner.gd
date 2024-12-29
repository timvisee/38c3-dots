extends Node


@onready var grid = $"../Center/Margin/Grid";
@onready var width = grid.WIDTH;
@onready var height = grid.HEIGHT;

const STORIES_PATH = "res://stories";
const STORIES_EXTENSION = "gd";

var story = null;
var story_files = [];

func _ready():
	var stories = load_stories();
	self.next_story();


var frame = 0;
var last = 0;
func _process(_delta):
	frame += 1;
	if frame < 5:
		return;
	frame = 0;
	
	if self.story != null:
		self.story._frame(_delta);


func next_story():
	if self.story_files.is_empty():
		print("No stories found");
		return;
		
	var path = self.story_files[0];
	var script = load(path).new();
	
	if self.story != null:
		self.story.queue_free();
	self.story = script;
	
	self.story.grid = self.grid;
	self.story.width = self.grid.WIDTH;
	self.story.height = self.grid.HEIGHT;
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
