extends Node

const SERVER_PORT = 4242
const SERVER_IP = "127.0.0.1"

var multiplayer_scene = preload("res://scenes/multiplayer_player.tscn")

var _player_spawn_node
var host_mode_enabled = false
var multiplayer_mode_enabled = false
var respawn_point = Vector2(30, 20)

func become_host():
	print("Starting Host")

	_player_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	host_mode_enabled = true
	multiplayer_mode_enabled = true

	var server = ENetMultiplayerPeer.new()
	server.create_server(SERVER_PORT, 4)

	multiplayer.multiplayer_peer = server

	multiplayer.peer_connected.connect(_add_player)
	multiplayer.peer_disconnected.connect(_remove_player)

	_remove_single_player()
	_add_player(1)
	

func join_as_player_2():
	print("Connecting as player two")
	multiplayer_mode_enabled = true

	var client = ENetMultiplayerPeer.new()
	client.create_client(SERVER_IP, SERVER_PORT)

	multiplayer.multiplayer_peer = client
	_remove_single_player()

func _add_player(id):
	print("Player connected with ID: ", id)
	
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)

	_player_spawn_node.add_child(player_to_add, true)

func _remove_player(id):
	print("Player disconnected with ID: ", id)
	if not _player_spawn_node.has_node(str(id)):
		print("Player ID not found in the scene.")
		return
	_player_spawn_node.get_node(str(id)).queue_free()

func _remove_single_player():
	var player_to_remove = get_tree().get_current_scene().get_node("Player")
	player_to_remove.queue_free()
