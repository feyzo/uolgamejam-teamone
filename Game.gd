extends Node2D

func _ready():
	$AudioStreamPlayer.play()


func _process(delta):
	$CanvasLayer/MarginContainer/RichTextLabel.text = "Health " + str(Global.Player.health)
	check_win_state()


func check_win_state():
	var enemies_left = get_tree().get_nodes_in_group("enemies").size()
	var orbs_left = get_tree().get_nodes_in_group("orbs").size()
	if enemies_left <= 0 or orbs_left <= 0:
		print("You won the level!")
