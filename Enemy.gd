extends KinematicBody2D

# TODO Set = to reference to player scene
onready var player = get_node("../Player")

export var health = 3

var state = 'calm'

var velocity = Vector2()

export (int) var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group('enemies')


#func _process(delta):
#	pass

func _physics_process(delta):
	if health <= 0:
		die()
	velocity = Vector2()
	match state:
		'calm':
			pass
		'aggro':
			var direction = (player.global_position - global_position).normalized()
			move_and_collide(direction * speed * delta)

func die():
	Global.Player.change_spell()
	get_node("AudioStream_Death").play()
	self.queue_free()


func _on_Aggro_Area_body_entered(body):
	if body == player:
		state = 'aggro'
		get_node("AudioStream_Agro").play()


func _on_Aggro_Area_body_exited(body):
	if body == player:
		state = 'calm'


func _on_Hitbox_body_entered(body):
	# don't think this works ?
	if body.is_in_group("projectiles"):
		health -= 1
		# TODO Play enemy hurt sound
	if body == player:
		self.player.health -= 1
		print("Player damaged")
		
func hit(damage_taken):
	health -= 1
	$AudioStream_Hurt.play()
	print("I must die !")
	print("damage taken = " + str(damage_taken))
