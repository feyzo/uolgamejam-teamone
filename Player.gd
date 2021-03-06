extends KinematicBody2D


export (int) var health = 3

const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 800

const MAX_AMMO = 3

const GAME_OVER_SCREEN = preload("res://GameOverScreen.tscn")

export (int) var ammo = 3


# added damage to "bullet" node 
# communicaton that way is easier
# ignore this damage
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
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Camera2D/Game Over".visible = false
	Global.Player = self
	self.add_to_group("player")


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

	if Input.is_action_just_pressed("fire") and ammo > 0:
		shoot()
	if Input.is_action_just_pressed("change_spell"):
		#change_spell()
		pass
	
	aim_direction = self.get_angle_to(get_global_mouse_position())

func change_spell():
	spell_index += 1
	if spell_index > spells.size() - 1:
		spell_index = 0
	current_bullet = spells[spell_index]
	print("changed spell")
	get_node("RichTextLabel").updateText()
	ammo = MAX_AMMO
	
	
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = current_bullet.res.instance()
	var pos = $Muzzle.global_position
	if get_global_mouse_position() < position:
		pos.x -= 20	
	b.start(pos, aim_direction)
	get_parent().add_child(b)
	ammo -= 1

func _physics_process(delta):
	if health <= 0:
		die()
	if not dead:
		get_input(delta)
	if dead:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)

func add_orb(color):
	change_spell()
	print("Orb "+ color + " collected ... do something with it")

func die():
	$"Camera2D/Game Over".visible = true
	get_parent().add_child(GAME_OVER_SCREEN.instance())
	dead = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
