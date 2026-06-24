extends Control



func _on_play_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://Scene/information.tscn")


func _on_exit_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().quit()
