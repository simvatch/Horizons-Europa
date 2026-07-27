extends Node

var last_level_path: String = ""

func fail_level():
	last_level_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://levelfailed.tscn")

func retry_current_level():
	if last_level_path != "":
		Global.score = 0
		get_tree().change_scene_to_file(last_level_path)

func go_to(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
