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

func snap_to_targets():
	if targets.is_empty():
		return
	var p = Vector2.ZERO
	for target in targets:
		p += target.global_position
	p /= targets.size()
	global_position = p

func _process(delta):
	if targets.is_empty():
		return

	var p = Vector2.ZERO
	
	for target in targets:
		p += target.global_position
	p /= targets.size()
	
	global_position = lerp(global_position, p, move_speed)

	var r = Rect2(global_position, Vector2.ONE)
	
	for target in targets:
		r = r.expand(target.global_position)
	r = r.grow_individual(margin.x, margin.y,
							 margin.x, margin.y)

	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = clamp(screen_size.x / r.size.x,
					 min_zoom, max_zoom)
	else:
		z = clamp(screen_size.y / r.size.y, 
					min_zoom, max_zoom)

	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)
