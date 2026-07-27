extends Node2D


func _start_level(level_number: int) -> void:
	Global.level = level_number
	Global.score = 0
	get_tree().change_scene_to_file("res://level%d.tscn" % level_number)


func _on_level_1_pressed() -> void:
	_start_level(1)


func _on_level_2_pressed() -> void:
	_start_level(2)


func _on_level_3_pressed() -> void:
	_start_level(3)


func _on_left_pressed() -> void:
	$BoxContainer/CarouselContainer._left()


func _on_right_pressed() -> void:
	$BoxContainer/CarouselContainer._right()
