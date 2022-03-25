extends Node2D

onready var nav2d = $Navigation2D
onready var character = $Character

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		print(event.global_position, $Navigation2D/HexTileMap.world_to_map(event.global_position))
		return

# note, can use global_position here; the video explains why you may want to do that
	character.path = nav2d.get_simple_path(character.position, event.global_position)
