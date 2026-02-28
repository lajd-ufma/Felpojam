extends Control

func _on_start_btn_pressed() -> void:
	MusicManger.start()
	get_tree().change_scene_to_file("res://levels/level1.tscn")


func _on_credits_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits_screen.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
