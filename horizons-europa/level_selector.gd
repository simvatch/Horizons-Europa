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
	
	
func _on_level_3_pressed() -> void:
	var readybtn3 = Button.new()
	readybtn3.text = "Enter Level"
	readybtn3.pressed.connect(_readybtn3_pressed)
	readybtn3.position = Vector2(825, 900)  
	readybtn3.size = Vector2(160, 40)
	readybtn3.theme = btnTheme
	add_child(readybtn3)


func _readybtn3_pressed() -> void:
	get_tree().change_scene_to_file("res://level3.tscn")
	

	
	

func _readybtn2_pressed() -> void:
	get_tree().change_scene_to_file("res://level2.tscn")


func _on_left_pressed() -> void:
	$BoxContainer/CarouselContainer._left()



func _on_right_pressed() -> void:
	$BoxContainer/CarouselContainer._right()
