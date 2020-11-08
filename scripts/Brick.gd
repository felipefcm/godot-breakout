extends StaticBody2D
class_name Brick

onready var badSprite = $SpriteBad

func hit():
	
	if(!badSprite.visible): 
		badSprite.visible = true
		return false
	
	queue_free()
	return true
