extends KinematicBody2D
class_name Platform

export (float) var acceleration = 2000;
export (float) var friction = 2200;
export (float) var maxSpeed = 1000
export (PackedScene) var ballScene

var velocity: Vector2 = Vector2.ZERO
onready var ballSpot: Position2D = $BallSpot

signal ballLaunched

var ball: Ball
var ballAnchored := true

func _ready():
	createBall()

func createBall():
	ball = ballScene.instance()
	ball.position = ballSpot.position
	ballAnchored = true
	add_child(ball);
	ball.anchor()

func _unhandled_key_input(event: InputEventKey):
	
	if(event.is_action_pressed('ui_select') && ballAnchored):
		launchBall()
		get_tree().set_input_as_handled()

func launchBall():
	
	ballAnchored = false
	
	remove_child(ball)
	get_parent().add_child(ball)

	ball.global_position = ballSpot.global_position
	ball.launch(velocity)
	
	emit_signal('ballLaunched')

func _physics_process(delta: float):

	var inputStr := Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')

	if(inputStr != 0):
		velocity.x += inputStr * acceleration * delta
		velocity = velocity.clamped(maxSpeed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	print('Velocity ', velocity.x)

	var collision := move_and_collide(velocity * delta)
	if(collision): 
		handleCollision(collision)
		
func handleCollision(collision: KinematicCollision2D):
	
	var collider = collision.collider
	
	if(collider.is_in_group('limits')):
		velocity.x = 0
