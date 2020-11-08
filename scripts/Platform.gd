extends KinematicBody2D
class_name Platform

export (float) var maxSpeed = 1200
export (PackedScene) var ballScene

var velocity: Vector2 = Vector2.ZERO
onready var ballSpot: Position2D = $BallSpot

func _ready():
	var ball: Ball = ballScene.instance()
	ball.position = ballSpot.position
	add_child(ball);

func _physics_process(delta):

	var leftStr := Input.get_action_strength('ui_left')
	var rightStr := Input.get_action_strength('ui_right')

	velocity.x = (rightStr - leftStr) * maxSpeed

	var collision := move_and_collide(velocity * delta)
	if(collision): 
		handleCollision(collision)
		
func handleCollision(collision):
	var collider = collision.collider
	if(!collider.is_in_group('limits')):
		return
