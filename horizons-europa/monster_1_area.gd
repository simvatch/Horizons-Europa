extends Area2D

var can_interact = false

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func on_body_entered(body):
	if body.is_in_group("attack_area") or body.is_in_group("kill_line_area"):
		can_interact = true

func on_body_exited(body):
	if body.is_in_group("attack_area") or body.is_in_group("kill_line_area"):
		can_interact = false
