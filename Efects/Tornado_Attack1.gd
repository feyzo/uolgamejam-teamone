extends KinematicBody2D

var  speed = 300
var velocity = Vector2()
var alpha = 0
export var damage = 1

func start(pos, dir):
	$AudioStream_Cast.play()
	$AnimatedSprite.modulate = Color(1,1,1,0)
	#rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	alpha += 0.1
	clamp(alpha,0,1)
	$AnimatedSprite.modulate = Color(1,1,1,alpha)
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
		#velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit(damage)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
