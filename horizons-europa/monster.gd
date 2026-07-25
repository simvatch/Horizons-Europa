extends TextureRect

@export var speed = 250
@export var score = 0

var start_position: Vector2
var resetting = false

var lane1 = 154
var lane2 = 282
var lane3 = 411
var lane4 = 540


func _ready():
	var lanes = [lane1, lane2, lane3, lane4]
	position.y = lanes.pick_random()
	start_position = position
	
	$"../Score".text = "Score: " + str(score)


func _process(delta):
	if resetting:
		return
	
	position.x -= speed * delta
	
	if get_global_rect().intersects($"../Disc".get_global_rect()):
		resetting = true
		visible = false
		
		score += 1
		$"../Score".text = "Score: " + str(score)
		
		await get_tree().create_timer(1.0).timeout
		
		position = start_position
		position.y = [lane1, lane2, lane3, lane4].pick_random()
		
		visible = true
		resetting = false
	
	elif global_position.x <= $"../Node2D".global_position.x:
		resetting = true
		visible = false
		
		await get_tree().create_timer(1.0).timeout
		
		position = start_position
		position.y = [lane1, lane2, lane3, lane4].pick_random()
		
		visible = true
		resetting = false

	if score == 3:
		get_tree().change_scene_to_file("res://levelpassed.tscn")
