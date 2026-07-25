extends Area2D

var can_interact = false

func _ready() -> void:
	self.area_entered.connect(on_body_entered)
	self.area_entered.connect(on_body_exited)
	
func on_body_entered(body):
	if body.is_in_group("monster_1_area"):
		print("kill line interact")
		can_interact = true

func on_body_exited(body):
	if body.is_in_group("monster_1_area"):
		can_interact = false
