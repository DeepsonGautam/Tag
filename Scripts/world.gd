extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

var gap = 40.0
var tag_cooldown = 0.0
const TAG_COOLDOWN_TIME = 0.5

func _ready():
	$MultiCamera.add_target($Player1)
	$MultiCamera.add_target($Player2)
	$MultiCamera.make_current()
	$MultiCamera.snap_to_targets()
	
	#var r = get_used_rect()
	#$MultiCamera.limit_left = r.position.x * cell
	#$MultiCamera.limit_right = r.end.x * cell_s  






func _physics_process(delta):
	
	if tag_cooldown > 0:
		tag_cooldown -= delta
		return

	var dist = player1.global_position.distance_to(player2.global_position)

	if dist < gap:
		if $Player1/Arrow.visible == true:
			$Player1/Arrow.visible = false
			Global.player_1 = false
			Global.player_2 = true
			$Player2/Arrow.visible = true
		elif $Player2/Arrow.visible == true:
			Global.player_1 = true
			Global.player_2 = false
			$Player2/Arrow.visible = false
			$Player1/Arrow.visible = true
	
		tag_cooldown = TAG_COOLDOWN_TIME
			
			
	
