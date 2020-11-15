extends KinematicBody2D
class_name Ball

export (float) var maxSpeed = 800
onready var shape: CollisionShape2D = $CollisionShape2D

var velocity := Vector2.ZERO

func anchor():
	shape.disabled = true

func launch(platformVelocity: Vector2):
	velocity = (platformVelocity.normalized() + Vector2(0, -1)).normalized() * maxSpeed
	shape.disabled = false

func _physics_process(delta: float):
	
	var collision := move_and_collide(velocity * delta)
	
	if(collision):
		
		var collider = collision.collider
		velocity = velocity.bounce(collision.normal)

		if(collider.is_in_group('bricks')):
			var brick = collider as Brick
			brick.hit()
