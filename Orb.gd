extends Node2D

export(String, "blue", "red", "green") var orb_color = "blue"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var orb_xy = { "blue" : Vector2(0,480), "green" : Vector2(0,432), "red" : Vector2(192, 432)}
# Called when the node enters the scene tree for the first time.
func _ready():
	if orb_color == "blue":
		$Sprite.region_rect = Rect2(orb_xy["blue"],Vector2(48,48))
	if orb_color == "green":
		$Sprite.region_rect = Rect2(orb_xy["green"],Vector2(48,48))
	if orb_color == "red":
		$Sprite.region_rect = Rect2(orb_xy["red"],Vector2(48,48))
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	$".".queue_free()
	Global.Player.add_orb( orb_color)
	pass # Replace with function body.