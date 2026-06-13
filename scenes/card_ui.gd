extends Panel

@export var data: CardData

@onready var nameCard = $VBoxContainer/NameLabel
@onready var costCard = $VBoxContainer/CostLabel
@onready var descCard = $VBoxContainer/Description

var selected := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	if data:
		nameCard.text = data.card_name
		costCard.text = str(data.cost)
		descCard.text = str(data.description)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("CARD CLICKED")
		var battle_manager = get_tree().get_first_node_in_group("battle_manager")
		battle_manager.select_card(self)

func set_selected(value: bool):
	selected = value
	if selected:
		position.y = -20
	else:
		position.y = 0
