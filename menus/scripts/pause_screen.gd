extends CanvasLayer

@onready var resume_button: Button = $BGOverlay/MenuHolder/ResumeButton
@onready var quit_button: Button = $BGOverlay/MenuHolder/QuitButton
@onready var animator: AnimationPlayer = $Animator


func _ready() -> void:
	visible = false


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		animator.play("pause_game")
		get_tree().paused = true
		resume_button.grab_focus()


func _on_resume_button_pressed() -> void:
	animator.play("resume_game")
	get_tree().paused = false
	await animator.animation_finished
	visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
