extends KinematicBody2D

var  speed = 300
var velocity = Vector2()
var IceExplode = preload("res://Efects/Ice_Expode.tscn")

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		var b = IceExplode.instance()
		b.position = global_position
		get_parent().add_child(b)
		#velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
