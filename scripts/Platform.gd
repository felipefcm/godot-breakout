extends KinematicBody2D
class_name Platform

export (float) var maxSpeed = 500;
export (float) var maxAcceleration = 100;
export (float) var frictionCoefficient = 0.1;
export (float) var inputAcceleration = 50;

var velocity: Vector2 = Vector2.ZERO;
var acceleration: Vector2 = Vector2.ZERO;

func _physics_process(delta):

	var leftStr = Input.get_action_strength('ui_left');
	var rightStr = Input.get_action_strength('ui_right');

	var motionForce = Vector2(rightStr - leftStr, 0) * inputAcceleration * delta;
	var dragForce = -velocity * frictionCoefficient * delta;

	acceleration = (acceleration + motionForce + dragForce).clamped(maxAcceleration);
	velocity = (velocity + acceleration).clamped(maxSpeed);

	print('Velocity ', velocity, ' acceleration ', acceleration);
	move_and_collide(velocity * delta);
