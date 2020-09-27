extends KinematicBody2D
class_name Platform

export (float) var maxSpeed = 80;
export (float) var maxAcceleration = 10;
export (float) var drag = 50;

var velocity: Vector2 = Vector2.ZERO;
var acceleration: Vector2 = Vector2.ZERO;

func _process(delta):

	var leftStr = Input.get_action_strength('ui_left');
	var rightStr = Input.get_action_strength('ui_right');

	acceleration += Vector2(rightStr - leftStr, 0).clamped(maxAcceleration) * delta;
	var dragForce = (velocity * -1).normalized() * drag;

func _physics_process(delta):
	
	velocity += velocity + acceleration;
	move_and_collide((velocity * delta).normalized() * maxSpeed);
