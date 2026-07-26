extends Node2D

@onready var sprite = get_tree().get_first_node_in_group("monster_sprite")
@onready var score_ui = get_tree().get_first_node_in_group("score_ui")
@onready var health_bar = get_tree().get_first_node_in_group("health_bar")
@onready var kill_line_area = get_tree().get_first_node_in_group("kill_line_area")
@onready var attack_area = get_tree().get_first_node_in_group("attack_area")
@onready var player = get_tree().get_first_node_in_group("player")

@export var speed := 250.0

var score := 0
var start_position_x := 0.0
var resetting := false
var lane := 1
var lane_switch_cooldown := 0.0
var is_slowest := false

const LANE_Y = {
	1: 343,
	2: 499,
	3: 650,
	4: 804
}


func _ready():
	start_position_x = position.x
	is_slowest = is_in_group("slowest_monster")
	respawn()

	if score_ui:
		score_ui.text = "Score: 0"


func _process(delta):
	if resetting:
		return

	position.x += speed * delta

	if lane_switch_cooldown > 0:
		lane_switch_cooldown -= delta

	# Random lane switching for slowest monster
	if is_slowest and lane_switch_cooldown <= 0 and randf() < 0.02:
		var new_lane = randi_range(1, 4)
		if new_lane != lane:
			set_lane(new_lane)
			lane_switch_cooldown = 1.0

	if player == null:
		return

	# Successful hit
	if attack_area.can_interact and lane == player.lane:
		sprite.play("explode")
		handle_hit()

	# Missed note in correct lane
	elif kill_line_area.can_interact and lane == player.lane:
		handle_pass()

	# Missed note entirely
	elif kill_line_area.can_interact:
		handle_miss()


func set_lane(new_lane: int):
	lane = new_lane
	position.y = LANE_Y[lane]


func respawn():
	position.x = start_position_x
	set_lane(randi_range(1, 4))
	visible = true
	resetting = false


func handle_hit():
	resetting = true
	visible = false

	score += 1

	if score_ui:
		score_ui.text = "Score: " + str(score)

	await get_tree().create_timer(1.0).timeout
	respawn()


func handle_pass():
	resetting = true
	visible = false

	await get_tree().create_timer(1.0).timeout
	respawn()


func handle_miss():
	resetting = true
	visible = false

	if health_bar:
		health_bar.value -= 20

		if health_bar.value <= 0:
			score = 0
			health_bar.value = 100

			if score_ui:
				score_ui.text = "Score: 0"

			ScreenManager.fail_level()
			return

	await get_tree().create_timer(1.0).timeout
	respawn()
