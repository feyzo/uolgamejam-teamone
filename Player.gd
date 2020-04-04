extends KinematicBody2D


export (int) var health = 3

const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 800


var spells = [
	{
		"res": preload("res://Efects/Fireball_Attack1.tscn"),
		"name": "Fireball",
		"damage": 1,
	},
	{
		"res": preload("res://Efects/Tornado_Attack1.tscn"),
		"name": "Tornado",
		"damage": 2,
	},
	{
		"res": preload("res://Efects/Ice_Attack1.tscn"),
		"name": "Ice",
		"damage": 1,
	}
]
var current_bullet = spells[0]
var spell_index = 0
var velocity = Vector2.ZERO

var aim_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Player = self
	pass # Replace with function body.


func get_input(delta):
	var v = Vector2.ZERO
	v.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	v.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	v = v.normalized()

	$Sprite.flip_h = false
	if v.x < 0:
		$Sprite.flip_h = true

	if v != Vector2.ZERO:
		velocity = velocity.move_toward(v * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if Input.is_action_just_pressed("fire"):
		shoot()
	if Input.is_action_just_pressed("change_spell"):
		change_spell()
	
	aim_direction = self.get_angle_to(get_global_mouse_position())

func change_spell():
	spell_index += 1
	if spell_index > spells.size() - 1:
		spell_index = 0
	current_bullet = spells[spell_index]
	print("changed spell")
	get_node("RichTextLabel").updateText()
	
	
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = current_bullet.res.instance()
	var pos = $Muzzle.global_position
	if get_global_mouse_position() < position:
		pos.x -= 20	
	b.start(pos, aim_direction)
	get_parent().add_child(b)

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

func add_orb(color):
	pass
	print("Orb "+ color + " collected ... do something with it")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
