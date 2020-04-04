extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main_music = load("res://Audio/Explore_Theme.ogg")
var combat_music = load("res://Audio/Comat_Music.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func combat():
	self.set_stream = combat_music
	
func explore():
	self.set_stream = main_music
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
