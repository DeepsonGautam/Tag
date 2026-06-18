extends Control

func _on_play_again_pressed() -> void:
	$Button.play()
	await $Button.finished
	get_tree().change_scene_to_file("res://Scene/world.tscn")
	
func _on_exit_pressed() -> void:
	$Button.play()
	await $Button.finished
	get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
