extends Node2D

var deck = []
var hand = []
var card_scene = preload("res://scenes/card_ui.tscn")
var selected_cards = []
const MAX_SELECTED_CARD = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_deck()
	draw_hand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_deck() -> void:
	deck = [
		preload("res://resources/cardsdata/slash.tres"),
		preload("res://resources/cardsdata/stab.tres"),
		preload("res://resources/cardsdata/double_stab.tres"),
		preload("res://resources/cardsdata/bandage.tres"),
		preload("res://resources/cardsdata/block.tres")
	]
	deck.shuffle()

func draw_hand():
	for i in range(deck.size()):
		if deck.is_empty():
			return
		
		var card_data = deck.pop_front()
		
		var card_ui = card_scene.instantiate()
		
		card_ui.data = card_data
		
		hand.append(card_ui)
		
		$CanvasLayer/BattleUI/CenterContainer/HandContainer.add_child(card_ui)

func select_card(card):
	
	if card.selected:
		selected_cards.erase(card)
		card.set_selected(false)
		return
	
	#if selected_cards.size() >= MAX_SELECTED_CARD:
		#return
	
	selected_cards.append(card)
	card.set_selected(true)
	
	print("Selected:", card.data.card_name)


func _on_execute_button_pressed() -> void:
	execute_turn() # Replace with function body.

func execute_turn():
	print("EXECUTE TURN")
	var zombie = get_tree().get_first_node_in_group("enemy")
	var player = get_tree().get_first_node_in_group("player")

	for card in selected_cards:
		print(card.data.card_name)
		print(card.data.damage)
		if(card.data.damage > 0):
			zombie.take_damage(card.data.damage)
			await player.play_attack()
			await zombie.play_hurt()
		if(card.data.heal > 0):
			player.heal(card.data.heal)
	
