extends Node2D

func _input(event):
	if event.is_action_released("leftclick"):
		print($HexTileMap.FindCell(get_global_mouse_position()))
