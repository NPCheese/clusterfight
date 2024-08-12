extends Node

enum CardColor {
	RED, WHITE, ORANGE, YELLOW, PINK,
	DARK_PINK, PURPLE, TEAL, LIGHT_BLUE, GREEN,
	LIGHT_GREEN, SATURATED_PINK, SATURATED_GREEN, SOFT_YELLOW
}

enum CardClass {
	ACTION, ITEM, WEAPON, META
}

enum CardFlags {
	ENDS_CURRENT_TURN, ENDS_ALL_TURNS, TARGET_GOES_TWICE,
	REVERSES_ORDER_OF_PLAY, AFFECTS_ORDER, PUTS_A_CARD_ON_BOTTOM,
	SELF_LOSE_HAND, SELF_INCREASE_HAND, SELF_DECREASE_HAND,
	SELF_MODIFY_HAND, ANOTHER_MODIFY_HAND, MODIFY_ALL_HANDS,
	ANOTHER_DECREASE_HAND, DECREASE_ALL_HANDS, TARGETS_A_PLAYER,
	BLINDS_A_PLAYER, MODIFIES_DRAW_PILE, MODIFIES_DRAW_PILE_SEVERELY,
	REVEALS_INFO, REVEALS_DRAWPILE_INFO, REVEALS_PLAYERHAND_INFO,
	COPIES_TOP_CARD, SPLITS_DRAWPILE_HALF, STEALS_CARD, STEALS_CARD_TWICE,
	PROTECTS_AGAINST_BOMBS, EFFECTIVE_UNTIL_TURN_AGAIN, SHUFFLES_DRAWPILE,
	SHUFFLES_INTO_DRAWPILE, SHUFFLES_SEPARATEDISCARD_INTO_DRAWPILE,
	SHUFFLES_BOMBS_INTO_DRAWPILE, SHUFFLES_DEFUSES_INTO_DRAWPILE,
	GRABS_DISCARDED_BOMB, GRABS_DISCARDED_DEFUSE, PLAYABLE_OUT_OF_TURN,
	MODIFIES_DEAD_HAND, REJECTS_CARD, REJECTS_FUTURE_CARD, SABOTAGES_DEFUSING,
	REVIVES_DEAD_PLAYER, SWAPS_TOP_BOTTOM, DRAWS_BOTTOM_CARD, AVOIDS_TOP_DRAWCARD,
	INCREASES_BOMBCOUNT, INCREASES_DEFUSECOUNT, BOMBS_PLAYER
}

const GameCardScene = preload("res://prefabs/cards/gamecard/GameCard.tscn")
const HandCardScene = preload("res://prefabs/cards/handcard/HandCard.tscn")
const PileCardScene = preload("res://prefabs/cards/pilecard/PileCard.tscn")

# 🔑String -> 📦CardData
var CARDS :Dictionary = {}

# 🔑CardColor -> 📦Color
var CardColors: Dictionary = {
	CardColor.RED: Color("ff0000"), CardColor.WHITE: Color("ffffff"), CardColor.ORANGE: Color("ff6e00"),
	CardColor.YELLOW: Color("edf500"), CardColor.PINK: Color("de00c9"), CardColor.DARK_PINK: Color("ed5878"),
	CardColor.PURPLE: Color("b53bef"), CardColor.TEAL: Color("19f4df"), CardColor.LIGHT_BLUE: Color("1ba6ed"),
	CardColor.GREEN: Color("00ff00"), CardColor.LIGHT_GREEN: Color("18fa80"), CardColor.SATURATED_PINK: Color("e8c1de"),
	CardColor.SATURATED_GREEN: Color("d2eda2"), CardColor.SOFT_YELLOW: Color("ffde6d")
}

func _ready() -> void:
	_populate_cards_dictionary()

func get_random_card_data() -> CardData:
	if CARDS.size() > 0:
		return CARDS.values().pick_random()
	printerr("❌{📚} CARDS dictionary empty. Returning null")
	return null

func _populate_cards_dictionary() -> void:
	var resources_path: String = "res://scripts/resources/card_data/"
	var resources = Array(DirAccess.get_files_at(resources_path))
	for file_name: String in resources:
		file_name = file_name.get_slice(".", 0)
		CARDS[file_name.to_upper()] = load("%s%s.tres" % [resources_path, file_name])
