extends Node2D

@onready var player1 = $Player1
@onready var player2 = $Player2

var tag_cooldown = 0.0
const TAG_COOLDOWN_TIME = 0.5

func _ready():
	$MultiCamera.add_target($Player1)
	$MultiCamera.add_target($Player2)
	$MultiCamera.make_current()
	$MultiCamera.snap_to_targets()
	
	$Player1/HitBox.body_entered.connect(_on_player1_area_entered)
	
	$Player2/HitBox.body_entered.connect(_on_player2_area_entered)

func _on_player1_area_entered(body):
	if body == player2 and tag_cooldown <= 0:
		if $Player2/Arrow.visible == true:
			$Tagged.play()
			Global.player_1 = true
			Global.player_2 = false
			$Player2/Arrow.visible = false
			$Player1/Arrow.visible = true
			tag_cooldown = TAG_COOLDOWN_TIME

func _on_player2_area_entered(body):
	if body == player1 and tag_cooldown <= 0:
		if $Player1/Arrow.visible == true:
			$Tagged.play()
			Global.player_1 = false
			Global.player_2 = true
			$Player1/Arrow.visible = false
			$Player2/Arrow.visible = true
			tag_cooldown = TAG_COOLDOWN_TIME

func _physics_process(delta):
	if tag_cooldown > 0:
		tag_cooldown -= delta
