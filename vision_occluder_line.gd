extends Line2D

@export var observer: Node2D
@export var color = Color.BLACK
@export var size = 128.0
@export var penetration = 32.0
@export var extra_vertices = 0;


func _ready() -> void:
    if points.size() < 2:
        return
        
    for i in range(points.size() - 1):
        var occluder = VisionOccluder.new()
        occluder.start_point = points[i]
        occluder.end_point = points[i + 1]
        occluder.observer = observer
        occluder.color = color
        occluder.size = size
        occluder.penetration = penetration
        occluder.extra_vertices = extra_vertices
        add_child(occluder)
