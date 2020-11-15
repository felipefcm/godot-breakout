extends Node2D
class_name Level

onready var platform: Platform = $Platform
onready var hole: Area2D = $Hole

onready var numBricks: int = len(get_tree().get_nodes_in_group('bricks'))

func _ready():
	
	platform.connect('ballLaunched', self, 'ballLaunched')
	hole.connect('body_entered', self, 'lostBall')

func ballLaunched():
	print('Ball launched received')

func lostBall(body: Node):
	print('Lost ball')
	body.queue_free()
	platform.createBall()
