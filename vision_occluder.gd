extends Polygon2D
class_name VisionOccluder

@export var start_point: Vector2
@export var end_point: Vector2
@export var observer: Node2D
@export var size = 128.0
@export var penetration = 32.0


func _ready() -> void:
    var polygon_points = []
    polygon_points.resize(4)
    polygon = PackedVector2Array(polygon_points)


func _process(_delta: float) -> void:
    if !observer:
        return

    var local_obs_position = to_local(observer.global_position)

    var v1 = (start_point - local_obs_position).normalized()
    var v2 = (end_point - local_obs_position).normalized()
    var p1 = start_point + v1 * penetration
    var p2 = end_point + v2 * penetration
    var pd1 = p1 + v1 * size
    var pd2 = p2 + v2 * size

    polygon[0] = p1
    polygon[1] = p2
    polygon[2] = pd2
    polygon[3] = pd1
    
