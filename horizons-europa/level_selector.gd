extends Node2D

func _ready() -> void:
	# Create audio players for each level
	var audio1 = AudioStreamPlayer.new()
	audio1.name = "Level1Audio"
	audio1.bus = "Master"
	audio1.stream = load("res://Level1.mp3")
	add_child(audio1)

	var audio2 = AudioStreamPlayer.new()
	audio2.name = "Level2Audio"
	audio2.bus = "Master"
	audio2.stream = load("res://Level2.mp3")
	add_child(audio2)

	var audio3 = AudioStreamPlayer.new()
	audio3.name = "Level3Audio"
	audio3.bus = "Master"
	audio3.stream = load("res://Level3.mp3")
	add_child(audio3)


func _on_level_1_pressed() -> void:
	$Level1Audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_level_2_pressed() -> void:
	$Level2Audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://level2.tscn")


func _on_level_3_pressed() -> void:
	$Level3Audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://level3.tscn")


func _on_left_pressed() -> void:
	$BoxContainer/CarouselContainer._left()


func _on_right_pressed() -> void:
	$BoxContainer/CarouselContainer._right()
