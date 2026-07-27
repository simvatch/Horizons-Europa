extends Node2D

# Own nodes — must NOT be looked up by group, or every monster shares one instance
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

# Shared level nodes — one per level, group lookup is correct here
@onready var score_ui = get_tree().get_first_node_in_group("score_ui")
@onready var health_bar = get_tree().get_first_node_in_group("health_bar")
@onready var kill_line_area = get_tree().get_first_node_in_group("kill_line_area")
@onready var attack_area = get_tree().get_first_node_in_group("attack_area")
@onready var player = get_tree().get_first_node_in_group("player")

@export var speed := 250.0

const DAMAGE_PER_MISS := 20.0  # 100 health / 20 = 5 lives

var start_position_x := 0.0
var resetting := false
var lane := 1
var lane_switch_cooldown := 0.0
var is_slowest := false
var moving := true

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
	update_score_ui()


func _process(delta):
	if moving:
		position.x += speed * delta

	if lane_switch_cooldown > 0:
		lane_switch_cooldown -= delta

	# Random lane switching for slowest monster
	if is_slowest and lane_switch_cooldown <= 0 and randf() < 0.02:
		var new_lane = randi_range(1, 4)
		if new_lane != lane:
			set_lane(new_lane)
			lane_switch_cooldown = 1.0

	if resetting or player == null:
		return

	var overlaps = area.get_overlapping_areas()

	# Struck by the disc while sharing its lane
	if overlaps.has(attack_area) and lane == player.lane:
		handle_hit()

	# Got past the player and reached the laser — always costs a life
	elif overlaps.has(kill_line_area):
		handle_miss()


func set_lane(new_lane: int):
	lane = new_lane
	position.y = LANE_Y[lane]


func respawn():
	moving = true
	position.x = start_position_x
	set_lane(randi_range(1, 4))
	visible = true
	resetting = false


func update_score_ui():
	if score_ui:
		score_ui.text = "Score: " + str(Global.score)


func handle_hit():
	resetting = true
	await explosion()
	visible = false

	Global.score += 1
	update_score_ui()

	var score_needed = Global.score_needed.get(Global.level, 10)
	if Global.score >= score_needed:
		get_tree().change_scene_to_file("res://levelpassed.tscn")
		return

	await get_tree().create_timer(1.0).timeout
	respawn()


func handle_miss():
	resetting = true

	if health_bar:
		health_bar.value -= DAMAGE_PER_MISS

		if health_bar.value <= 0:
			health_bar.value = health_bar.max_value
			Global.score = 0
			update_score_ui()
			ScreenManager.fail_level()
			return

	await explosion()
	visible = false

	await get_tree().create_timer(1.0).timeout
	respawn()


func explosion():
	moving = false
	sprite.play("explode")
	await sprite.animation_finished
	sprite.play("default")
	moving = true
