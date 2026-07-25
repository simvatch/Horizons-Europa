extends Node2D

@export var speed := 400.0
@export var lane_cooldown_time := 0.2
@export_range(1, 4) var lane := 2

const LANE_Y = [343.0, 499.0, 650.0, 807.0]

var moving := false
var lane_cooldown := 0.0
var start_position: Vector2

func _ready():
	start_position = position
	position.y = LANE_Y[lane - 1]

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE and !moving:
			moving = true
			return

		if moving or lane_cooldown > 0:
			return

		if event.keycode == KEY_UP:
			move_up()
		elif event.keycode == KEY_DOWN:
			move_down()

func move_up():
	if lane > 1:
		lane -= 1
		position.y = LANE_Y[lane - 1]
		lane_cooldown = lane_cooldown_time


func move_down():
	if lane < 4:
		lane += 1
		position.y = LANE_Y[lane - 1]
		lane_cooldown = lane_cooldown_time


func _process(delta):
	if lane_cooldown > 0:
		lane_cooldown -= delta

	if moving:
		position.x -= speed * delta

		if position.x <= 0:
			position = start_position
			position.y = LANE_Y[lane - 1]
			moving = false
