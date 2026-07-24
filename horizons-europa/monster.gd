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
	if global_position.x <= $"../Node2D".global_position.x:
		visible = false
		
		await get_tree().create_timer(1.0).timeout
		
		position = start_position
		position.y = [lane1, lane2, lane3, lane4].pick_random()
		
		visible = true
