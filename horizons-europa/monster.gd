extends Node2D

@onready var score_ui = get_tree().get_first_node_in_group("score_ui")
@onready var monster_1_area = get_tree().get_first_node_in_group("monster_1_area")
@onready var kill_line_area = get_tree().get_first_node_in_group("kill_line_area")
@onready var attack_area = get_tree().get_first_node_in_group("attack_area")
@onready var attack = get_tree().get_first_node_in_group("attack")

@export var speed = 250
@export var score = 0

var start_position_x = 0
var resetting = false

var lane1 = 25
var lane2 = 176
var lane3 = 328
var lane4 = 489

func _ready():
	var lanes = [lane1, lane2, lane3, lane4]
	position.y = lanes.pick_random()
	self.position.x = 0

func _process(delta):
	self.position.x += speed * delta
	
	if resetting:
		return

	if attack_area.can_interact:
		resetting = true
		visible = false

		score += 1
		score_ui.text = "Score: " + str(score)

		await get_tree().create_timer(1.0).timeout

		position = start_position_x
		position.y = [lane1, lane2, lane3, lane4].pick_random()

		visible = true
		resetting = false

	elif kill_line_area.can_interact:
		resetting = true
		visible = false
		
		Global.lives -= 1

		await get_tree().create_timer(1.0).timeout

		position.x = 0
		position.y = [lane1, lane2, lane3, lane4].pick_random()

		visible = true
		resetting = false
		
		if Global.lives <= 0:
			Global.lives = 5
			score = 0
			ScreenManager.fail_level()

	if score >= 3:
		get_tree().change_scene_to_file("res://levelpassed.tscn")
