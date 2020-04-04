extends RichTextLabel

func _ready():
	updateText()

func _process(delta):
	modulate.a -= 0.9 * delta

func updateText():
	set_bbcode("[right]" + get_parent().current_bullet.name + "[/right]")
	modulate.a = 1
