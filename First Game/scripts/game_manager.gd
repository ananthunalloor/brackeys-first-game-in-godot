extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func become_host():
	# This function will be called when the player becomes the host
	# You can add your logic here to handle the host state
	print("Player has become the host.")
	%MultiplayerHUD.hide()
	MultiplayerManager.become_host()

func join_as_player_2():
	# This function will be called when the player joins as player 2
	# You can add your logic here to handle the player 2 state
	print("Player has joined as player 2.")
	%MultiplayerHUD.hide()
	MultiplayerManager.join_as_player_2()
