extends AnimatableBody2D

@export var animation_player_optionals: AnimationPlayer

func _on_player_connected():
	if not multiplayer.is_server():
		animation_player_optionals.stop()
		animation_player_optionals.set_active(false)

func _ready():
	if animation_player_optionals:
		multiplayer.peer_connected.connect(_on_player_connected)
		
