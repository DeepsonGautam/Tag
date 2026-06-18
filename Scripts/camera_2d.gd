extends Camera2D
@export var move_speed = 0.5
@export var zoom_speed = 0.05
@export var min_zoom = 0.3
@export var max_zoom = 5.0
@export var margin = Vector2(400, 200)
var targets = []
@onready var screen_size = get_viewport_rect().size
func add_target(t):
	if not t in targets:
		targets.append(t)
func remove_target(t):
	if t in targets:
		targets.erase(t)
func _calculate_zoom(center: Vector2) -> float:
	var r = Rect2(center, Vector2.ONE)
	for target in targets:
		r = r.expand(target.global_position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	if r.size.x > r.size.y * screen_size.aspect():
		return clamp(screen_size.x / r.size.x, min_zoom, max_zoom)
	else:
		return clamp(screen_size.y / r.size.y, min_zoom, max_zoom)
func snap_to_targets():
	if targets.is_empty():
		return
	var p = Vector2.ZERO
	for target in targets:
		print(target.name, " at ", target.global_position)
		p += target.global_position
	p /= targets.size()
	print("Calculated midpoint: ", p)
	global_position = p
	zoom = Vector2.ONE * _calculate_zoom(global_position)
func _process(delta):
	if targets.is_empty():
		return
	var p = Vector2.ZERO
	for target in targets:
		p += target.global_position
	p /= targets.size()
	global_position = lerp(global_position, p, move_speed)
	var z = _calculate_zoom(global_position)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)
