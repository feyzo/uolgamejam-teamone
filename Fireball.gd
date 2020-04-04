extends KinematicBody2D

var  speed = 300
var velocity = Vector2()
var FireExplode = preload("res://Efects/Fire_Expode.tscn")

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var b = FireExplode.instance()
		b.position = global_position
		get_parent().add_child(b)
		queue_free()
		#velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
