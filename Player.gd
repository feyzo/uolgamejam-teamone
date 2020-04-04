extends KinematicBody2D

export (int) var speed = 200

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
var velocity = Vector2()

var aim_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Player = self
	pass # Replace with function body.


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
		$Sprite.flip_h = false
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		$Sprite.flip_h = true
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_just_pressed("fire"):
		shoot()
	if Input.is_action_just_pressed("change_spell"):
		change_spell()
	velocity = velocity.normalized() * speed
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
	b.start($Muzzle.global_position, aim_direction)
	get_parent().add_child(b)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func add_orb(color):
	pass
	print("Orb "+ color + " collected ... do something with it")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
