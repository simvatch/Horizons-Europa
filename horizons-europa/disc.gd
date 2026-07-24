extends TextureRect

@export var speed = 400

var start_position: Vector2
var moving = false

func _ready():
	start_position = position

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			moving = true

func _process(delta):
	if moving:
		position.x += speed * delta
		if position.x >= get_viewport_rect().size.x:
			position = start_position
			moving = false
