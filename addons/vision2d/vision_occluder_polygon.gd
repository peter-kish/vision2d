@icon("res://addons/vision2d/icons/vision2d_vision_occluder_polygon.svg")
extends Polygon2D
class_name VisionOccluderPolygon

const _VisionOccluder = preload("vision_occluder.gd")

@export var observer: Node2D : set = _set_observer
@export var shadow_color := Color.BLACK : set = _set_shadow_color
@export var size := 128.0 : set = _set_size
@export var penetration := 32.0 : set = _set_penetration
@export var max_segment_size := 16.0 : set = _set_max_segment_size


func _set_observer(new_observer: Node2D) -> void:
    observer = new_observer
    for c in get_children():
        if c is _VisionOccluder:
            (c as _VisionOccluder).observer = observer


func _set_shadow_color(new_shadow_color: Color) -> void:
    shadow_color = new_shadow_color
    for c in get_children():
        if c is _VisionOccluder:
            (c as _VisionOccluder).shadow_color = shadow_color


func _set_size(new_size: float) -> void:
    size = new_size
    for c in get_children():
        if c is _VisionOccluder:
            (c as _VisionOccluder).size = size


func _set_penetration(new_penetration: float) -> void:
    penetration = new_penetration
    for c in get_children():
        if c is _VisionOccluder:
            (c as _VisionOccluder).penetration = penetration


func _set_max_segment_size(new_max_segment_size: float) -> void:
    max_segment_size = new_max_segment_size
    for c in get_children():
        if c is _VisionOccluder:
            (c as _VisionOccluder).max_segment_size = max_segment_size


func _ready() -> void:
    if polygon.size() < 3:
        return
        
    for i in range(polygon.size()):
        var occluder = _VisionOccluder.new()
        occluder.start_point = polygon[i]
        occluder.end_point = polygon[(i + 1) % polygon.size()]
        occluder.observer = observer
        occluder.color = shadow_color
        occluder.size = size
        occluder.penetration = penetration
        occluder.max_segment_size = max_segment_size
        add_child(occluder)
