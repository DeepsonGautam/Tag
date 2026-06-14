extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

var gap = 40.0
var tag_cooldown = 0.0
const TAG_COOLDOWN_TIME = 1.0

func _physics_process(delta):
	# cooldown timer
	if tag_cooldown > 0:
		tag_cooldown -= delta
		return

	var dist = player1.global_position.distance_to(player2.global_position)

	if dist < gap:
		if $Player1/Arrow.visible == true:
			$Player1/Arrow.visible = false
			$Player2/Arrow.visible = true
		elif $Player2/Arrow.visible == true:
			$Player2/Arrow.visible = false
			$Player1/Arrow.visible = true
	
		tag_cooldown = TAG_COOLDOWN_TIME
			
			
		
		
		
		
		
		
		
		
		
		
		
