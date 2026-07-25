extends Node2D

@export var speed = 400
@export var rotation_speed = 5.0
@export var lane_cooldown_time = 0.2

var start_position = 155
var moving = false
var lane = 2
var lane_cooldown = 0.0

func _ready():
	start_position = position

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			moving = true
		
		if event.pressed and event.keycode == KEY_UP and !moving and lane_cooldown <= 0:
			if lane == 2:
				position.y = 343
				lane = 1
				lane_cooldown = lane_cooldown_time
			elif lane == 3:
				position.y = 499
				lane = 2
				lane_cooldown = lane_cooldown_time
			elif lane == 4:
				position.y = 650
				lane = 3
				lane_cooldown = lane_cooldown_time

		if event.pressed and event.keycode == KEY_DOWN and !moving and lane_cooldown <= 0:
			if lane == 1:
				position.y = 499
				lane = 2
				lane_cooldown = lane_cooldown_time
			elif lane == 2:
				position.y = 650
				lane = 3
				lane_cooldown = lane_cooldown_time
			elif lane == 3:
				position.y = 808
				lane = 4
				lane_cooldown = lane_cooldown_time


func _process(delta):
	if lane_cooldown > 0:
		lane_cooldown -= delta
	if moving:
		position.x -= speed * delta
		
		if position.x <= 0:
			position = start_position
			rotation = 0
			moving = false
