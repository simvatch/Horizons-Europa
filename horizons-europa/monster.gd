extends TextureRect

@export var speed = 400

var start_position: Vector2

var lane1 = 154
var lane2 = 282
var lane3 = 411
var lane4 = 540


func _ready():
	var lanes = [lane1, lane2, lane3, lane4]
	position.y = lanes.pick_random()
	start_position = position


func _process(delta):
	position.x -= speed * delta
	
	if position.x <= -size.x:
		position.x = start_position.x
		
		position.y = [lane1, lane2, lane3, lane4].pick_random()
