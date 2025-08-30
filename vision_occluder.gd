extends Node2D
class_name VisionOccluder

@export var start_point: Vector2
@export var end_point: Vector2
@export var observer: Node2D
@export var color = Color.BLACK
@export var size = 128.0
@export var offset = 32.0

var _polygon: Polygon2D


func _ready() -> void:
    var polygon_points = []
    polygon_points.resize(4)

    _polygon = Polygon2D.new()
    _polygon.polygon = PackedVector2Array(polygon_points)
    _polygon.color = color

    add_child(_polygon)


func _process(_delta: float) -> void:
    if !observer:
        return

    var local_obs_position = to_local(observer.global_position)

    var v1 = (start_point - local_obs_position).normalized()
    var v2 = (end_point - local_obs_position).normalized()
    var p1 = start_point + v1 * offset
    var p2 = end_point + v2 * offset
    var pd1 = p1 + v1 * size
    var pd2 = p2 + v2 * size

    _polygon.polygon[0] = p1
    _polygon.polygon[1] = p2
    _polygon.polygon[2] = pd2
    _polygon.polygon[3] = pd1
    
