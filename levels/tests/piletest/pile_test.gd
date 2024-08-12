extends Node2D

@onready var pile: Pile = $Pile

@onready var game_card: GameCard = $GameCard

@onready var create_random_card: Button = $CreateRandomCard
@onready var create_from_this_card: Button = $CreateFromThisCard
@onready var remove_card_at: Button = $RemoveCardAt
@onready var line_edit: LineEdit = $LineEdit
@onready var populate: Button = $Populate
@onready var line_edit_2: LineEdit = $LineEdit2

@onready var label: Label = $Label

func _ready() -> void:
	create_random_card.pressed.connect(func():
		pile.comp_create_card.create_card_from_data(GameCards.get_random_card_data())
	)
	
	create_from_this_card.pressed.connect(func():
		pile.comp_create_card.create_card_from_gamecard(game_card)
	)
	
	remove_card_at.pressed.connect(func():
		pile.comp_create_card.delete_card(int(line_edit.text))
	)
	
	populate.pressed.connect(func():
		var how_many :int = int(line_edit_2.text)
		var c_data_arr :Array[CardData] = []
		for i in range(how_many):
			c_data_arr.append(GameCards.get_random_card_data())
		pile.comp_populate.populate_from_datas(c_data_arr)
	)
	
	pile.comp_register_card.card_count_changed.connect(func(nr_of_cards :int):
		label.text = "%d" % [nr_of_cards]
	)
	
	#pile.comp_register_card.card_registered.connect(func(pile_card :PileCard):
		#pile_card.comp_glow.glowing = true
	#)
	
	pile.comp_populate.pile_populated.connect(func(nr :int, time_elapsed :float):
		print("populated %d cards in %f second%s" % [nr, time_elapsed,"s" if time_elapsed != 1 else ""] )
	)
