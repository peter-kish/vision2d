extends Node2D


func _process(_delta: float) -> void:
    if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        global_position = get_global_mouse_position()
