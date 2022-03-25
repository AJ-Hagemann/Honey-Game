extends Sprite

const speed = 400
var path setget set_path

func _ready():
	set_process(false)
	
func set_path(value:PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
func _process(delta):
	move_along_path(speed * delta)
	
	
func move_along_path(distance):
	var start = position
	while distance > 0 and path.size() != 0:
		var dist_to_next = start.distance_to(path[0])
		if distance <= dist_to_next:
			position = start.linear_interpolate(path[0], distance / dist_to_next)
			return
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			return
		distance -= dist_to_next
		start = path[0]
		path.remove(0)
	set_process(false)
