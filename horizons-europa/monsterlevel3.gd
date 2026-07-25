extends TextureRect
@export var speed = 300
@export var score = 0
@export var lane_switch_chance = 0.5
var start_position = 411
var resetting = false
var has_switched_lane = false
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

	if not has_switched_lane and randf() < 0.01 * delta * 60:
		if randf() < lane_switch_chance:
			var lanes = [lane1, lane2, lane3, lane4]
			var current_index = lanes.find(position.y)
			var adjacent_indices = []
			if current_index > 0:
				adjacent_indices.append(current_index - 1)
			if current_index < lanes.size() - 1:
				adjacent_indices.append(current_index + 1)
			if adjacent_indices.size() > 0:
				position.y = lanes[adjacent_indices.pick_random()]
		has_switched_lane = true

	var disc = $"../Disc"
	var same_lane = abs(position.y - disc.position.y) < 5.0
	var x_touching = get_global_rect().intersects(disc.get_global_rect())
	if same_lane and x_touching:
		resetting = true
		visible = false
		score += 1
		$"../Score".text = "Score: " + str(score)
		await get_tree().create_timer(1.0).timeout
		position = start_position
		position.y = [lane1, lane2, lane3, lane4].pick_random()
		has_switched_lane = false
		visible = true
		resetting = false
	elif global_position.x <= $"../Node2D".global_position.x:
		resetting = true
		visible = false
		Global.lives -= 1
		await get_tree().create_timer(1.0).timeout
		position = start_position
		position.y = [lane1, lane2, lane3, lane4].pick_random()
		has_switched_lane = false
		visible = true
		resetting = false
		
		if Global.lives <= 0:
			Global.lives = 5
			score = 0
			ScreenManager.fail_level()
	if score >= 10:
		get_tree().change_scene_to_file("res://levelpassed.tscn")
