extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

var aim_direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	aim_direction = self.get_angle_to(get_global_mouse_position())


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
