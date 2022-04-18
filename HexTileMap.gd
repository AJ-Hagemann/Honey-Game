extends TileMap

onready var CenterHex = tile_set.tile_get_texture(0).get_size()/2

func _ready():
	position -= CenterHex
	

func FindCell(Mousepos):
	Mousepos += CenterHex
	var LeftHand = true
	var Cell = world_to_map(Mousepos)
	var DangerRows = tile_set.tile_get_texture(0).get_size().y - cell_size.y
	var LocalMousepos = Mousepos - map_to_world(Cell)
	if LocalMousepos.y < DangerRows:
		var TopMiddleofCell = cell_size.x/2
		var GradientofDangerLine = DangerRows / TopMiddleofCell
		var XPostoCheck = LocalMousepos.x
		if XPostoCheck > TopMiddleofCell:
			XPostoCheck = cell_size.x - XPostoCheck
			LeftHand = false
		if(DangerRows - LocalMousepos.y) > GradientofDangerLine*XPostoCheck:
			if LeftHand:
				if fmod(Cell.y, 2) == 0:
					Cell += Vector2(-1,-1)
				else:
					Cell += Vector2(0,-1)
			else:
				if fmod(Cell.y, 2) == 0:
					Cell += Vector2(0,-1)
				else:
					Cell += Vector2(1,-1)
	return Cell
