extends Node2D

@onready var score_ui = $"../Score"
@onready var kill_line_area = get_tree().get_first_node_in_group("kill_line_area")
@onready var attack_area = get_tree().get_first_node_in_group("attack_area")
@onready var player = get_tree().get_first_node_in_group("player")

@export var speed = 350

var score = 0
var start_position_x = 0
var resetting = false

const LANE_Y = {
	1: 343,
	2: 499,
	3: 650,
	4: 804
}

var lane = 1


func set_lane(new_lane):
	lane = new_lane
	position.y = LANE_Y[lane]


func respawn():
	position.x = start_position_x
	set_lane(randi_range(1, 4))
	visible = true
	resetting = false


func _ready():
	respawn()
	score_ui.text = "Score: 0"


func _process(delta):
	position.x += speed * delta

	if resetting:
		return

	if player == null:
		return

	if attack_area.can_interact and lane == player.lane:
		resetting = true
		visible = false

		score += 1
		score_ui.text = "Score: " + str(score)

		if score >= 10:
			score = 0
			Global.lives = 5
			get_tree().change_scene_to_file("res://levelpassed.tscn")
			return

		await get_tree().create_timer(1.0).timeout
		respawn()

	elif kill_line_area.can_interact and lane == player.lane:
		resetting = true
		visible = false

		Global.lives -= 1

		if Global.lives <= 0:
			score = 0
			Global.lives = 5
			ScreenManager.fail_level()
			return

		await get_tree().create_timer(1.0).timeout
		respawn()
