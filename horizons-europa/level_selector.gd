extends Node2D
var btnTheme = preload("res://button.tres")

func _on_level_1_pressed() -> void:
	var readybtn1 = Button.new()
	readybtn1.text = "Enter Level"
	readybtn1.pressed.connect(_readybtn1_pressed)
	readybtn1.position = Vector2(825, 900)  # wherever you want it
	readybtn1.size = Vector2(160, 40)
	readybtn1.theme = btnTheme
	add_child(readybtn1)
	

func _readybtn1_pressed() -> void:
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_level_2_pressed() -> void:
	var readybtn2 = Button.new()
	readybtn2.text = "Enter Level"
	readybtn2.pressed.connect(_readybtn2_pressed)
	readybtn2.position = Vector2(825, 900)  
	readybtn2.size = Vector2(160, 40)
	readybtn2.theme = btnTheme
	add_child(readybtn2)
	
	

func _readybtn2_pressed() -> void:
	get_tree().change_scene_to_file("res://level2.tscn")

func _on_left_pressed() -> void:
	$BoxContainer/CarouselContainer._left()



func _on_right_pressed() -> void:
	$BoxContainer/CarouselContainer._right()
