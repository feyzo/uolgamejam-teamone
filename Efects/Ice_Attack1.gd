extends KinematicBody2D

var  speed = 300
var velocity = Vector2()
var IceExplode = preload("res://Efects/Ice_Expode.tscn")
var alpha = 0
var timer_to_die = 0
var pending_die = false

func start(pos, dir):
	$AudioStream_Cast.play()
	$AnimatedSprite.modulate = Color(1,1,1,0)
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	if pending_die:
		timer_to_die += 1
	if timer_to_die > 100:
		queue_free()
	alpha += 0.1
	clamp(alpha,0,1)
	$AnimatedSprite.modulate = Color(1,1,1,alpha)
	var collision = move_and_collide(velocity * delta)
	if collision:
		pending_die = true
		#queue_free()
		#queue_free()
		$AnimatedSprite.visible = false
		velocity = Vector2(0,0)
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = true
		var b = IceExplode.instance()
		b.position = global_position
		get_parent().add_child(b)
		$AudioStream_Hit.play()
		#velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
