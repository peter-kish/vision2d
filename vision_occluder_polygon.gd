extends Polygon2D
class_name VisionOccluderPolygon

@export var observer: Node2D
@export var shadow_color = Color.BLACK
@export var size = 128.0
@export var penetration = 32.0
@export var max_segment_size = 16.0;


func _ready() -> void:
    if polygon.size() < 3:
        return
        
    for i in range(polygon.size()):
        var occluder = VisionOccluder.new()
        occluder.start_point = polygon[i]
        occluder.end_point = polygon[(i + 1) % polygon.size()]
        occluder.observer = observer
        occluder.color = shadow_color
        occluder.size = size
        occluder.penetration = penetration
        occluder.max_segment_size = max_segment_size
        add_child(occluder)
