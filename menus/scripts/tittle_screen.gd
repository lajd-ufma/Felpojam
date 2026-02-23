extends Control

func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/playground.tscn")


func _on_credits_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits_screen.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
