extends CanvasLayer


func _ready() -> void:
    var dir := DirAccess.open("res://examples")
    if dir:
        dir.list_dir_begin()
        var filename = dir.get_next()
        while filename != "":
            if filename.begins_with("test") and filename.ends_with(".tscn") and filename != "test_ui.tscn":
                var button := Button.new()
                button.text = filename
                if get_tree().current_scene.scene_file_path.contains(filename):
                    button.disabled = true
                button.pressed.connect(func():
                    get_tree().change_scene_to_file("res://examples/" + filename)
                )
                $VBoxContainer.add_child(button)
            filename = dir.get_next()
