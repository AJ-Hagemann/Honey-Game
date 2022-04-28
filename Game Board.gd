extends Node2D

onready var cam = $GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var plabel = $HUD/HBoxContainer/PlayerLabel
onready var spaceLabel = $HUD/HBoxContainer/SpaceLabel
onready var moveBtn = $HUD/HBoxContainer/MoveButton
onready var endBtn = $HUD/HBoxContainer/EndTurn
var rng = RandomNumberGenerator.new()
#Create Var of the player1 and player2 pollen and honey counters
var PollenP1 = 0
var HoneyP1 = 0
var PollenP2 = 0
var HoneyP2 = 0

var nextPlayer = ["", "Player 2", "Player 1"]
var currPlayerIdx = 1
# Called when the node enters the scene tree for the first time.

	
	
	
func _ready():
	rng.randomize()
	move_camera(p1)
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	PollenP1 = 0
	PollenP2 = 0
	HoneyP1 = 0
	HoneyP2 = 0
	$HUD/HBoxContainer2/PollenScore.text = str(PollenP1)
	$HUD/HBoxContainer3/PollenScore2.text = str(PollenP2)
	$HUD/HBoxContainer2/HoneyScore.text = str(HoneyP1)
	$HUD/HBoxContainer3/HoneyScore2.text = str(HoneyP2)
	$HUD/ColorRect.hide()
	

# moves camera to parent
func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)

func update_label():
	plabel.text = GameState.currentPlayerLabel

func update_spaceLabel(space):
	spaceLabel.text = str(space)	

func _on_MoveButton_pressed():
	moveBtn.disabled = true
	GameState.currentPlayer.move(rng.randi_range(1,6))
	yield(GameState.currentPlayer, 'movedone')
	moveBtn.visible = false
	endBtn.visible = true
	
	if GameState.currentPlayer.space%2 == 0: 
		if currPlayerIdx == 1:
			PollenP1 += 1
			$HUD/HBoxContainer2/PollenScore.text = str(PollenP1)
		
	if $HUD/HBoxContainer2/PollenScore.text == "3":
		HoneyP1 += 1
		PollenP1 = 0
		$HUD/HBoxContainer2/PollenScore.text = str(PollenP1)
		$HUD/HBoxContainer2/HoneyScore.text = str(HoneyP1)
		
	if GameState.currentPlayer.space%2 == 0: 
		if currPlayerIdx == 2:
			PollenP2 += 1
			$HUD/HBoxContainer3/PollenScore2.text = str(PollenP2)
		
	if $HUD/HBoxContainer3/PollenScore2.text == "3":
		HoneyP2 += 1
		PollenP2 = 0
		$HUD/HBoxContainer3/PollenScore2.text = str(PollenP2)
		$HUD/HBoxContainer3/HoneyScore2.text = str(HoneyP2)
		
	if GameState.currentPlayer.space <= 0: 
		if $HUD/HBoxContainer2/P1Honey.text == "3":
			Win_game()
			print("gi")
	if GameState.currentPlayer.space <= 0: 
		if $HUD/HBoxContainer3/P2Honey.text == "3":
			Win_game()		
			print("HI")
		
		
	
		


func _on_EndTurn_pressed():
	$HUD/TurnSwitch/VBoxContainer/Label.text = nextPlayer[currPlayerIdx] + "'s Turn"
	$HUD/TurnSwitch.visible = true


func _on_Button_pressed():
	GameState.currentPlayerLabel = nextPlayer[currPlayerIdx]
	match currPlayerIdx:
		1:
			GameState.currentPlayer = p2
			currPlayerIdx = 2
		2:
			GameState.currentPlayer = p1
			currPlayerIdx = 1
	update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	move_camera(GameState.currentPlayer)
	endBtn.visible=false
	moveBtn.visible=true
	moveBtn.disabled=false
	$HUD/TurnSwitch.visible=false
	

func Win_game():
	$HUD/ColorRect.show()



