extends Polygon2D

@export var start_point: Vector2
@export var end_point: Vector2
@export var observer: Node2D
@export var size = 128.0
@export var penetration = 32.0
@export var max_segment_size = 16.0;

class VisionVertices:
    var close: Vector2
    var far: Vector2


func _ready() -> void:
    var polygon_points = []
    polygon_points.resize(_get_total_vertices())
    polygon = PackedVector2Array(polygon_points)


func _process(_delta: float) -> void:
    if !observer:
        return

    var local_obs_position = to_local(observer.global_position)

    @warning_ignore("integer_division") var total_vertices_2 = _get_total_vertices() / 2
    for i in range(total_vertices_2):
        var mid_point = _get_mid_point(start_point, end_point, i, total_vertices_2 - 1)
        var vertices := _get_vision_vertices(mid_point, local_obs_position)
        polygon[i] = vertices.close
        polygon[_get_far_vertex_idx(i)] = vertices.far


func _get_vision_vertices(v: Vector2, from: Vector2) -> VisionVertices:
    var result = VisionVertices.new()
    var dir = (v - from).normalized()
    result.close = v + dir * penetration
    result.far = result.close + dir * size
    return result


func _get_far_vertex_idx(close_idx: int) -> int:
    return polygon.size() - close_idx - 1


func _get_mid_point(start: Vector2, end: Vector2, idx: int, max_idx: int) -> Vector2:
    return start + (end - start) * (float(idx) / float(max_idx))


func _get_extra_vertices() -> int:
    var distance = (end_point - start_point).length()
    if distance < 0.0 or max_segment_size <= 0.0:
        return 0
    return int(floor(distance / max_segment_size))


func _get_total_vertices() -> int:
    return (_get_extra_vertices() + 2) * 2
    
