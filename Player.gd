extends KinematicBody2D

export (int) var speed = 200
const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 800

var velocity = Vector2.ZERO
var aim_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input(delta):
	var v = Vector2.ZERO
	v.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	v.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	v = v.normalized()

	if v != Vector2.ZERO:
		velocity = velocity.move_toward(v * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# velocity = velocity.normalized() * speed
	aim_direction = self.get_angle_to(get_global_mouse_position())

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
